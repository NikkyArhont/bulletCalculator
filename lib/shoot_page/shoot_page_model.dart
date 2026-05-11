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
  bool isGustActive = false;
  int windDirectionHours = 2;
  bool isLoading = false;

  // Model for DataInputField.
  late DataInputFieldModel dataInputFieldModelDistance;
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
  // Model for DataInputField.
  late DataInputFieldModel dataInputFieldModelGust;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    dataInputFieldModelDistance =
        createModel(context, () => DataInputFieldModel());
    dataInputFieldModelDistance.textFieldModel.inputTextController =
        TextEditingController(text: '850');

    dataInputFieldModel1 = createModel(context, () => DataInputFieldModel());
    dataInputFieldModel1.textFieldModel.inputTextController =
        TextEditingController(text: '3');

    dataInputFieldModel2 = createModel(context, () => DataInputFieldModel());
    dataInputFieldModel2.textFieldModel.inputTextController =
        TextEditingController(text: '2');

    switchComponentModel = createModel(context, () => SwitchComponentModel());

    dataInputFieldModel3 = createModel(context, () => DataInputFieldModel());
    dataInputFieldModel3.textFieldModel.inputTextController =
        TextEditingController(text: '15');

    dataInputFieldModel4 = createModel(context, () => DataInputFieldModel());
    dataInputFieldModel4.textFieldModel.inputTextController =
        TextEditingController(text: '1013');

    dataInputFieldModel5 = createModel(context, () => DataInputFieldModel());
    dataInputFieldModel5.textFieldModel.inputTextController =
        TextEditingController(text: '45');

    dataInputFieldModelGust = createModel(context, () => DataInputFieldModel());
    dataInputFieldModelGust.textFieldModel.inputTextController =
        TextEditingController(text: '5');

    buttonModel = createModel(context, () => ButtonModel());
  }

  void clearFields() {
    dataInputFieldModelDistance.textFieldModel.inputTextController?.text = '0';
    dataInputFieldModel1.textFieldModel.inputTextController?.text = '0';
    dataInputFieldModel2.textFieldModel.inputTextController?.text = '0';
    dataInputFieldModel3.textFieldModel.inputTextController?.text = '18';
    dataInputFieldModel4.textFieldModel.inputTextController?.text = '1013';
    dataInputFieldModel5.textFieldModel.inputTextController?.text = '45';
    dataInputFieldModelGust.textFieldModel.inputTextController?.text = '0';
    selectedWeaponId = null;
    selectedWeaponName = 'Выберите оружие';
    isGustActive = false;
    windDirectionHours = 2;
  }

  @override
  void dispose() {
    dataInputFieldModelDistance.dispose();
    dataInputFieldModel1.dispose();
    dataInputFieldModel2.dispose();
    switchComponentModel.dispose();
    dataInputFieldModel3.dispose();
    dataInputFieldModel4.dispose();
    dataInputFieldModel5.dispose();
    dataInputFieldModelGust.dispose();
    buttonModel.dispose();
  }
}
