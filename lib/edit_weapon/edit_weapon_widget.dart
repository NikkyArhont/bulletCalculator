import '/components/button_widget.dart';
import '/components/section_header_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/units_util.dart';
import '/components/delete_weapon_widget.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_weapon_model.dart';
export 'edit_weapon_model.dart';

class EditWeaponWidget extends StatefulWidget {
  const EditWeaponWidget({
    super.key,
    this.weaponRef,
    this.weaponData,
  });

  final DocumentReference? weaponRef;
  final Map<String, dynamic>? weaponData;

  static String routeName = 'editWeapon';
  static String routePath = '/editWeapon';

  @override
  State<EditWeaponWidget> createState() => _EditWeaponWidgetState();
}

class _EditWeaponWidgetState extends State<EditWeaponWidget> {
  late EditWeaponModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditWeaponModel());

    // Populate controllers with existing data
    if (widget.weaponData != null) {
      final wd = widget.weaponData!;
      final isMetric = UnitsManager.instance.distanceUnit == DistanceUnit.m;

      _model.textFieldModel1.inputTextController ??= TextEditingController();
      _model.textFieldModel1.inputTextController?.text = wd['name'] ?? '';

      // Conversions for display if not metric
      double rawSH = double.tryParse(wd['sight_height']?.toString() ?? '0') ?? 0;
      final sH = isMetric ? rawSH : rawSH / 25.4;
      _model.textFieldModel2.inputTextController ??= TextEditingController();
      _model.textFieldModel2.inputTextController?.text = sH.toStringAsFixed(1);

      double rawZD = double.tryParse(wd['zero_distance']?.toString() ?? '0') ?? 0;
      final zD = isMetric ? rawZD : rawZD / 0.9144;
      _model.textFieldModel3.inputTextController ??= TextEditingController();
      _model.textFieldModel3.inputTextController?.text = zD.toStringAsFixed(0);

      double rawTwist = double.tryParse(wd['twist']?.toString() ?? '0') ?? 0;
      final tw = isMetric ? rawTwist : rawTwist / 25.4;
      _model.textFieldModel4.inputTextController ??= TextEditingController();
      _model.textFieldModel4.inputTextController?.text = tw.toStringAsFixed(1);

      _model.textFieldModel5.inputTextController ??= TextEditingController();
      _model.textFieldModel5.inputTextController?.text =
          wd['click_value']?.toString() ?? '';
      _model.clickTypeValue = wd['click_type'] ?? 'MRAD';

      _model.textFieldModel6.inputTextController ??= TextEditingController();
      _model.textFieldModel6.inputTextController?.text =
          wd['bullet_weight']?.toString() ?? '';
      _model.textFieldModel7.inputTextController ??= TextEditingController();
      _model.textFieldModel7.inputTextController?.text =
          wd['bullet_length']?.toString() ?? '';

      double rawMV = double.tryParse(wd['muzzle_velocity']?.toString() ?? '0') ?? 0;
      final mV = isMetric ? rawMV : rawMV / 0.3048;
      _model.textFieldModel8.inputTextController ??= TextEditingController();
      _model.textFieldModel8.inputTextController?.text = mV.toStringAsFixed(0);

      _model.dropdownValue = wd['bc_model'] ?? 'G7';
      _model.textFieldModel9.inputTextController ??= TextEditingController();
      _model.textFieldModel9.inputTextController?.text =
          wd['bc_value']?.toString() ?? '';
      _model.twistDir = wd['twist_direction'] == 'left' ? 'Левое' : 'Правое';
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMetric = UnitsManager.instance.distanceUnit == DistanceUnit.m;

    double? parseVal(String? text) {
      if (text == null || text.trim().isEmpty) return null;
      return double.tryParse(text.trim().replaceAll(',', '.'));
    }

    // Name
    final name = _model.textFieldModel1.inputTextController?.text.trim() ?? '';
    final nameValid = name.isNotEmpty;

    // Sight Height (20-120 mm)
    final sHText = _model.textFieldModel2.inputTextController?.text ?? '';
    final sH = parseVal(sHText);
    final sHValid = sH != null &&
        (isMetric
            ? (sH >= 20 && sH <= 120)
            : (sH * 25.4 >= 20 && sH * 25.4 <= 120));
    final sHErr = sHText.trim().isNotEmpty && !sHValid;

    // Zero Distance (10-1000 m)
    final zDText = _model.textFieldModel3.inputTextController?.text ?? '';
    final zD = parseVal(zDText);
    final zDValid = zD != null &&
        (isMetric
            ? (zD >= 10 && zD <= 1000)
            : (zD * 0.9144 >= 10 && zD * 0.9144 <= 1000));
    final zDErr = zDText.trim().isNotEmpty && !zDValid;

    // Twist (100-600 mm)
    final twText = _model.textFieldModel4.inputTextController?.text ?? '';
    final tw = parseVal(twText);
    final twValid = tw != null &&
        (isMetric
            ? (tw >= 100 && tw <= 600)
            : (tw * 25.4 >= 100 && tw * 25.4 <= 600));
    final twErr = twText.trim().isNotEmpty && !twValid;

    // Click Value (0.001 - 5.0)
    final cVText = _model.textFieldModel5.inputTextController?.text ?? '';
    final cV = parseVal(cVText);
    final cVValid = cV != null && cV > 0 && cV <= 5.0;
    final cVErr = cVText.trim().isNotEmpty && !cVValid;

    // Bullet Weight (10-1000 grain)
    final bWText = _model.textFieldModel6.inputTextController?.text ?? '';
    final bW = parseVal(bWText);
    final bWValid = bW != null && bW >= 10 && bW <= 1000;
    final bWErr = bWText.trim().isNotEmpty && !bWValid;

    // Bullet Length (3-80 mm)
    final bLText = _model.textFieldModel7.inputTextController?.text ?? '';
    final bL = parseVal(bLText);
    final bLValid = bL != null && bL >= 3 && bL <= 80;
    final bLErr = bLText.trim().isNotEmpty && !bLValid;

    // Muzzle Velocity (100-1500 m/s)
    final mVText = _model.textFieldModel8.inputTextController?.text ?? '';
    final mV = parseVal(mVText);
    final mVValid = mV != null &&
        (isMetric
            ? (mV >= 100 && mV <= 1500)
            : (mV * 0.3048 >= 100 && mV * 0.3048 <= 1500));
    final mVErr = mVText.trim().isNotEmpty && !mVValid;

    // BC Value (0.05-1.5)
    final bcVText = _model.textFieldModel9.inputTextController?.text ?? '';
    final bcV = parseVal(bcVText);
    final bcVValid = bcV != null && bcV >= 0.05 && bcV <= 1.5;
    final bcVErr = bcVText.trim().isNotEmpty && !bcVValid;

    final isFormValid = nameValid &&
        sHValid &&
        zDValid &&
        twValid &&
        cVValid &&
        bWValid &&
        bLValid &&
        mVValid &&
        bcVValid;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 440.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 16.0),
                      child: Container(
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  context.safePop();
                                },
                              ),
                              Container(
                                child: Text(
                                  'Редактирование оружия',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.spaceGrotesk(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                              ),
                            ],
                          ),
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
                    wrapWithModel(
                      model: _model.sectionHeaderModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: SectionHeaderWidget(
                        title: 'ОСНОВНЫЕ ПАРАМЕТРЫ',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                              wrapWithModel(
                                model: _model.textFieldModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: TextFieldWidget(
                                  label: 'Название профиля',
                                  helper: null,
                                  hint: 'Напр. Tikka T3x .308',
                                  value: '',
                                  leading_icon: Icon(
                                    Icons.precision_manufacturing_rounded,
                                  ),
                                  leading_icon_present: true,
                                  trailing_icon_present: false,
                                  border: Color(0x00000000),
                                  hint_color: 'hint',
                                  variant: 'outlined',
                                  error: false,
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
                                      model: _model.textFieldModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldWidget(
                                        label: 'Высота прицела',
                                        helper: sHErr ? (isMetric ? '20–120 мм' : '0.8–4.7 дюйм') : (isMetric ? 'мм' : 'дюймов'),
                                        hint: '5.0',
                                        value: '',
                                        leading_icon_present: false,
                                        trailing_icon: Icon(
                                          Icons.straighten_rounded,
                                        ),
                                        trailing_icon_present: true,
                                        border: Color(0x00000000),
                                        hint_color: 'hint',
                                        variant: 'outlined',
                                        error: sHErr,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.textFieldModel3,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldWidget(
                                        label: 'Дист. пристрелки',
                                        helper: zDErr ? (isMetric ? '10–1000 м' : '10–1100 ярд') : UnitsManager.instance.distanceLabel,
                                        hint: '100',
                                        value: '',
                                        leading_icon_present: false,
                                        trailing_icon: Icon(
                                          Icons.flag_rounded,
                                        ),
                                        trailing_icon_present: true,
                                        border: Color(0x00000000),
                                        hint_color: 'hint',
                                        variant: 'outlined',
                                        error: zDErr,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.sectionHeaderModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: SectionHeaderWidget(
                        title: 'СТВОЛ И ОПТИКА',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.textFieldModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldWidget(
                                        label: 'Твист (шаг)',
                                        helper: twErr ? (isMetric ? '100–600 мм' : '4–24 дюйма') : (isMetric ? 'мм' : 'дюймов'),
                                        hint: '10',
                                        value: '',
                                        leading_icon_present: false,
                                        trailing_icon_present: false,
                                        border: Color(0x00000000),
                                        hint_color: 'hint',
                                        variant: 'outlined',
                                        error: twErr,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.textFieldModel5,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldWidget(
                                        label: 'Цена клика',
                                        helper: cVErr ? '0.001–5.0' : 'MRAD / MOA',
                                        hint: '0.1',
                                        value: '',
                                        leading_icon_present: false,
                                        trailing_icon_present: false,
                                        border: Color(0x00000000),
                                        hint_color: 'hint',
                                        variant: 'outlined',
                                        error: cVErr,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Направление нарезов',
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                font: GoogleFonts.spaceGrotesk(
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
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .primary,
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
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  _model.twistDir = 'Правое';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: _model.twistDir == 'Правое'
                                                        ? FlutterFlowTheme.of(context).primary
                                                        : FlutterFlowTheme.of(context).secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(8.0),
                                                    border: Border.all(
                                                      color: _model.twistDir == 'Правое'
                                                          ? FlutterFlowTheme.of(context).primary
                                                          : FlutterFlowTheme.of(context).alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (_model.twistDir == 'Правое')
                                                          Icon(
                                                            Icons.check_rounded,
                                                            color:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .onPrimary,
                                                            size: 16.0,
                                                          ),
                                                        Text(
                                                          'Правое',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .spaceGrotesk(
                                                                  fontWeight:
                                                                      FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                  fontStyle:
                                                                      FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                ),
                                                                color: _model.twistDir == 'Правое'
                                                                    ? FlutterFlowTheme.of(context).onPrimary
                                                                    : FlutterFlowTheme.of(context).primaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                fontStyle:
                                                                    FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                lineHeight: 1.1,
                                                              ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 6.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  _model.twistDir = 'Левое';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: _model.twistDir == 'Левое'
                                                        ? FlutterFlowTheme.of(context).primary
                                                        : FlutterFlowTheme.of(context).secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(8.0),
                                                    border: Border.all(
                                                      color: _model.twistDir == 'Левое'
                                                          ? FlutterFlowTheme.of(context).primary
                                                          : FlutterFlowTheme.of(context).alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (_model.twistDir == 'Левое')
                                                          Icon(
                                                            Icons.check_rounded,
                                                            color:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .onPrimary,
                                                            size: 16.0,
                                                          ),
                                                        Text(
                                                          'Левое',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .spaceGrotesk(
                                                                  fontWeight:
                                                                      FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                  fontStyle:
                                                                      FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                ),
                                                                color: _model.twistDir == 'Левое'
                                                                    ? FlutterFlowTheme.of(context).onPrimary
                                                                    : FlutterFlowTheme.of(context).primaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                fontStyle:
                                                                    FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                lineHeight: 1.1,
                                                              ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 6.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Тип клика',
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                font: GoogleFonts.spaceGrotesk(
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
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .primary,
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
                                        FlutterFlowDropDown<String>(
                                          controller: _model
                                                  .clickTypeController ??=
                                              FormFieldController<String>(
                                            _model.clickTypeValue ??= 'MRAD',
                                          ),
                                          options: ['MRAD', 'MOA'],
                                          onChanged: (val) => safeSetState(
                                              () => _model.clickTypeValue =
                                                  val),
                                          width: double.infinity,
                                          height: 40.0,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
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
                                                    .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                          hintText: 'MRAD',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          elevation: 2.0,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          borderWidth: 1.0,
                                          borderRadius: 8.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          hidesUnderline: true,
                                          isOverButton: false,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.sectionHeaderModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: SectionHeaderWidget(
                        title: 'БОЕПРИПАС И БАЛЛИСТИКА',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.textFieldModel6,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldWidget(
                                        label: 'Вес пули',
                                        helper: bWErr ? '10–1000 grain' : 'grain',
                                        hint: '175',
                                        value: '',
                                        leading_icon_present: false,
                                        trailing_icon_present: false,
                                        border: Color(0x00000000),
                                        hint_color: 'hint',
                                        variant: 'outlined',
                                        error: bWErr,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.textFieldModel7,
                                      updateCallback: () => safeSetState(() {}),
                                      child: TextFieldWidget(
                                        label: 'Длина пули',
                                        helper: bLErr ? '3–80 мм' : 'мм',
                                        hint: '32.5',
                                        value: '',
                                        leading_icon_present: false,
                                        trailing_icon_present: false,
                                        border: Color(0x00000000),
                                        hint_color: 'hint',
                                        variant: 'outlined',
                                        error: bLErr,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                              wrapWithModel(
                                model: _model.textFieldModel8,
                                updateCallback: () => safeSetState(() {}),
                                child: TextFieldWidget(
                                  label: 'Начальная скорость',
                                  helper: mVErr ? (isMetric ? '100–1500 м/с' : '328–4921 fps') : (isMetric ? 'м/с' : 'fps'),
                                  hint: '820',
                                  value: '',
                                  leading_icon: Icon(
                                    Icons.speed_rounded,
                                  ),
                                  leading_icon_present: true,
                                  trailing_icon_present: false,
                                  border: Color(0x00000000),
                                  hint_color: 'hint',
                                  variant: 'outlined',
                                  error: mVErr,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                                ),
                              ),
                              Divider(
                                height: 16.0,
                                thickness: 1.0,
                                indent: 0.0,
                                endIndent: 0.0,
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Баллистический коэффициент',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: FlutterFlowDropDown<String>(
                                          controller:
                                              _model.dropdownValueController ??=
                                                  FormFieldController<String>(
                                            _model.dropdownValue ??= 'G7',
                                          ),
                                          options: ['G7', 'G1', 'Custom'],
                                          onChanged: (val) => safeSetState(
                                              () => _model.dropdownValue = val),
                                          width: 200.0,
                                          height: 40.0,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
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
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                          hintText: 'G7',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          elevation: 2.0,
                                          borderColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          borderWidth: 1.0,
                                          borderRadius: 8.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          hidesUnderline: true,
                                          isOverButton: false,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                          labelText: 'Модель',
                                          labelTextStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.spaceGrotesk(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                                lineHeight: 1.1,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: wrapWithModel(
                                          model: _model.textFieldModel9,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'Значение BC',
                                            helper: bcVErr ? '0.05–1.5' : null,
                                            hint: '0.243',
                                            value: '',
                                            leading_icon_present: false,
                                            trailing_icon_present: false,
                                            border: Color(0x00000000),
                                            hint_color: 'hint',
                                            variant: 'outlined',
                                            error: bcVErr,
                                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 16.0)),
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(6.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: FlutterFlowTheme.of(context).tertiary,
                                size: 20.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Убедитесь в точности ввода данных. Ошибка в высоте прицела на 5мм может дать существенное отклонение на дистанциях свыше 500м.',
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                        lineHeight: 1.3,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.buttonModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        content: 'Сохранить изменения',
                        icon: Icon(
                          Icons.check_circle_rounded,
                          color: FlutterFlowTheme.of(context).onPrimary,
                          size: 16.0,
                        ),
                        icon_present: true,
                        icon_end_present: false,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        loading: _isSaving,
                        disabled: !isFormValid || _isSaving,
                        onPressed: () async {
                          if (widget.weaponRef == null) return;

                          safeSetState(() => _isSaving = true);
                          try {
                            // Final conversion before persistence
                            final finalSH =
                                isMetric ? sH! : sH! * 25.4; // inches to mm
                            final finalZD =
                                isMetric ? zD! : zD! * 0.9144; // yards to m
                            final finalTwist =
                                isMetric ? tw! : tw! * 25.4; // inches to mm
                            final finalMV =
                                isMetric ? mV! : mV! * 0.3048; // fps to m/s

                            await widget.weaponRef!.update({
                              'name': name,
                              'sight_height': finalSH.toString(),
                              'zero_distance': finalZD.toString(),
                              'twist': finalTwist.toString(),
                              'twist_direction':
                                  _model.twistDir == 'Левое' ? 'left' : 'right',
                              'click_value': cV.toString(),
                              'click_type': _model.clickTypeValue,
                              'bullet_weight': bW.toString(),
                              'bullet_length': bL.toString(),
                              'muzzle_velocity': finalMV.toString(),
                              'bc_model': _model.dropdownValue,
                              'bc_value': bcV.toString(),
                              'updated_at': FieldValue.serverTimestamp(),
                            });

                            context.safePop();
                          } finally {
                            if (mounted) {
                              safeSetState(() => _isSaving = false);
                            }
                          }
                        },
                      ),
                    ),
                    wrapWithModel(
                      model: _model.buttonModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        content: 'Удалить оружие',
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 16.0,
                        ),
                        icon_present: true,
                        icon_end_present: false,
                        color: FlutterFlowTheme.of(context).error,
                        variant: 'ghost',
                        size: 'medium',
                        full_width: true,
                        loading: false,
                        disabled: false,
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: DeleteWeaponWidget(
                                  onConfirm: () async {
                                    if (widget.weaponRef != null) {
                                      await widget.weaponRef!.delete();
                                      context.safePop();
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 24.0,
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
