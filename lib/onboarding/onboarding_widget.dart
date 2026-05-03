import '/components/button_widget.dart';
import '/components/onboarding_step_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'onboarding_model.dart';
export 'onboarding_model.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  static String routeName = 'onboarding';
  static String routePath = '/onboarding';

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  late OnboardingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingModel());
    _model.pageViewController ??= PageController(initialPage: 0);
    _model.pageViewController!.addListener(() {
      if (mounted) safeSetState(() {});
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
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.circular(8.0),
                        shape: BoxShape.rectangle,
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Icon(
                        Icons.precision_manufacturing_rounded,
                        color: FlutterFlowTheme.of(context).onPrimary,
                        size: 20.0,
                      ),
                    ),
                    Text(
                      'APEX BALLISTICS',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            font: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.w800,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w800,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontStyle,
                            lineHeight: 1.1,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                        child: PageView(
                          controller: _model.pageViewController ??=
                              PageController(initialPage: 0),
                          scrollDirection: Axis.horizontal,
                          children: [
                            wrapWithModel(
                              model: _model.onboardingStepModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: OnboardingStepWidget(
                                description:
                                    'Сохраняйте профили своего оружия и патронов для стабильных результатов в любых условиях.',
                                lottie_desc:
                                    'https://dimg.dreamflow.cloud/v1/lottie/bullseye+target+hit+success+precision',
                                title: 'Повышение точности',
                                step: 'option_1',
                              ),
                            ),
                            wrapWithModel(
                              model: _model.onboardingStepModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: OnboardingStepWidget(
                                description:
                                    'Автоматическое получение данных о ветре, температуре и давлении для максимальной точности.',
                                lottie_desc:
                                    'https://dimg.dreamflow.cloud/v1/lottie/weather+station+wind+temperature+pressure+sensor',
                                title: 'Учет погодных условий',
                                step: 'option_1',
                              ),
                            ),
                            wrapWithModel(
                              model: _model.onboardingStepModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: OnboardingStepWidget(
                                description:
                                    'Мгновенное вычисление вертикальных и горизонтальных поправок для идеального выстрела.',
                                lottie_desc:
                                    'https://dimg.dreamflow.cloud/v1/lottie/high+precision+target+crosshair+radar+pulse',
                                title: 'Высокоточный расчет',
                                step: 'option_1',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          child: smooth_page_indicator.SmoothPageIndicator(
                            controller: _model.pageViewController ??=
                                PageController(initialPage: 0),
                            count: 3,
                            axisDirection: Axis.horizontal,
                            onDotClicked: (i) async {
                              await _model.pageViewController!.animateToPage(
                                i,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              safeSetState(() {});
                            },
                            effect: smooth_page_indicator.SlideEffect(
                              spacing: 8.0,
                              radius: 8.0,
                              dotWidth: 8.0,
                              dotHeight: 8.0,
                              dotColor: FlutterFlowTheme.of(context).accent1,
                              activeDotColor:
                                  FlutterFlowTheme.of(context).primary,
                              paintStyle: PaintingStyle.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  wrapWithModel(
                    model: _model.buttonModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: ButtonWidget(
                      content: _model.pageViewCurrentIndex < 2 ? 'Далее' : 'Начать',
                      icon_present: false,
                      icon_end_present: false,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      variant: 'primary',
                      size: 'large',
                      full_width: true,
                      loading: false,
                      disabled: false,
                      onPressed: () async {
                        if (_model.pageViewCurrentIndex < 2) {
                          await _model.pageViewController?.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else {
                          await AppStateNotifier.instance.setFirstTime(false);
                          context.goNamed('login');
                        }
                      },
                    ),
                  ),
                  wrapWithModel(
                    model: _model.buttonModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: ButtonWidget(
                      content: 'Пропустить',
                      icon_present: false,
                      icon_end_present: false,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      variant: 'ghost',
                      size: 'medium',
                      full_width: true,
                      loading: false,
                      disabled: false,
                      onPressed: () async {
                        await AppStateNotifier.instance.setFirstTime(false);
                        context.goNamed('login');
                      },
                    ),
                  ),
                ].divide(SizedBox(height: 12.0)),
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}
