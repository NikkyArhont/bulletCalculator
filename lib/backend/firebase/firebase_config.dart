import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAZbjbPV-rAHh3UHsbJ-9dXVUYEEp608m0",
            authDomain: "bullet-calculator-g2nezy.firebaseapp.com",
            projectId: "bullet-calculator-g2nezy",
            storageBucket: "bullet-calculator-g2nezy.firebasestorage.app",
            messagingSenderId: "111658630134",
            appId: "1:111658630134:web:f0e181573d6c239dfae5d7"));
  } else {
    await Firebase.initializeApp();
  }
}
