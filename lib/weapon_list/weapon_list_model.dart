import '/components/button_widget.dart';
import '/components/tactical_weapon_card_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'weapon_list_widget.dart' show WeaponListWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WeaponListModel extends FlutterFlowModel<WeaponListWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for TacticalWeaponCard.
  late TacticalWeaponCardModel tacticalWeaponCardModel1;
  // Model for TacticalWeaponCard.
  late TacticalWeaponCardModel tacticalWeaponCardModel2;
  // Model for TacticalWeaponCard.
  late TacticalWeaponCardModel tacticalWeaponCardModel3;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    tacticalWeaponCardModel1 =
        createModel(context, () => TacticalWeaponCardModel());
    tacticalWeaponCardModel2 =
        createModel(context, () => TacticalWeaponCardModel());
    tacticalWeaponCardModel3 =
        createModel(context, () => TacticalWeaponCardModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    tacticalWeaponCardModel1.dispose();
    tacticalWeaponCardModel2.dispose();
    tacticalWeaponCardModel3.dispose();
    buttonModel.dispose();
  }
}
