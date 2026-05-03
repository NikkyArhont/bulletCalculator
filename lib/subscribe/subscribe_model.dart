import '/components/button_widget.dart';
import '/components/feature_row_widget.dart';
import '/components/pricing_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'subscribe_widget.dart' show SubscribeWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/material_palette.dart';
import 'package:provider/provider.dart';

class SubscribeModel extends FlutterFlowModel<SubscribeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for FeatureRow.
  late FeatureRowModel featureRowModel1;
  // Model for FeatureRow.
  late FeatureRowModel featureRowModel2;
  // Model for FeatureRow.
  late FeatureRowModel featureRowModel3;
  // Model for FeatureRow.
  late FeatureRowModel featureRowModel4;
  // Model for FeatureRow.
  late FeatureRowModel featureRowModel5;
  // Model for PricingCard.
  late PricingCardModel pricingCardModel1;
  // Model for PricingCard.
  late PricingCardModel pricingCardModel2;
  // Model for PricingCard.
  late PricingCardModel pricingCardModel3;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    featureRowModel1 = createModel(context, () => FeatureRowModel());
    featureRowModel2 = createModel(context, () => FeatureRowModel());
    featureRowModel3 = createModel(context, () => FeatureRowModel());
    featureRowModel4 = createModel(context, () => FeatureRowModel());
    featureRowModel5 = createModel(context, () => FeatureRowModel());
    pricingCardModel1 = createModel(context, () => PricingCardModel());
    pricingCardModel2 = createModel(context, () => PricingCardModel());
    pricingCardModel3 = createModel(context, () => PricingCardModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    featureRowModel1.dispose();
    featureRowModel2.dispose();
    featureRowModel3.dispose();
    featureRowModel4.dispose();
    featureRowModel5.dispose();
    pricingCardModel1.dispose();
    pricingCardModel2.dispose();
    pricingCardModel3.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
