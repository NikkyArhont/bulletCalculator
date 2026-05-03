import '/components/button_widget.dart';
import '/components/onboarding_step_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'onboarding_widget.dart' show OnboardingWidget;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingModel extends FlutterFlowModel<OnboardingWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for OnboardingStep.
  late OnboardingStepModel onboardingStepModel1;
  // Model for OnboardingStep.
  late OnboardingStepModel onboardingStepModel2;
  // Model for OnboardingStep.
  late OnboardingStepModel onboardingStepModel3;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    onboardingStepModel1 = createModel(context, () => OnboardingStepModel());
    onboardingStepModel2 = createModel(context, () => OnboardingStepModel());
    onboardingStepModel3 = createModel(context, () => OnboardingStepModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    onboardingStepModel1.dispose();
    onboardingStepModel2.dispose();
    onboardingStepModel3.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
