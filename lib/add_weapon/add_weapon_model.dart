import '/components/button_widget.dart';
import '/components/section_header_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'add_weapon_widget.dart' show AddWeaponWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddWeaponModel extends FlutterFlowModel<AddWeaponWidget> {
  ///  State fields for stateful widgets in this page.

  bool useMultiBc = false;
  List<Map<String, dynamic>> calibrationPoints = [];

  // Loading state for save button
  bool isLoading = false;
  // Twist direction: true = right, false = left
  bool isRightTwist = true;

  late SectionHeaderModel sectionHeaderModel1;
  // Model for TextField.
  late TextFieldModel textFieldModel1;
  // Model for TextField.
  late TextFieldModel textFieldModel2;
  // Model for TextField.
  late TextFieldModel textFieldModel3;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel2;
  // Model for TextField.
  late TextFieldModel textFieldModel4;
  // Model for TextField.
  late TextFieldModel textFieldModel5;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel3;
  // Model for TextField.
  late TextFieldModel textFieldModel6;
  // Model for TextField.
  late TextFieldModel textFieldModel7;
  // Model for TextField.
  late TextFieldModel textFieldModel8;
  // State field(s) for Dropdown widget.
  String? dropdownValue;
  FormFieldController<String>? dropdownValueController;
  // State field(s) for clickType Dropdown.
  String? clickTypeValue;
  FormFieldController<String>? clickTypeController;
  // Model for TextField.
  late TextFieldModel textFieldModel9;
  // Model for TextField.
  late TextFieldModel textFieldModel10;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    sectionHeaderModel1 = createModel(context, () => SectionHeaderModel());
    textFieldModel1 = createModel(context, () => TextFieldModel());
    textFieldModel2 = createModel(context, () => TextFieldModel());
    textFieldModel3 = createModel(context, () => TextFieldModel());
    sectionHeaderModel2 = createModel(context, () => SectionHeaderModel());
    textFieldModel4 = createModel(context, () => TextFieldModel());
    textFieldModel5 = createModel(context, () => TextFieldModel());
    sectionHeaderModel3 = createModel(context, () => SectionHeaderModel());
    textFieldModel6 = createModel(context, () => TextFieldModel());
    textFieldModel7 = createModel(context, () => TextFieldModel());
    textFieldModel8 = createModel(context, () => TextFieldModel());
    textFieldModel9 = createModel(context, () => TextFieldModel());
    textFieldModel10 = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    sectionHeaderModel1.dispose();
    textFieldModel1.dispose();
    textFieldModel2.dispose();
    textFieldModel3.dispose();
    sectionHeaderModel2.dispose();
    textFieldModel4.dispose();
    textFieldModel5.dispose();
    sectionHeaderModel3.dispose();
    textFieldModel6.dispose();
    textFieldModel7.dispose();
    textFieldModel8.dispose();
    textFieldModel9.dispose();
    textFieldModel10.dispose();
    buttonModel.dispose();
  }
}
