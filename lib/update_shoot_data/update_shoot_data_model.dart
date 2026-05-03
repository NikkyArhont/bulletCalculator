import '/components/grid_button_widget.dart';
import '/components/tactical_card_widget.dart';
import '/components/tactical_dial_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'update_shoot_data_widget.dart' show UpdateShootDataWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateShootDataModel extends FlutterFlowModel<UpdateShootDataWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TacticalDial.
  late TacticalDialModel tacticalDialModel1;
  // Model for TacticalDial.
  late TacticalDialModel tacticalDialModel2;
  // Model for TacticalCard.
  late TacticalCardModel tacticalCardModel1;
  // Model for TacticalCard.
  late TacticalCardModel tacticalCardModel2;
  // Model for GridButton.
  late GridButtonModel gridButtonModel1;
  // Model for GridButton.
  late GridButtonModel gridButtonModel2;
  // Model for GridButton.
  late GridButtonModel gridButtonModel3;
  // Model for GridButton.
  late GridButtonModel gridButtonModel4;

  @override
  void initState(BuildContext context) {
    tacticalDialModel1 = createModel(context, () => TacticalDialModel());
    tacticalDialModel2 = createModel(context, () => TacticalDialModel());
    tacticalCardModel1 = createModel(context, () => TacticalCardModel());
    tacticalCardModel2 = createModel(context, () => TacticalCardModel());
    gridButtonModel1 = createModel(context, () => GridButtonModel());
    gridButtonModel2 = createModel(context, () => GridButtonModel());
    gridButtonModel3 = createModel(context, () => GridButtonModel());
    gridButtonModel4 = createModel(context, () => GridButtonModel());
  }

  @override
  void dispose() {
    tacticalDialModel1.dispose();
    tacticalDialModel2.dispose();
    tacticalCardModel1.dispose();
    tacticalCardModel2.dispose();
    gridButtonModel1.dispose();
    gridButtonModel2.dispose();
    gridButtonModel3.dispose();
    gridButtonModel4.dispose();
  }
}
