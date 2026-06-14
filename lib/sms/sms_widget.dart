import '/components/button_widget.dart';
import '/components/pin_digit_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sms_model.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
export 'sms_model.dart';

class SmsWidget extends StatefulWidget {
  const SmsWidget({
    super.key,
    this.phoneNumber,
  });

  final String? phoneNumber;

  static String routeName = 'SMS';
  static String routePath = '/sms';

  @override
  State<SmsWidget> createState() => _SmsWidgetState();
}

class _SmsWidgetState extends State<SmsWidget> {
  late SmsModel _model;
  bool _hasError = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SmsModel());

    _model.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_model.timerSeconds > 0) {
        safeSetState(() {
          _model.timerSeconds--;
        });
      } else {
        _model.timer?.cancel();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _model.pinCodeFocusNode?.requestFocus();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: PopScope(
          canPop: !_model.isLoading,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor: Colors.transparent,
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: _model.isLoading
                          ? null
                          : () {
                              context.safePop();
                            },
                    ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'sms.title'.tr(),
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              font: GoogleFonts.spaceGrotesk(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontStyle,
                              lineHeight: 1.1,
                            ),
                      ),
                      Text(
                        'sms.sent_to'.tr(args: [widget.phoneNumber ?? '900 000-00-00']),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                              lineHeight: 1.4,
                            ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Stack(
                children: [
                  Opacity(
                    opacity: 0.0,
                    child: Container(
                      width: 1.0,
                      height: 1.0,
                      child: TextFormField(
                        controller: _model.pinCodeController,
                        focusNode: _model.pinCodeFocusNode,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 6,
                         onChanged: (_) => safeSetState(() {
                            _hasError = false;
                          }),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _model.pinCodeFocusNode?.requestFocus(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        wrapWithModel(
                          model: _model.pinDigitModel1,
                          updateCallback: () => safeSetState(() {}),
                           child: PinDigitWidget(
                             digit: _model.pinCodeController!.text.length > 0
                                 ? _model.pinCodeController!.text[0]
                                 : '',
                             active: _model.pinCodeController!.text.length == 0 && !_hasError,
                             error: _hasError,
                           ),
                        ),
                        wrapWithModel(
                          model: _model.pinDigitModel2,
                          updateCallback: () => safeSetState(() {}),
                           child: PinDigitWidget(
                             digit: _model.pinCodeController!.text.length > 1
                                 ? _model.pinCodeController!.text[1]
                                 : '',
                             active: _model.pinCodeController!.text.length == 1 && !_hasError,
                             error: _hasError,
                           ),
                        ),
                        wrapWithModel(
                          model: _model.pinDigitModel3,
                          updateCallback: () => safeSetState(() {}),
                           child: PinDigitWidget(
                             digit: _model.pinCodeController!.text.length > 2
                                 ? _model.pinCodeController!.text[2]
                                 : '',
                             active: _model.pinCodeController!.text.length == 2 && !_hasError,
                             error: _hasError,
                           ),
                        ),
                        wrapWithModel(
                          model: _model.pinDigitModel4,
                          updateCallback: () => safeSetState(() {}),
                           child: PinDigitWidget(
                             digit: _model.pinCodeController!.text.length > 3
                                 ? _model.pinCodeController!.text[3]
                                 : '',
                             active: _model.pinCodeController!.text.length == 3 && !_hasError,
                             error: _hasError,
                           ),
                        ),
                        wrapWithModel(
                          model: _model.pinDigitModel5,
                          updateCallback: () => safeSetState(() {}),
                           child: PinDigitWidget(
                             digit: _model.pinCodeController!.text.length > 4
                                 ? _model.pinCodeController!.text[4]
                                 : '',
                             active: _model.pinCodeController!.text.length == 4 && !_hasError,
                             error: _hasError,
                           ),
                        ),
                        wrapWithModel(
                          model: _model.pinDigitModel6,
                          updateCallback: () => safeSetState(() {}),
                           child: PinDigitWidget(
                             digit: _model.pinCodeController!.text.length > 5
                                 ? _model.pinCodeController!.text[5]
                                 : '',
                             active: _model.pinCodeController!.text.length == 5 && !_hasError,
                             error: _hasError,
                           ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_hasError)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                  child: Text(
                    'sms.invalid_code'.tr(),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(
                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).error,
                      letterSpacing: 0.0,
                      lineHeight: 1.3,
                    ),
                  ),
                ),
                  Container(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 16.0,
                        ),
                        Text(
                          'sms.resend_timer'.tr(args: [_model.timerSeconds.toString().padLeft(2, '0')]),
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                                lineHeight: 1.3,
                              ),
                        ),
                      ].divide(SizedBox(width: 4.0)),
                    ),
                  ),
                ].divide(SizedBox(height: 24.0)),
              ),
              wrapWithModel(
                model: _model.buttonModel,
                updateCallback: () => safeSetState(() {}),
                child: ButtonWidget(
                  content: 'sms.confirm'.tr(),
                  icon_present: false,
                  icon_end_present: false,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  variant: 'primary',
                  size: 'large',
                  full_width: true,
                  loading: _model.isLoading,
                  disabled: _model.pinCodeController!.text.length < 6,
                   onPressed: () async {
                    safeSetState(() {
                      _model.isLoading = true;
                      _hasError = false;
                    });
                    try {
                      String? uid;
                      String? email;
                      String? displayName;
                      String? phone;

                      final testNumbers = [
                        '+79180000000',
                        '+79181111111',
                        '+79182222222',
                        '+79183333333'
                      ];
                      final fullPhoneNumber = '+7${widget.phoneNumber}';

                      if (testNumbers.contains(fullPhoneNumber)) {
                        final baseUser = await authManager.verifySmsCode(
                          context: context,
                          smsCode: _model.pinCodeController!.text,
                        );
                        if (baseUser != null) {
                          uid = baseUser.uid;
                          email = baseUser.email;
                          displayName = baseUser.displayName;
                          phone = baseUser.phoneNumber;
                        }
                      } else {
                        final httpsCallable = FirebaseFunctions.instance.httpsCallable('verifySmsCode');
                        final response = await httpsCallable.call(<String, dynamic>{
                          'phoneNumber': fullPhoneNumber,
                          'code': _model.pinCodeController!.text,
                        });
                        final token = response.data['token'];
                        final userCredential = await FirebaseAuth.instance.signInWithCustomToken(token);
                        final fbUser = userCredential.user;
                        if (fbUser != null) {
                          uid = fbUser.uid;
                          email = fbUser.email;
                          displayName = fbUser.displayName;
                          phone = fbUser.phoneNumber;
                        }
                      }

                      if (uid != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .set({
                          'uid': uid,
                          'email': email,
                          'display_name': displayName,
                          'phone_number': phone,
                          'created_time': FieldValue.serverTimestamp(),
                        }, SetOptions(merge: true));

                        context.goNamedAuth('Subscribe', context.mounted);
                      } else {
                        // Wrong code — show inline error
                        safeSetState(() {
                          _hasError = true;
                        });
                      }
                    } catch (_) {
                      safeSetState(() {
                        _hasError = true;
                      });
                    } finally {
                      safeSetState(() {
                        _model.isLoading = false;
                      });
                    }
                  },
                ),
              ),
              Spacer(),
            ].divide(SizedBox(height: 32.0)),
            ),
          ),
        ),
        ),
      ),
    );
  }
}
