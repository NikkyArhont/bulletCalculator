import '/components/button_widget.dart';
import '/components/data_input_field_widget.dart';
import '/components/switch_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/ballistic_engine.dart';
import 'shoot_page_model.dart';
export 'shoot_page_model.dart';

class ShootPageWidget extends StatefulWidget {
  const ShootPageWidget({
    super.key,
    this.selectedWeaponId,
    this.selectedWeaponName,
    this.selectedWeaponCaliber,
    this.muzzleVelocity,
    this.bcValue,
    this.bcModel,
    this.bulletWeight,
    this.twist,
  });

  final String? selectedWeaponId;
  final String? selectedWeaponName;
  final String? selectedWeaponCaliber;
  final String? muzzleVelocity;
  final String? bcValue;
  final String? bcModel;
  final String? bulletWeight;
  final String? twist;

  static String routeName = 'shootPage';
  static String routePath = '/shootPage';

  @override
  State<ShootPageWidget> createState() => _ShootPageWidgetState();
}

class _ShootPageWidgetState extends State<ShootPageWidget> {
  late ShootPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShootPageModel());
    _handleParameters();
  }

  @override
  void didUpdateWidget(ShootPageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedWeaponId != oldWidget.selectedWeaponId) {
      _handleParameters();
    }
  }

  void _handleParameters() {
    if (widget.selectedWeaponId != null) {
      _model.selectedWeaponId = widget.selectedWeaponId;
      _model.selectedWeaponName = widget.selectedWeaponName ?? 'Оружие';
      _model.selectedWeaponCaliber = widget.selectedWeaponCaliber ?? '';

      if (widget.muzzleVelocity != null) {
        _model.dataInputFieldModel1.textFieldModel.inputTextController?.text =
            widget.muzzleVelocity!;
      }
      if (widget.bcValue != null) {
        _model.dataInputFieldModel2.textFieldModel.inputTextController?.text =
            widget.bcValue!;
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final distanceText =
        _model.dataInputFieldModelDistance.textFieldModel.inputTextController?.text ??
            '';
    final angleText =
        _model.dataInputFieldModel1.textFieldModel.inputTextController?.text ?? '';
    final speedText =
        _model.dataInputFieldModel2.textFieldModel.inputTextController?.text ?? '';
    final tempText =
        _model.dataInputFieldModel3.textFieldModel.inputTextController?.text ?? '';
    final pressureText =
        _model.dataInputFieldModel4.textFieldModel.inputTextController?.text ?? '';
    final humidityText =
        _model.dataInputFieldModel5.textFieldModel.inputTextController?.text ?? '';
    final gustText =
        _model.dataInputFieldModelGust.textFieldModel.inputTextController?.text ??
            '';

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          alignment: AlignmentDirectional(-1.0, -1.0),
          children: [
            SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 24.0, 24.0, 16.0),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Баллистический расчет',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            font: GoogleFonts.spaceGrotesk(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .fontStyle,
                                            lineHeight: 1.2,
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 20.0,
                                      buttonSize: 40.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.account_circle_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 28.0,
                                      ),
                                      onPressed: () async {
                                        context.pushNamed('profile');
                                      },
                                    ),
                                  ],
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(currentUserUid)
                                      .collection('weapons')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    final weapons = snapshot.data?.docs ?? [];
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            safeSetState(() {
                                              _model.isWeaponDropdownOpen =
                                                  !_model.isWeaponDropdownOpen;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              borderRadius: BorderRadius.circular(6.0),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: FlutterFlowTheme.of(context).primary,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 48.0,
                                                    height: 48.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(context).primary10,
                                                      borderRadius: BorderRadius.circular(4.0),
                                                    ),
                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                    child: Icon(
                                                      Icons.precision_manufacturing_rounded,
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                  SizedBox(width: 16.0),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Оружие',
                                                          style: FlutterFlowTheme.of(context)
                                                              .labelSmall
                                                              .override(
                                                                font: GoogleFonts.spaceGrotesk(),
                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                letterSpacing: 0.0,
                                                              ),
                                                        ),
                                                        Text(
                                                          _model.selectedWeaponName,
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                        ),
                                                      ].divide(SizedBox(height: 4.0)),
                                                    ),
                                                  ),
                                                  AnimatedRotation(
                                                    turns: _model.isWeaponDropdownOpen ? 0.5 : 0.0,
                                                    duration: Duration(milliseconds: 200),
                                                    child: Icon(
                                                      Icons.expand_more_rounded,
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        AnimatedCrossFade(
                                          duration: Duration(milliseconds: 200),
                                          firstCurve: Curves.easeInOut,
                                          secondCurve: Curves.easeInOut,
                                          crossFadeState: _model.isWeaponDropdownOpen
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                          firstChild: SizedBox.shrink(),
                                          secondChild: Container(
                                            margin: EdgeInsets.only(top: 4.0),
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              borderRadius: BorderRadius.circular(6.0),
                                              border: Border.all(
                                                color: FlutterFlowTheme.of(context).alternate,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                if (weapons.isEmpty)
                                                  Padding(
                                                    padding: EdgeInsets.all(16.0),
                                                    child: Text(
                                                      'Нет добавленного оружия',
                                                      textAlign: TextAlign.center,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.inter(),
                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                                    ),
                                                  ),
                                                ...weapons.map((doc) {
                                                  final data = doc.data() as Map<String, dynamic>;
                                                  final name = data['name'] as String? ?? 'Без названия';
                                                  final caliber = data['caliber'] as String? ?? '';
                                                  final isSelected = _model.selectedWeaponId == doc.id;
                                                  return InkWell(
                                                    onTap: () {
                                                      safeSetState(() {
                                                        _model.selectedWeaponId = doc.id;
                                                        _model.selectedWeaponName = name;
                                                        _model.selectedWeaponCaliber = caliber;
                                                        _model.isWeaponDropdownOpen = false;
                                                      });
                                                    },
                                                    child: Container(
                                                      color: isSelected
                                                          ? FlutterFlowTheme.of(context).success10
                                                          : Colors.transparent,
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 16.0, vertical: 12.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    name,
                                                                    style: FlutterFlowTheme.of(context)
                                                                        .labelLarge
                                                                        .override(
                                                                          font: GoogleFonts.spaceGrotesk(
                                                                            fontWeight: FontWeight.w600,
                                                                          ),
                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing: 0.0,
                                                                          fontWeight: FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                  if (caliber.isNotEmpty)
                                                                    Text(
                                                                      caliber,
                                                                      style: FlutterFlowTheme.of(context)
                                                                          .bodySmall
                                                                          .override(
                                                                            font: GoogleFonts.inter(),
                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                            letterSpacing: 0.0,
                                                                          ),
                                                                    ),
                                                                ].divide(SizedBox(height: 2.0)),
                                                              ),
                                                            ),
                                                            if (isSelected)
                                                              Icon(
                                                                Icons.check_circle_rounded,
                                                                color: FlutterFlowTheme.of(context).success,
                                                                size: 20.0,
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                                Divider(
                                                  height: 1.0,
                                                  thickness: 1.0,
                                                  color: FlutterFlowTheme.of(context).alternate,
                                                ),
                                                // Add weapon button
                                                InkWell(
                                                  onTap: () {
                                                    context.pushNamed('addWeapon');
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 16.0, vertical: 14.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.add_circle_outline_rounded,
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                          size: 18.0,
                                                        ),
                                                        SizedBox(width: 8.0),
                                                        Text(
                                                          'Добавить оружие',
                                                          style: FlutterFlowTheme.of(context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts.spaceGrotesk(),
                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                letterSpacing: 0.0,
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
                                      ],
                                    );
                                  },
                                ),
                              ].divide(SizedBox(height: 16.0)),
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
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Цель и Дистанция',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.spaceGrotesk(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.2,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: wrapWithModel(
                                    model: _model.dataInputFieldModelDistance,
                                    updateCallback: () => safeSetState(() {}),
                                    child: DataInputFieldWidget(
                                      hint: '0',
                                      icon: Icon(
                                        Icons.straighten_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 18.0,
                                      ),
                                      label: 'Дистанция',
                                      unit: 'м',
                                      value: '850',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.dataInputFieldModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: DataInputFieldWidget(
                                      hint: '0',
                                      icon: Icon(
                                        Icons.architecture_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 18.0,
                                      ),
                                      label: 'Угол',
                                      unit: '°',
                                      value: '3',
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                          ].divide(SizedBox(height: 16.0)),
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Параметры ветра',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.spaceGrotesk(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                              lineHeight: 1.2,
                                            ),
                                      ),
                                      Icon(
                                        Icons.air_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 20.0,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Направление',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall,
                                            ),
                                            Text(
                                              '${_model.windDirectionHours} ч',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            LayoutBuilder(builder: (context, constraints) {
                                              return GestureDetector(
                                                onPanUpdate: (details) {
                                                  final center =
                                                      constraints.maxWidth / 2;
                                                  final dx = details
                                                          .localPosition.dx -
                                                      center;
                                                  final dy = details
                                                          .localPosition.dy -
                                                      center;
                                                  double angle =
                                                      math.atan2(dx, -dy) *
                                                          (180 / math.pi);
                                                  if (angle < 0) angle += 360;
                                                  int hour =
                                                      ((angle + 15) / 30)
                                                          .floor();
                                                  if (hour <= 0) hour = 12;
                                                  if (hour > 12) hour -= 12;
                                                  safeSetState(() {
                                                    _model.windDirectionHours =
                                                        hour;
                                                  });
                                                },
                                                onTapDown: (details) {
                                                  final center =
                                                      constraints.maxWidth / 2;
                                                  final dx = details
                                                          .localPosition.dx -
                                                      center;
                                                  final dy = details
                                                          .localPosition.dy -
                                                      center;
                                                  double angle =
                                                      math.atan2(dx, -dy) *
                                                          (180 / math.pi);
                                                  if (angle < 0) angle += 360;
                                                  int hour =
                                                      ((angle + 15) / 30)
                                                          .floor();
                                                  if (hour <= 0) hour = 12;
                                                  if (hour > 12) hour -= 12;
                                                  safeSetState(() {
                                                    _model.windDirectionHours =
                                                        hour;
                                                  });
                                                },
                                                child: AspectRatio(
                                                  aspectRatio: 1.0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9999.0),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      children: [
                                                        // Notches
                                                        for (int i = 1;
                                                            i <= 12;
                                                            i++)
                                                          Transform.rotate(
                                                            angle: i *
                                                                30 *
                                                                (math.pi / 180),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment(
                                                                      0, -1),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(4.0),
                                                                child:
                                                                    Container(
                                                                  width: 1.5,
                                                                  height: 6,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                1),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        Transform.rotate(
                                                          angle: (_model
                                                                  .windDirectionHours *
                                                              30.0) *
                                                              (math.pi / 180),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Icon(
                                                            Icons
                                                                .navigation_rounded,
                                                            color:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            size: 32.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ].divide(SizedBox(height: 8.0)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            wrapWithModel(
                                              model:
                                                  _model.dataInputFieldModel2,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: DataInputFieldWidget(
                                                hint: '0',
                                                icon: Icon(
                                                  Icons.speed_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 18.0,
                                                ),
                                                label: 'Скорость',
                                                unit: 'м/с',
                                                value: '4.5',
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Порыв',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts
                                                            .spaceGrotesk(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.1,
                                                      ),
                                                ),
                                                wrapWithModel(
                                                  model: _model
                                                      .switchComponentModel,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: SwitchComponentWidget(
                                                    label: false,
                                                    variant: 'Android',
                                                    active: _model.isGustActive,
                                                    onChanged: (val) async {
                                                      safeSetState(() =>
                                                          _model.isGustActive =
                                                              val);
                                                    },
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 4.0)),
                                            ),
                                            if (_model.isGustActive)
                                              wrapWithModel(
                                                model: _model
                                                    .dataInputFieldModelGust,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: DataInputFieldWidget(
                                                  hint: '0',
                                                  icon: Icon(
                                                    Icons.air_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 18.0,
                                                  ),
                                                  label: 'Порыв',
                                                  unit: 'м/с',
                                                  value: '6.0',
                                                ),
                                              ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 24.0)),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Атмосфера',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.spaceGrotesk(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                        lineHeight: 1.2,
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.help,
                                      color:
                                          FlutterFlowTheme.of(context).success,
                                      size: 16.0,
                                    ),
                                    Text(
                                      'Kestrel 5700 Connected',
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.spaceGrotesk(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .success,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                            lineHeight: 1.1,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 4.0)),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.dataInputFieldModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: DataInputFieldWidget(
                                          hint: '0',
                                          icon: Icon(
                                            Icons.device_thermostat_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 18.0,
                                          ),
                                          label: 'Температура',
                                          unit: '°C',
                                          value: '18',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.dataInputFieldModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: DataInputFieldWidget(
                                          hint: '0',
                                          icon: Icon(
                                            Icons.compress_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 18.0,
                                          ),
                                          label: 'Давление',
                                          unit: 'hPa',
                                          value: '1005',
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                ),
                                wrapWithModel(
                                  model: _model.dataInputFieldModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: DataInputFieldWidget(
                                    hint: '0',
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 18.0,
                                    ),
                                    label: 'Влажность',
                                    unit: '%',
                                    value: '45',
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                          ].divide(SizedBox(height: 16.0)),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Ожидаемый разброс',
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                                lineHeight: 1.1,
                                              ),
                                        ),
                                        Text(
                                          '${((double.tryParse(distanceText) ?? 0.0) / 100 * 2.91 * (1.0 + (_model.isGustActive ? 0.2 : 0.0))).toStringAsFixed(1)} см',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                font: GoogleFonts.spaceGrotesk(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .success,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                                lineHeight: 1.2,
                                              ),
                                        ),
                                      ],
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(9999.0),
                                    child: Container(
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(9999.0),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .success,
                                                shape: BoxShape.rectangle,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                shape: BoxShape.rectangle,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                shape: BoxShape.rectangle,
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 0.0)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Ожидаемый диаметр группы на дистанции ${distanceText}м',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                          lineHeight: 1.3,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 24.0,
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Container(
                            child: wrapWithModel(
                              model: _model.buttonModel,
                              updateCallback: () => safeSetState(() {}),
                              child: ButtonWidget(
                                content: 'РАССЧИТАТЬ',
                                icon: Icon(
                                  Icons.analytics_rounded,
                                  color: FlutterFlowTheme.of(context).onPrimary,
                                  size: 16.0,
                                ),
                                icon_present: true,
                                icon_end_present: false,
                                color: FlutterFlowTheme.of(context).primary,
                                variant: 'primary',
                                size: 'large',
                                full_width: true,
                                loading: _model.isLoading,
                                disabled: _model.isLoading,
                                onPressed: () async {
                                  // Validate fields
                                  if (_model.selectedWeaponId == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Пожалуйста, выберите оружие')),
                                    );
                                    return;
                                  }
                                  if (distanceText.isEmpty ||
                                      angleText.isEmpty ||
                                      speedText.isEmpty ||
                                      tempText.isNotEmpty == false ||
                                      pressureText.isEmpty ||
                                      humidityText.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Пожалуйста, заполните все основные поля')),
                                    );
                                    return;
                                  }
                                  if (_model.isGustActive && gustText.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Пожалуйста, укажите скорость порыва')),
                                    );
                                    return;
                                  }

                                    safeSetState(() => _model.isLoading = true);
                                    try {
                                      // Fetch weapon data for the calculation
                                      final weaponDoc = await FirebaseFirestore
                                          .instance
                                          .collection('users')
                                          .doc(currentUserUid)
                                          .collection('weapons')
                                          .doc(_model.selectedWeaponId)
                                          .get();

                                      if (!weaponDoc.exists) {
                                        throw Exception(
                                            'Данные об оружии не найдены');
                                      }

                                      final weaponData = weaponDoc.data()!;
                                      final muzzleVelocity = double.tryParse(
                                              weaponData['muzzle_velocity']
                                                      ?.toString() ??
                                                  '0') ??
                                          800.0;
                                      final bcValue = double.tryParse(
                                              weaponData['bc_value']
                                                      ?.toString() ??
                                                  '0') ??
                                          0.3;
                                      final bulletWeight = double.tryParse(
                                              weaponData['bullet_weight']
                                                      ?.toString() ??
                                                  '0') ??
                                          9.0;
                                      final sightHeight = double.tryParse(
                                              weaponData['sight_height']
                                                      ?.toString() ??
                                                  '0') ??
                                          50.0;
                                      final clickValue = double.tryParse(
                                              weaponData['click_value']
                                                      ?.toString() ??
                                                  '0') ??
                                          0.1;

                                      // Calculate results to save them in history
                                      final ballisticResult =
                                          BallisticEngine.calculate(
                                        v0: muzzleVelocity,
                                        bc: bcValue,
                                        weightGrams: bulletWeight,
                                        distance: double.tryParse(distanceText) ?? 0.0,
                                        windSpeed: double.tryParse(speedText) ?? 0.0,
                                        windDirectionHours: _model.windDirectionHours.toDouble(),
                                        temperatureC: double.tryParse(tempText) ?? 0.0,
                                        pressureHpa: double.tryParse(pressureText) ?? 0.0,
                                        sightHeightMm: sightHeight,
                                        clickValue: clickValue,
                                      );

                                      final resultData = {
                                        'weaponId': _model.selectedWeaponId,
                                        'weaponName': _model.selectedWeaponName,
                                        'distance':
                                            double.tryParse(distanceText) ?? 0.0,
                                        'angle':
                                            double.tryParse(angleText) ?? 0.0,
                                        'windSpeed':
                                            double.tryParse(speedText) ?? 0.0,
                                        'windDirection':
                                            _model.windDirectionHours,
                                        'isGustActive': _model.isGustActive,
                                        'gustSpeed': _model.isGustActive
                                            ? (double.tryParse(gustText) ?? 0.0)
                                            : 0.0,
                                        'temperature':
                                            double.tryParse(tempText) ?? 0.0,
                                        'pressure':
                                            double.tryParse(pressureText) ?? 0.0,
                                        'humidity':
                                            double.tryParse(humidityText) ?? 0.0,
                                        'windDirection': _model.windDirectionHours,
                                        'muzzleVelocity': muzzleVelocity,
                                        'bcValue': bcValue,
                                        'bulletWeight': bulletWeight,
                                        'sightHeight': sightHeight,
                                        'clickValue': clickValue,
                                        'vertical_correction': ballisticResult.verticalMrad.toStringAsFixed(1),
                                        'horizontal_correction': ballisticResult.horizontalMrad.toStringAsFixed(1),
                                        'timestamp': FieldValue.serverTimestamp(),
                                        'userId': currentUserUid,
                                      };

                                      final docRef = await FirebaseFirestore.instance
                                          .collection('shootResults')
                                          .add(resultData)
                                          .timeout(Duration(seconds: 5));

                                      if (context.mounted) {
                                        safeSetState(
                                            () => _model.isLoading = false);

                                        final clearNeeded =
                                            await context.pushNamed<bool>(
                                          'shootResult',
                                          queryParameters: {
                                            'resultId': docRef.id,
                                            'distance': distanceText,
                                            'windSpeed': speedText,
                                            'windDirection': _model
                                                .windDirectionHours
                                                .toString(),
                                            'muzzleVelocity':
                                                muzzleVelocity.toString(),
                                            'bcValue': bcValue.toString(),
                                            'bulletWeight':
                                                bulletWeight.toString(),
                                            'temperature': tempText,
                                            'pressure': pressureText,
                                            'angle': angleText,
                                            'sightHeight':
                                                sightHeight.toString(),
                                            'clickValue':
                                                clickValue.toString(),
                                          }.withoutNulls,
                                        );

                                      if (clearNeeded == true) {
                                        safeSetState(() {
                                          _model.clearFields();
                                        });
                                      }
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Ошибка при сохранении: $e')),
                                      );
                                    }
                                    if (mounted) {
                                      safeSetState(
                                          () => _model.isLoading = false);
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
