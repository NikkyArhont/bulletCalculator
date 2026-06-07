const functions = require("firebase-functions");
const admin = require("firebase-admin");
const axios = require("axios");

admin.initializeApp();

// Configuration for REDSMS (User must set this later or we can hardcode for testing)
// Best practice is to use Firebase Environment config:
// firebase functions:config:set redsms.login="login" redsms.api_key="api_key"
const REDSMS_LOGIN = process.env.REDSMS_LOGIN || "YOUR_REDSMS_LOGIN";
const REDSMS_API_KEY = process.env.REDSMS_API_KEY || "YOUR_REDSMS_API_KEY";
const REDSMS_SENDER = process.env.REDSMS_SENDER || "REDSMS.RU";

/**
 * Cloud Function to generate OTP and send via REDSMS
 */
exports.sendSmsCode = functions.https.onCall(async (data, context) => {
  const phoneNumber = data?.phoneNumber || data?.data?.phoneNumber;
  console.log("sendSmsCode called. phone:", phoneNumber);
  if (!phoneNumber) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Phone number is required."
    );
  }

  // 1. Generate 6 digit OTP
  const otpCode = Math.floor(100000 + Math.random() * 900000).toString();
  const expiresAt = admin.firestore.Timestamp.fromMillis(Date.now() + 5 * 60 * 1000); // 5 minutes

  // 2. Save OTP to Firestore
  await admin.firestore().collection("otp_codes").doc(phoneNumber).set({
    code: otpCode,
    expiresAt: expiresAt,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // 3. Send SMS via REDSMS API
  try {
    const text = `Код для входа в приложение Баллистический калькулятор: ${otpCode}`;
    const crypto = require('crypto');
    const ts = Math.floor(Date.now() / 1000).toString();
    const secret = crypto.createHash('md5').update(ts + REDSMS_API_KEY).digest('hex');

    const response = await axios.post(
      "https://cp.redsms.ru/api/message",
      {
        to: phoneNumber.replace("+", ""),
        text: text,
        from: REDSMS_SENDER,
        route: "sms",
      },
      {
        headers: {
          "Content-Type": "application/json",
          login: REDSMS_LOGIN,
          ts: ts,
          secret: secret
        },
        timeout: 5000 // 5 seconds timeout to prevent hanging on Spark plan
      }
    );
    
    console.log(`SMS sent to ${phoneNumber}:`, response.data);
    return { success: true, message: "SMS sent successfully" };
  } catch (error) {
    const errorDetails = error.response?.data ? JSON.stringify(error.response.data) : error.message;
    console.error("Error sending REDSMS:", errorDetails);
    throw new functions.https.HttpsError(
      "unknown",
      `REDSMS Error: ${errorDetails}`
    );
  }
});

/**
 * Cloud Function to verify OTP and return a Custom Token
 */
exports.verifySmsCode = functions.https.onCall(async (data, context) => {
  const phoneNumber = data?.phoneNumber || data?.data?.phoneNumber;
  const code = data?.code || data?.data?.code;
  console.log("verifySmsCode called. phone:", phoneNumber, "code:", code);

  if (!phoneNumber || !code) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Phone number and code are required."
    );
  }

  const docRef = admin.firestore().collection("otp_codes").doc(phoneNumber);
  const docSnap = await docRef.get();

  if (!docSnap.exists) {
    throw new functions.https.HttpsError("not-found", "No OTP requested for this number.");
  }

  const otpData = docSnap.data();

  if (otpData.code !== code) {
    throw new functions.https.HttpsError("permission-denied", "Invalid OTP code.");
  }

  if (otpData.expiresAt.toMillis() < Date.now()) {
    throw new functions.https.HttpsError("deadline-exceeded", "OTP code expired.");
  }

  // OTP is valid. Generate Custom Token
  try {
    // We can use the phone number as the UID, or we can look up an existing user
    // In Firebase Auth, phone numbers should be in E.164 format (e.g. +79001234567)
    let userRecord;
    try {
      userRecord = await admin.auth().getUserByPhoneNumber(phoneNumber);
    } catch (e) {
      if (e.code === 'auth/user-not-found') {
        // Create new user
        userRecord = await admin.auth().createUser({
          phoneNumber: phoneNumber,
        });
      } else {
        throw e;
      }
    }

    const customToken = await admin.auth().createCustomToken(userRecord.uid);
    
    // Cleanup OTP
    await docRef.delete();

    return { success: true, token: customToken };
  } catch (error) {
    console.error("Error generating custom token:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to authenticate user."
    );
  }
});
