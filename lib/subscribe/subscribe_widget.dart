import '/components/button_widget.dart';
import '/components/feature_row_widget.dart';
import '/components/pricing_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/material_palette.dart';
import 'package:provider/provider.dart';
import 'subscribe_model.dart';
export 'subscribe_model.dart';

class SubscribeWidget extends StatefulWidget {
  const SubscribeWidget({super.key});

  static String routeName = 'Subscribe';
  static String routePath = '/subscribe';

  @override
  State<SubscribeWidget> createState() => _SubscribeWidgetState();
}

class _SubscribeWidgetState extends State<SubscribeWidget> {
  late SubscribeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubscribeModel());
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
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: AlignmentDirectional(-1.0, -1.0),
                children: [
                  ClipRRect(
                    child: Container(
                      height: 240.0,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return FbmGradientShaderFill(
                            width: constraints.maxWidth.isFinite
                                ? constraints.maxWidth
                                : 200.0,
                            height: constraints.maxHeight.isFinite
                                ? constraints.maxHeight
                                : 200.0,
                            params: ShaderParams(values: {
                              'gradientAngle': 180.0,
                              'gradientScale': 0.89,
                              'gradientOffset': 0.0,
                              'noiseIntensity': 0.32,
                              'ditherStrength': 2.51,
                              'ditherScale': 0.29,
                              'animSpeed': 1.46,
                              'octaves': 6.06,
                              'lacunarity': 2.35,
                              'persistence': 0.5,
                              'noiseScale': 6.36,
                              'colorCount': 7.0,
                              'softness': 0.0,
                              'exposure': 1.0,
                              'contrast': 1.0,
                              'bumpStrength': 0.0,
                              'lightDirX': 0.55,
                              'lightDirY': 0.45,
                              'lightDirZ': 1.0,
                              'lightIntensity': 1.15,
                              'ambient': 0.7,
                              'specular': 0.29,
                              'shininess': 40.76,
                              'metallic': 1.0,
                              'roughness': 1.0,
                              'edgeFade': 1.72,
                              'edgeFadeMode': 0.0,
                              'sharpness': 2.2
                            }, colors: {
                              'color0': Color(0xFF1A1C1E),
                              'color1': Color(0xFF2C3E50),
                              'color2': Color(0xFF1A1C1E),
                              'color3': Color(0xFF0D1117),
                              'color4': Color(0xFF0D1117),
                              'color5': Color(0xFF0D1117),
                              'color6': Color(0xFF0D1117),
                              'color7': Color(0x00808080),
                              'color8': Color(0x00808080),
                              'color9': Color(0x00808080)
                            }),
                            animationMode: ShaderAnimationMode.continuous,
                            cache: false,
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 240.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          FlutterFlowTheme.of(context).primaryBackground
                        ],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 64.0,
                          height: 64.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(24.0),
                            shape: BoxShape.rectangle,
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.workspace_premium_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 40.0,
                          ),
                        ),
                        Text(
                          'Apex Ballistics Pro',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                font: GoogleFonts.spaceGrotesk(
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w800,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                                lineHeight: 1.1,
                              ),
                        ),
                        Text(
                          'Разблокируйте полный потенциал вашей стрельбы',
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).surface50,
                        borderRadius: BorderRadius.circular(6.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              wrapWithModel(
                                model: _model.featureRowModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: FeatureRowWidget(
                                  text: 'Неограниченное кол-во профилей оружия',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.featureRowModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: FeatureRowWidget(
                                  text: 'Интеграция с метеостанциями Kestrel',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.featureRowModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: FeatureRowWidget(
                                  text:
                                      'Расширенные таблицы баллистики (G1/G7)',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.featureRowModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: FeatureRowWidget(
                                  text: 'Облачная синхронизация данных',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.featureRowModel5,
                                updateCallback: () => safeSetState(() {}),
                                child: FeatureRowWidget(
                                  text: 'Приоритетная поддержка 24/7',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
              Container(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: Container(
                        child: Text(
                          'Выберите тарифный план',
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                font: GoogleFonts.spaceGrotesk(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                                lineHeight: 1.1,
                              ),
                        ),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.pricingCardModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: PricingCardWidget(
                        description: 'Для разовых выездов',
                        is_popular: false,
                        period: '/мес',
                        price: '490 ₽',
                        title: 'Месячный',
                        selected: false,
                      ),
                    ),
                    wrapWithModel(
                      model: _model.pricingCardModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: PricingCardWidget(
                        description: 'Лучший выбор для профи',
                        is_popular: true,
                        period: '/год',
                        price: '3 990 ₽',
                        title: 'Годовой',
                        selected: true,
                      ),
                    ),
                    wrapWithModel(
                      model: _model.pricingCardModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: PricingCardWidget(
                        description: 'Один раз и навсегда',
                        is_popular: false,
                        period: 'разово',
                        price: '9 990 ₽',
                        title: 'Бессрочный',
                        selected: false,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).success10,
                      borderRadius: BorderRadius.circular(6.0),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).success30,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_rounded,
                              color: Colors.black,
                              size: 24.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Начните 7-дневный бесплатный пробный период. Отмена в любое время.',
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
                                      color: Colors.black,
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
                            ),
                          ].divide(SizedBox(width: 16.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    wrapWithModel(
                      model: _model.buttonModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        content: 'Попробовать бесплатно',
                        icon_present: false,
                        icon_end_present: false,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        variant: 'primary',
                        size: 'large',
                        full_width: true,
                        loading: false,
                        disabled: false,
                        onPressed: () async {
                          context.goNamed('succsedEnter');
                        },
                      ),
                    ),
                    wrapWithModel(
                      model: _model.buttonModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        content: 'Восстановить покупки',
                        icon_present: false,
                        icon_end_present: false,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        variant: 'ghost',
                        size: 'medium',
                        full_width: true,
                        loading: false,
                        disabled: false,
                      ),
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Условия использования',
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.spaceGrotesk(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).onPrimary,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                            decoration: TextDecoration.underline,
                            lineHeight: 1.1,
                          ),
                    ),
                    Text(
                      'Приватность',
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            font: GoogleFonts.spaceGrotesk(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).onPrimary,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                            decoration: TextDecoration.underline,
                            lineHeight: 1.1,
                          ),
                    ),
                  ].divide(SizedBox(width: 24.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
