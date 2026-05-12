import '/components/button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'succsed_enter_model.dart';
export 'succsed_enter_model.dart';

class SuccsedEnterWidget extends StatefulWidget {
  const SuccsedEnterWidget({super.key});

  static String routeName = 'succsedEnter';
  static String routePath = '/succsedEnter';

  @override
  State<SuccsedEnterWidget> createState() => _SuccsedEnterWidgetState();
}

class _SuccsedEnterWidgetState extends State<SuccsedEnterWidget> {
  late SuccsedEnterModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuccsedEnterModel());
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
          child: Stack(
          alignment: AlignmentDirectional(-1.0, -1.0),
          children: [
            Opacity(
              opacity: 0.05,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.grid_3x3_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 300.0,
                        ),
                      ].divide(SizedBox(width: 32.0)),
                    ),
                  ].divide(SizedBox(height: 32.0)),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Stack(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      children: [
                        Container(
                          width: 180.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primary30,
                              width: 1.0,
                            ),
                          ),
                        ),
                        Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).success50,
                              width: 1.0,
                            ),
                          ),
                        ),
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).success,
                            borderRadius: BorderRadius.circular(9999.0),
                            shape: BoxShape.rectangle,
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.check_rounded,
                            color: FlutterFlowTheme.of(context).onPrimary,
                            size: 60.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Вход выполнен',
                          textAlign: TextAlign.center,
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
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 320.0,
                          ),
                          child: Text(
                            'Добро пожаловать в Apex Ballistics. Ваш аккаунт успешно подтвержден. Теперь вы можете приступить к высокоточным расчетам.',
                            textAlign: TextAlign.center,
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
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Spacer(),
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          wrapWithModel(
                            model: _model.buttonModel,
                            updateCallback: () => safeSetState(() {}),
                            child: ButtonWidget(
                              content: 'ПЕРЕЙТИ К РАСЧЕТАМ',
                              icon_present: false,
                              icon_end_present: false,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              variant: 'primary',
                              size: 'large',
                              full_width: true,
                              loading: false,
                              disabled: false,
                              onPressed: () async {
                                context.goNamed('shootPage');
                              },
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                child: Container(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40.0,
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                      Icon(
                                        Icons.help,
                                        color: FlutterFlowTheme.of(context)
                                            .accent3,
                                        size: 12.0,
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ].divide(SizedBox(height: 32.0)),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
