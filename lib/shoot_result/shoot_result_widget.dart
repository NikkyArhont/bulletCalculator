import '/components/button_widget.dart';
import '/components/correction_tile_widget.dart';
import '/components/result_metric_card_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'shoot_result_model.dart';
export 'shoot_result_model.dart';
import '/ballistic_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShootResultWidget extends StatefulWidget {
  const ShootResultWidget({
    super.key,
    this.distance,
    this.windSpeed,
    this.windDirection,
    this.muzzleVelocity,
    this.bcValue,
    this.bulletWeight,
    this.temperature,
    this.pressure,
    this.angle,
    this.sightHeight,
    this.clickValue,
    this.resultId,
  });

  final double? distance;
  final double? windSpeed;
  final double? windDirection;
  final double? muzzleVelocity;
  final double? bcValue;
  final double? bulletWeight;
  final double? temperature;
  final double? pressure;
  final double? angle;
  final double? sightHeight;
  final double? clickValue;
  final String? resultId;

  static String routeName = 'shootResult';
  static String routePath = '/shootResult';

  @override
  State<ShootResultWidget> createState() => _ShootResultWidgetState();
}

class _ShootResultWidgetState extends State<ShootResultWidget> {
  late ShootResultModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShootResultModel());

    // Perform ballistic calculation
    _model.ballisticResult = BallisticEngine.calculate(
      v0: widget.muzzleVelocity ?? 800.0,
      bc: widget.bcValue ?? 0.3,
      weightGrams: widget.bulletWeight ?? 9.0,
      distance: widget.distance ?? 100.0,
      windSpeed: widget.windSpeed ?? 0.0,
      windDirectionHours: widget.windDirection ?? 3.0,
      temperatureC: widget.temperature ?? 15.0,
      pressureHpa: widget.pressure ?? 1013.0,
      sightHeightMm: widget.sightHeight ?? 50.0,
      clickValue: widget.clickValue ?? 0.1,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.close_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              context.pop(true);
                            },
                          ),
                          Text(
                            'Результат расчета',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.spaceGrotesk(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                  lineHeight: 1.2,
                                ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.share_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary10,
                                borderRadius: BorderRadius.circular(24.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).primary30,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'ВЕРТИКАЛЬНАЯ ПОПРАВКА',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  font:
                                                      GoogleFonts.spaceGrotesk(
                                                    fontWeight: FontWeight.w800,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w800,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                  lineHeight: 1.1,
                                                ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_model.ballisticResult?.verticalMrad.toStringAsFixed(1) ?? '0.0'}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 64.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .fontStyle,
                                                          lineHeight: 1.1,
                                                        ),
                                              ),
                                              Text(
                                                'MRAD',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLarge
                                                                  .fontStyle,
                                                          lineHeight: 1.2,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 16.0)),
                                          ),
                                          Text(
                                            '${_model.ballisticResult?.verticalClicks ?? 0} КЛИКОВ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                  lineHeight: 1.4,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 4.0)),
                                      ),
                                      Divider(
                                        height: 16.0,
                                        thickness: 1.0,
                                        indent: 0.0,
                                        endIndent: 0.0,
                                        color: FlutterFlowTheme.of(context)
                                            .primary20,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'ГОРИЗОНТАЛЬ (ВЕТЕР)',
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  font:
                                                      GoogleFonts.spaceGrotesk(
                                                    fontWeight: FontWeight.w800,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w800,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                  lineHeight: 1.1,
                                                ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${_model.ballisticResult?.horizontalMrad.toStringAsFixed(1) ?? '0.0'}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 48.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .fontStyle,
                                                          lineHeight: 1.1,
                                                        ),
                                              ),
                                              Text(
                                                'MRAD',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLarge
                                                                  .fontStyle,
                                                          lineHeight: 1.2,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 16.0)),
                                          ),
                                          Text(
                                            '${_model.ballisticResult?.horizontalClicks ?? 0} КЛИКОВ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                  lineHeight: 1.4,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 4.0)),
                                      ),
                                    ].divide(SizedBox(height: 24.0)),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.resultMetricCardModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ResultMetricCardWidget(
                                      label: 'Смещение (В)',
                                      unit: 'см',
                                      value: '${_model.ballisticResult?.dropCm.toStringAsFixed(1) ?? '0.0'}',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.resultMetricCardModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ResultMetricCardWidget(
                                      label: 'Смещение (Г)',
                                      unit: 'см',
                                      value: '${_model.ballisticResult?.windDriftCm.toStringAsFixed(1) ?? '0.0'}',
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(6.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Визуализация траектории',
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                          ),
                                          Icon(
                                            Icons.insights_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 20.0,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 180.0,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          height: 180.0,
                                          child: FlutterFlowLineChart(
                                            data: [
                                              FFLineChartData(
                                                xData: [
                                                  0.0,
                                                  (widget.distance ?? 600.0) * 0.2,
                                                  (widget.distance ?? 600.0) * 0.4,
                                                  (widget.distance ?? 600.0) * 0.6,
                                                  (widget.distance ?? 600.0) * 0.8,
                                                  (widget.distance ?? 600.0)
                                                ],
                                                yData: [0.0, 0.3, 0.45, 0.5, 0.35, 0.0],
                                                settings: LineChartBarData(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  barWidth: 3.0,
                                                  isCurved: true,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary10,
                                                  ),
                                                ),
                                              )
                                            ],
                                            chartStylingInfo: ChartStylingInfo(
                                              backgroundColor:
                                                  Colors.transparent,
                                              showBorder: false,
                                            ),
                                            axisBounds: AxisBounds(
                                              minX: 0.0,
                                              minY: -0.1,
                                              maxX: (widget.distance ?? 600.0),
                                              maxY: 0.6,
                                            ),
                                            xAxisLabelInfo: AxisLabelInfo(
                                              title: 'Дистанция (м)',
                                              showLabels: true,
                                              labelInterval: (widget.distance ?? 600.0) / 5,
                                              labelTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 10.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontStyle,
                                                        lineHeight: 1.0,
                                                      ),
                                              reservedSize: 28.0,
                                            ),
                                            yAxisLabelInfo: AxisLabelInfo(
                                              reservedSize: 0.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Время полета',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                  lineHeight: 1.3,
                                                ),
                                          ),
                                          Text(
                                            '${_model.ballisticResult?.timeOfFlight.toStringAsFixed(3) ?? '0.000'} сек',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                  lineHeight: 1.3,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ].divide(SizedBox(height: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Детали выстрела',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.spaceGrotesk(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                        lineHeight: 1.1,
                                      ),
                                ),
                                wrapWithModel(
                                  model: _model.correctionTileModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CorrectionTileWidget(
                                    value: '0.0', // Drift already in horizontal
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.correctionTileModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CorrectionTileWidget(
                                    label: 'Кориолис',
                                    sub_label: 'Вращение Земли',
                                    unit: 'MRAD',
                                    value: '0.0', // Not implemented in MVP
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.correctionTileModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CorrectionTileWidget(
                                    label: 'Скорость у цели',
                                    sub_label: 'Дистанция ${widget.distance?.round() ?? 0}м',
                                    unit: 'м/с',
                                    value: '${_model.ballisticResult?.velocityAtTarget.round() ?? 0}',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.correctionTileModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CorrectionTileWidget(
                                    label: 'Энергия',
                                    sub_label: 'В точке попадания',
                                    unit: 'Дж',
                                    value: '${_model.ballisticResult?.energyAtTarget.round() ?? 0}',
                                  ),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                            Container(
                              height: 24.0,
                            ),
                            Container(
                              height: 24.0,
                            ),
                            Container(
                              height: 24.0,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: wrapWithModel(
                                        model: _model.buttonModel,
                                        updateCallback: () => safeSetState(() {}),
                                        child: ButtonWidget(
                                          content: 'ПОПАДАНИЕ',
                                          icon: Icon(
                                            Icons.gps_fixed_rounded,
                                            color: FlutterFlowTheme.of(context).onPrimary,
                                            size: 16.0,
                                          ),
                                          icon_present: true,
                                          icon_end_present: false,
                                          variant: 'primary',
                                          size: 'large',
                                          loading: _model.isSavingHit,
                                          disabled: _model.isSavingHit,
                                          onPressed: () async {
                                            if (widget.resultId == null) return;
                                            safeSetState(() => _model.isSavingHit = true);
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection('shootResults')
                                                  .doc(widget.resultId)
                                                  .update({'isHit': true});
                                              if (context.mounted) {
                                                context.goNamed('shootPage');
                                              }
                                            } catch (e) {
                                              print('Error updating hit: $e');
                                              safeSetState(() => _model.isSavingHit = false);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.0),
                                    Expanded(
                                      child: wrapWithModel(
                                        model: _model.buttonModel,
                                        updateCallback: () => safeSetState(() {}),
                                        child: ButtonWidget(
                                          content: 'ПРОМАХ',
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color: FlutterFlowTheme.of(context).onError,
                                            size: 16.0,
                                          ),
                                          icon_present: true,
                                          icon_end_present: false,
                                          variant: 'destructive',
                                          size: 'large',
                                          loading: _model.isSavingHit,
                                          disabled: _model.isSavingHit,
                                          onPressed: () async {
                                            if (widget.resultId == null) return;
                                            safeSetState(() => _model.isSavingHit = true);
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection('shootResults')
                                                  .doc(widget.resultId)
                                                  .update({'isHit': false});
                                              if (context.mounted) {
                                                context.goNamed('shootPage');
                                              }
                                            } catch (e) {
                                              print('Error updating miss: $e');
                                              safeSetState(() => _model.isSavingHit = false);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            wrapWithModel(
                              model: _model.buttonModel,
                              updateCallback: () => safeSetState(() {}),
                              child: ButtonWidget(
                                content: 'Повторить расчет',
                                icon: Icon(
                                  Icons.repeat,
                                  color: FlutterFlowTheme.of(context).onPrimary,
                                  size: 16.0,
                                ),
                                icon_present: true,
                                icon_end_present: false,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                variant: 'primary',
                                size: 'large',
                                full_width: true,
                                loading: _model.isLoading,
                                disabled: _model.isLoading,
                                onPressed: () async {
                                  safeSetState(() => _model.isLoading = true);
                                  await Future.delayed(
                                      const Duration(milliseconds: 300));
                                  context.pop(false);
                                  safeSetState(() => _model.isLoading = false);
                                },
                              ),
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
