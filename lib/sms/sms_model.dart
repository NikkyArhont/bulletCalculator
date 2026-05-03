import 'dart:async';
import '/components/button_widget.dart';
import '/components/pin_digit_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'sms_widget.dart' show SmsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SmsModel extends FlutterFlowModel<SmsWidget> {
  ///  State fields for stateful widgets in this page.

  // State for timer
  int timerSeconds = 59;
  Timer? timer;

  // Controller for code input
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;

  bool isLoading = false;

  // Model for PinDigit.
  late PinDigitModel pinDigitModel1;
  late PinDigitModel pinDigitModel2;
  late PinDigitModel pinDigitModel3;
  late PinDigitModel pinDigitModel4;
  late PinDigitModel pinDigitModel5;
  late PinDigitModel pinDigitModel6;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
    pinCodeFocusNode = FocusNode();

    pinDigitModel1 = createModel(context, () => PinDigitModel());
    pinDigitModel2 = createModel(context, () => PinDigitModel());
    pinDigitModel3 = createModel(context, () => PinDigitModel());
    pinDigitModel4 = createModel(context, () => PinDigitModel());
    pinDigitModel5 = createModel(context, () => PinDigitModel());
    pinDigitModel6 = createModel(context, () => PinDigitModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    timer?.cancel();
    pinCodeController?.dispose();
    pinCodeFocusNode?.dispose();
    pinDigitModel1.dispose();
    pinDigitModel2.dispose();
    pinDigitModel3.dispose();
    pinDigitModel4.dispose();
    pinDigitModel5.dispose();
    pinDigitModel6.dispose();
    buttonModel.dispose();
  }
}
