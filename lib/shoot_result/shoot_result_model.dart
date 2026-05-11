import '/components/button_widget.dart';
import '/components/correction_tile_widget.dart';
import '/components/result_metric_card_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/ballistic_engine.dart';
import 'shoot_result_widget.dart' show ShootResultWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShootResultModel extends FlutterFlowModel<ShootResultWidget> {
  ///  State fields for stateful widgets in this page.
  bool isLoading = false;
  bool isSavingHit = false;
  bool isHitConfirmed = false;
  BallisticResult? ballisticResult;

  // Model for ResultMetricCard.
  late ResultMetricCardModel resultMetricCardModel1;
  // Model for ResultMetricCard.
  late ResultMetricCardModel resultMetricCardModel2;
  // Model for CorrectionTile.
  late CorrectionTileModel correctionTileModel1;
  // Model for CorrectionTile.
  late CorrectionTileModel correctionTileModel2;
  // Model for CorrectionTile.
  late CorrectionTileModel correctionTileModel3;
  // Model for CorrectionTile.
  late CorrectionTileModel correctionTileModel4;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    resultMetricCardModel1 =
        createModel(context, () => ResultMetricCardModel());
    resultMetricCardModel2 =
        createModel(context, () => ResultMetricCardModel());
    correctionTileModel1 = createModel(context, () => CorrectionTileModel());
    correctionTileModel2 = createModel(context, () => CorrectionTileModel());
    correctionTileModel3 = createModel(context, () => CorrectionTileModel());
    correctionTileModel4 = createModel(context, () => CorrectionTileModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    resultMetricCardModel1.dispose();
    resultMetricCardModel2.dispose();
    correctionTileModel1.dispose();
    correctionTileModel2.dispose();
    correctionTileModel3.dispose();
    correctionTileModel4.dispose();
    buttonModel.dispose();
  }
}
