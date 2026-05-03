import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:material_palette/material_palette.dart';
import 'package:provider/provider.dart';
import 'onboarding_step_model.dart';
export 'onboarding_step_model.dart';

class OnboardingStepWidget extends StatefulWidget {
  const OnboardingStepWidget({
    super.key,
    String? description,
    String? lottie_desc,
    String? title,
    String? step,
  })  : this.description = description ??
            'Мгновенное вычисление вертикальных и горизонтальных поправок для идеального выстрела.',
        this.lottie_desc = lottie_desc ??
            'https://dimg.dreamflow.cloud/v1/lottie/high+precision+target+crosshair+radar+pulse',
        this.title = title ?? 'Высокоточный расчет',
        this.step = step ?? 'option_1';

  final String description;
  final String lottie_desc;
  final String title;
  final String step;

  @override
  State<OnboardingStepWidget> createState() => _OnboardingStepWidgetState();
}

class _OnboardingStepWidgetState extends State<OnboardingStepWidget> {
  late OnboardingStepModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingStepModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(32.0),
                  shape: BoxShape.rectangle,
                ),
                child: Stack(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SimplexGradientShaderFill(
                          width: constraints.maxWidth.isFinite
                              ? constraints.maxWidth
                              : 200.0,
                          height: constraints.maxHeight.isFinite
                              ? constraints.maxHeight
                              : 200.0,
                          params: ShaderParams(values: {
                            'gradientAngle': 135.0,
                            'gradientScale': 0.89,
                            'gradientOffset': 0.0,
                            'noiseIntensity': 0.32,
                            'ditherStrength': 2.51,
                            'ditherScale': 0.29,
                            'animSpeed': 1.46,
                            'noiseScale': 6.36,
                            'sharpness': 2.2,
                            'colorCount': 6.76,
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
                            'edgeFadeMode': 0.0
                          }, colors: {
                            'color0': FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            'color1':
                                FlutterFlowTheme.of(context).primaryBackground,
                            'color2': FlutterFlowTheme.of(context).primary20,
                            'color3': FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            'color4': FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            'color5': FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            'color6': FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            'color7': Color(0x00808080),
                            'color8': Color(0x00808080),
                            'color9': Color(0x00808080)
                          }),
                          animationMode: ShaderAnimationMode.continuous,
                          cache: false,
                        );
                      },
                    ),
                    Container(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Lottie.network(
                        valueOrDefault<String>(
                          widget!.lottie_desc,
                          'https://dimg.dreamflow.cloud/v1/lottie/high+precision+target+crosshair+radar+pulse',
                        ),
                        fit: BoxFit.contain,
                        animate: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                valueOrDefault<String>(
                  widget!.title,
                  'Высокоточный расчет',
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                      lineHeight: 1.1,
                    ),
              ),
              Text(
                valueOrDefault<String>(
                  widget!.description,
                  'Мгновенное вычисление вертикальных и горизонтальных поправок для идеального выстрела.',
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ],
    );
  }
}
