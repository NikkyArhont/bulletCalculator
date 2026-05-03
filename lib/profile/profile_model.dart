import '/components/button_widget.dart';
import '/components/history_card_widget.dart';
import '/components/profile_stat_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'profile_widget.dart' show ProfileWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ProfileStat.
  late ProfileStatModel profileStatModel1;
  // Model for ProfileStat.
  late ProfileStatModel profileStatModel2;
  // Model for ProfileStat.
  late ProfileStatModel profileStatModel3;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for HistoryCard.
  late HistoryCardModel historyCardModel1;
  // Model for HistoryCard.
  late HistoryCardModel historyCardModel2;
  // Model for HistoryCard.
  late HistoryCardModel historyCardModel3;
  // Model for HistoryCard.
  late HistoryCardModel historyCardModel4;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for Button.
  late ButtonModel buttonModel3;

  @override
  void initState(BuildContext context) {
    profileStatModel1 = createModel(context, () => ProfileStatModel());
    profileStatModel2 = createModel(context, () => ProfileStatModel());
    profileStatModel3 = createModel(context, () => ProfileStatModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    historyCardModel1 = createModel(context, () => HistoryCardModel());
    historyCardModel2 = createModel(context, () => HistoryCardModel());
    historyCardModel3 = createModel(context, () => HistoryCardModel());
    historyCardModel4 = createModel(context, () => HistoryCardModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    buttonModel3 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    profileStatModel1.dispose();
    profileStatModel2.dispose();
    profileStatModel3.dispose();
    buttonModel1.dispose();
    historyCardModel1.dispose();
    historyCardModel2.dispose();
    historyCardModel3.dispose();
    historyCardModel4.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
  }
}
