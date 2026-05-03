import '/components/button_widget.dart';
import '/components/data_input_field_widget.dart';
import '/components/switch_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'shoot_page_widget.dart' show ShootPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShootPageModel extends FlutterFlowModel<ShootPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Weapon dropdown state
  bool isWeaponDropdownOpen = false;
  String? selectedWeaponId;
  String selectedWeaponName = 'Выберите оружие';
  String selectedWeaponCaliber = '';

  // Model for DataInputField.
  late DataInputFieldModel dataInputFieldModel1;
  // Model for DataInputField.
  late DataInputFieldModel dataInputFieldModel2;
  // Model for SwitchComponent.
  late SwitchComponentModel switchComponentModel;
  // Model for DataInputField.
  late DataInputFieldModel dataInputFieldModel3;
  // Model for DataInputField.
  late DataInputFieldModel dataInputFieldModel4;
  // Model for DataInputField.
  late DataInputFieldModel dataInputFieldModel5;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    dataInputFieldModel1 = createModel(context, () => DataInputFieldModel());
    dataInputFieldModel2 = createModel(context, () => DataInputFieldModel());
    switchComponentModel = createModel(context, () => SwitchComponentModel());
    dataInputFieldModel3 = createModel(context, () => DataInputFieldModel());
    dataInputFieldModel4 = createModel(context, () => DataInputFieldModel());
    dataInputFieldModel5 = createModel(context, () => DataInputFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    dataInputFieldModel1.dispose();
    dataInputFieldModel2.dispose();
    switchComponentModel.dispose();
    dataInputFieldModel3.dispose();
    dataInputFieldModel4.dispose();
    dataInputFieldModel5.dispose();
    buttonModel.dispose();
  }
}
