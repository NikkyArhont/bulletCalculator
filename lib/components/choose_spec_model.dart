import '/components/button_widget.dart';
import '/components/specialization_option_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'choose_spec_widget.dart' show ChooseSpecWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChooseSpecModel extends FlutterFlowModel<ChooseSpecWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for SpecializationOption.
  late SpecializationOptionModel specializationOptionModel1;
  // Model for SpecializationOption.
  late SpecializationOptionModel specializationOptionModel2;
  // Model for SpecializationOption.
  late SpecializationOptionModel specializationOptionModel3;
  // Model for SpecializationOption.
  late SpecializationOptionModel specializationOptionModel4;
  // Model for SpecializationOption.
  late SpecializationOptionModel specializationOptionModel5;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    specializationOptionModel1 =
        createModel(context, () => SpecializationOptionModel());
    specializationOptionModel2 =
        createModel(context, () => SpecializationOptionModel());
    specializationOptionModel3 =
        createModel(context, () => SpecializationOptionModel());
    specializationOptionModel4 =
        createModel(context, () => SpecializationOptionModel());
    specializationOptionModel5 =
        createModel(context, () => SpecializationOptionModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    specializationOptionModel1.dispose();
    specializationOptionModel2.dispose();
    specializationOptionModel3.dispose();
    specializationOptionModel4.dispose();
    specializationOptionModel5.dispose();
    buttonModel.dispose();
  }
}
