import '/components/tactical_device_card_widget.dart';
import '/components/tactical_switch_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TacticalDeviceCard.
  late TacticalDeviceCardModel tacticalDeviceCardModel1;
  // Model for TacticalDeviceCard.
  late TacticalDeviceCardModel tacticalDeviceCardModel2;
  // Model for TacticalDeviceCard.
  late TacticalDeviceCardModel tacticalDeviceCardModel3;
  // Model for TacticalSwitchRow.
  late TacticalSwitchRowModel tacticalSwitchRowModel1;
  // Model for TacticalSwitchRow.
  late TacticalSwitchRowModel tacticalSwitchRowModel2;
  // Model for TacticalSwitchRow.
  late TacticalSwitchRowModel tacticalSwitchRowModel3;
  // Model for TacticalSwitchRow.
  late TacticalSwitchRowModel tacticalSwitchRowModel4;

  @override
  void initState(BuildContext context) {
    tacticalDeviceCardModel1 =
        createModel(context, () => TacticalDeviceCardModel());
    tacticalDeviceCardModel2 =
        createModel(context, () => TacticalDeviceCardModel());
    tacticalDeviceCardModel3 =
        createModel(context, () => TacticalDeviceCardModel());
    tacticalSwitchRowModel1 =
        createModel(context, () => TacticalSwitchRowModel());
    tacticalSwitchRowModel2 =
        createModel(context, () => TacticalSwitchRowModel());
    tacticalSwitchRowModel3 =
        createModel(context, () => TacticalSwitchRowModel());
    tacticalSwitchRowModel4 =
        createModel(context, () => TacticalSwitchRowModel());
  }

  @override
  void dispose() {
    tacticalDeviceCardModel1.dispose();
    tacticalDeviceCardModel2.dispose();
    tacticalDeviceCardModel3.dispose();
    tacticalSwitchRowModel1.dispose();
    tacticalSwitchRowModel2.dispose();
    tacticalSwitchRowModel3.dispose();
    tacticalSwitchRowModel4.dispose();
  }
}
