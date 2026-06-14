import '/components/button_widget.dart';
import '/components/social_button_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';
import '/main.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_localization/easy_localization.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  static String routeName = 'login';
  static String routePath = '/login';

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.textFieldModel.inputTextController?.addListener(() {
      safeSetState(() {});
    });

    authManager.handlePhoneAuthStateChanges(context);
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
          top: true,
          bottom: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: IntrinsicHeight(
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
                              Text(
                                'login.title'.tr(),
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      lineHeight: 1.1,
                                    ),
                              ),
                              Text(
                                'login.subtitle'.tr(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'login.phone_label'.tr(),
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                          lineHeight: 1.1,
                                        ),
                                  ),
                                  wrapWithModel(
                                    model: _model.textFieldModel,
                                    updateCallback: () =>
                                        safeSetState(() {}),
                                    child: TextFieldWidget(
                                      label: null,
                                      helper: null,
                                      hint: '+7 900 000 00 00',
                                      value: '+',
                                      leading_icon: Icon(
                                        Icons.phone_android_rounded,
                                      ),
                                      leading_icon_present: true,
                                      trailing_icon_present: false,
                                      border: Color(0x00000000),
                                      hint_color: 'hint',
                                      variant: 'outlined',
                                      error: false,
                                      height: 56.0,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [PhonePlusFormatter()],
                                    ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                              wrapWithModel(
                                model: _model.buttonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  content: 'login.get_code'.tr(),
                                  icon_present: false,
                                  icon_end_present: false,
                                  color: (_model.textFieldModel.inputTextController?.text.length ?? 0) >= 14
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context).secondaryText,
                                  variant: 'primary',
                                  size: 'large',
                                  full_width: true,
                                  loading: _model.isLoading,
                                  disabled: (_model.textFieldModel
                                              .inputTextController?.text.replaceAll(RegExp(r'\D'), '').length ??
                                          0) <
                                      10, // Must have at least 10 digits
                                  onPressed: () async {
                                    if (_model.isLoading) return;
                                    safeSetState(() => _model.isLoading = true);
                                    final digits = _model
                                        .textFieldModel.inputTextController.text
                                        .replaceAll(RegExp(r'\D'), '');
                                    final fullPhoneNumber = '+$digits';
                                    final phoneNumber = digits;

                                    try {
                                      final testNumbers = [
                                        '+79180000000',
                                        '+79181111111',
                                        '+79182222222',
                                        '+79183333333'
                                      ];

                                      if (testNumbers.contains(fullPhoneNumber)) {
                                        await authManager.beginPhoneAuth(
                                          context: context,
                                          phoneNumber: fullPhoneNumber,
                                          onCodeSent: (context) async {
                                            context.goNamed(
                                              'SMS',
                                              queryParameters: {
                                                'phoneNumber': phoneNumber,
                                              }.withoutNulls,
                                            );
                                          },
                                        );
                                      } else {
                                        final httpsCallable = FirebaseFunctions.instance.httpsCallable('sendSmsCode');
                                        await httpsCallable.call(<String, dynamic>{
                                          'phoneNumber': fullPhoneNumber,
                                        });
                                        context.goNamed(
                                          'SMS',
                                          queryParameters: {
                                            'phoneNumber': phoneNumber,
                                          }.withoutNulls,
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${'login.error_prefix'.tr()}${e.toString()}'),
                                        ),
                                      );
                                    } finally {
                                      if (mounted) {
                                        safeSetState(() => _model.isLoading = false);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Divider(
                                  height: 16.0,
                                  thickness: 1.0,
                                  indent: 0.0,
                                  endIndent: 0.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                'login.or'.tr(),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      lineHeight: 1.1,
                                    ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Divider(
                                  height: 16.0,
                                  thickness: 1.0,
                                  indent: 0.0,
                                  endIndent: 0.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.socialButtonModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: SocialButtonWidget(
                                  name: 'Google',
                                  provider:
                                      'https://cdn.simpleicons.org/google/111827.svg',
                                  onTap: () async {
                                    try {
                                      GoRouter.of(context).prepareAuthEvent();
                                      final user = await authManager.signInWithGoogle(context);
                                      if (user != null) {
                                        context.goNamedAuth('initPage', context.mounted);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('login.auth_cancelled'.tr())),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('${'login.auth_error'.tr()}$e')),
                                      );
                                    }
                                  },
                                ),
                              ),
                              wrapWithModel(
                                model: _model.socialButtonModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: SocialButtonWidget(
                                  name: 'Apple',
                                  provider:
                                      'https://cdn.simpleicons.org/apple/111827.svg',
                                  onTap: () async {
                                    GoRouter.of(context).prepareAuthEvent();
                                    final user = await authManager.signInWithApple(context);
                                    if (user != null) {
                                      context.goNamedAuth('initPage', context.mounted);
                                    }
                                  },
                                ),
                              ),
                              wrapWithModel(
                                model: _model.themeButtonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  content: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 'login.light_theme'.tr()
                                      : 'login.dark_theme'.tr(),
                                  icon: Icon(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Icons.light_mode_rounded
                                        : Icons.dark_mode_rounded,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    size: 20.0,
                                  ),
                                  icon_present: true,
                                  variant: 'ghost',
                                  size: 'medium',
                                  onPressed: () async {
                                    if (Theme.of(context).brightness ==
                                        Brightness.dark) {
                                      MyApp.of(context)
                                          .setThemeMode(ThemeMode.light);
                                    } else {
                                      MyApp.of(context)
                                          .setThemeMode(ThemeMode.dark);
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: DropdownButtonFormField<Locale>(
                                  value: context.locale,
                                  decoration: InputDecoration(
                                    labelText: 'language'.tr(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                      ),
                                    ),
                                  ),
                                  dropdownColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                  items: const [
                                    DropdownMenuItem(
                                      value: Locale('ru'),
                                      child: Text('Русский'),
                                    ),
                                    DropdownMenuItem(
                                      value: Locale('en'),
                                      child: Text('English'),
                                    ),
                                  ],
                                  onChanged: (Locale? newLocale) {
                                    if (newLocale != null) {
                                      context.setLocale(newLocale);
                                    }
                                  },
                                ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'login.terms_accept'.tr(),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
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
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: [
                                    Text(
                                      'login.terms_of_use'.tr(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                            decoration:
                                                TextDecoration.underline,
                                            lineHeight: 1.3,
                                          ),
                                    ),
                                    Text(
                                      'login.and'.tr(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                            lineHeight: 1.3,
                                          ),
                                    ),
                                    Text(
                                      'login.privacy_policy'.tr(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                            decoration:
                                                TextDecoration.underline,
                                            lineHeight: 1.3,
                                          ),
                                    ),
                                  ],
                                ),
                              ].divide(SizedBox(height: 4.0)),
                            ),
                          ),
                        ].divide(SizedBox(height: 24.0)),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PhonePlusFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldSelection, TextEditingValue newSelection) {
    var digits = newSelection.text.replaceAll(RegExp(r'\D'), '');
    var newText = '+' + digits;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
