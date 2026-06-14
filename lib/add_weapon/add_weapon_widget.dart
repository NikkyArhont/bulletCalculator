import '/components/button_widget.dart';
import '/components/section_header_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/units_util.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/ballistic_engine.dart';
import 'add_weapon_model.dart';
export 'add_weapon_model.dart';

class AddWeaponWidget extends StatefulWidget {
  const AddWeaponWidget({super.key});

  static String routeName = 'addWeapon';
  static String routePath = '/addWeapon';

  @override
  State<AddWeaponWidget> createState() => _AddWeaponWidgetState();
}

class _AddWeaponWidgetState extends State<AddWeaponWidget> {
  late AddWeaponModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddWeaponModel());
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

    // Sight Height (2-12 cm)
    final sHText = _model.textFieldModel2.inputTextController?.text ?? '';
    final sH = parseVal(sHText);
    final sHValid = sH != null && (sH >= 2.0 && sH <= 12.0);
    final sHErr = sHText.trim().isNotEmpty && !sHValid;

    // Zero Distance (10-1000 m)
    final zDText = _model.textFieldModel3.inputTextController?.text ?? '';
    final zD = parseVal(zDText);
    final zDValid = zD != null &&
        (isMetric
            ? (zD >= 10 && zD <= 1000)
            : (zD * 0.9144 >= 10 && zD * 0.9144 <= 1000));
    final zDErr = zDText.trim().isNotEmpty && !zDValid;

    // Twist (4-24 inches)
    final twText = _model.textFieldModel4.inputTextController?.text ?? '';
    final tw = parseVal(twText);
    final twValid = tw != null && (tw >= 4.0 && tw <= 24.0);
    final twErr = twText.trim().isNotEmpty && !twValid;

    // Click Value (> 0)
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

    // Caliber (4-20 mm)
    final calText = _model.textFieldModel10.inputTextController?.text ?? '';
    final cal = parseVal(calText);
    final calValid = cal != null && (isMetric ? (cal >= 4.0 && cal <= 20.0) : (cal * 25.4 >= 4.0 && cal * 25.4 <= 20.0));
    final calErr = calText.trim().isNotEmpty && !calValid;

    final isFormValid = nameValid &&
        sHValid &&
        zDValid &&
        twValid &&
        cVValid &&
        bWValid &&
        bLValid &&
        mVValid &&
        bcVValid &&
        calValid;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).surface20,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 24.0, 16.0, 24.0),
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
                                color: FlutterFlowTheme.of(context).primary,
                                size: 24.0,
                              ),
                              onPressed: () {
                                context.safePop();
                              },
                            ),
                            Text(
                              'weapon.new_title'.tr(),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.2,
                                  ),
                            ),
                            Container(
                              width: 48.0,
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.sectionHeaderModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: SectionHeaderWidget(
                            title: 'weapon.section_main'.tr(),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(4.0),
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
                                      label: 'weapon.profile_name'.tr(),
                                      helper: null,
                                      hint: 'weapon.profile_name_hint'.tr(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: wrapWithModel(
                                          model: _model.textFieldModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'weapon.sight_height'.tr(),
                                            helper: sHErr ? 'weapon.sight_height_err'.tr() : 'common.cm'.tr(),
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
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'weapon.zero_dist'.tr(),
                                            helper: zDErr ? (isMetric ? 'weapon.zero_dist_err_metric'.tr() : 'weapon.zero_dist_err_imperial'.tr()) : UnitsManager.instance.distanceLabel,
                                            hint: '100',
                                            value: '',
                                            leading_icon_present: false,
                                            trailing_icon: Icon(
                                              Icons.gps_fixed_rounded,
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
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.sectionHeaderModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: SectionHeaderWidget(
                            title: 'weapon.section_barrel_optics'.tr(),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(4.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: wrapWithModel(
                                          model: _model.textFieldModel4,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'weapon.twist'.tr(),
                                            helper: twErr ? 'weapon.twist_err'.tr() : 'weapon.twist_units'.tr(),
                                            hint: '10',
                                            value: '',
                                            leading_icon: Icon(
                                              Icons.reorder_rounded,
                                            ),
                                            leading_icon_present: true,
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
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'weapon.click_val'.tr(),
                                            helper: cVErr ? '0.001–5.0' : 'MRAD / MOA',
                                            hint: '0.1',
                                            value: '',
                                            leading_icon: Icon(
                                              Icons.ads_click_rounded,
                                            ),
                                            leading_icon_present: true,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'weapon.click_type'.tr(),
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                            FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .clickTypeController ??=
                                                  FormFieldController<String>(
                                                _model.clickTypeValue ??=
                                                    'MRAD',
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
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .secondaryText,
                                                size: 24.0,
                                              ),
                                              fillColor: FlutterFlowTheme.of(
                                                      context)
                                                  .secondaryBackground,
                                              elevation: 2.0,
                                              borderColor: FlutterFlowTheme.of(
                                                      context)
                                                  .alternate,
                                              borderWidth: 1.0,
                                              borderRadius: 8.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              hidesUnderline: true,
                                              isOverButton: false,
                                              isSearchable: false,
                                              isMultiSelect: false,
                                            ),
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
                                            Text(
                                              'weapon.twist_dir'.tr(),
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => safeSetState(() =>
                                                      _model.isRightTwist =
                                                          true),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: _model.isRightTwist
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: _model
                                                                .isRightTwist
                                                            ? FlutterFlowTheme.of(
                                                                    context)
                                                                .primary
                                                            : FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(12.0,
                                                                  10.0, 12.0, 10.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          if (_model
                                                              .isRightTwist)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          6.0,
                                                                          0.0),
                                                              child: Icon(
                                                                Icons
                                                                    .check_rounded,
                                                                color:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .onPrimary,
                                                                size: 14.0,
                                                              ),
                                                            ),
                                                          Text(
                                                            'weapon.right'.tr(),
                                                            style: FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts.spaceGrotesk(
                                                                    fontWeight:
                                                                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                    fontStyle:
                                                                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                  ),
                                                                  color: _model
                                                                          .isRightTwist
                                                                      ? FlutterFlowTheme.of(context).onPrimary
                                                                      : FlutterFlowTheme.of(context).secondaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                  fontStyle:
                                                                      FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                  lineHeight:
                                                                      1.1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => safeSetState(() =>
                                                      _model.isRightTwist =
                                                          false),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: !_model
                                                              .isRightTwist
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                        color: !_model
                                                                .isRightTwist
                                                            ? FlutterFlowTheme.of(
                                                                    context)
                                                                .primary
                                                            : FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(12.0,
                                                                  10.0, 12.0, 10.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          if (!_model
                                                              .isRightTwist)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          6.0,
                                                                          0.0),
                                                              child: Icon(
                                                                Icons
                                                                    .check_rounded,
                                                                color:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .onPrimary,
                                                                size: 14.0,
                                                              ),
                                                            ),
                                                          Text(
                                                            'weapon.left'.tr(),
                                                            style: FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts.spaceGrotesk(
                                                                    fontWeight:
                                                                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                    fontStyle:
                                                                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                  ),
                                                                  color: !_model
                                                                          .isRightTwist
                                                                      ? FlutterFlowTheme.of(context).onPrimary
                                                                      : FlutterFlowTheme.of(context).secondaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                  fontStyle:
                                                                      FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                  lineHeight:
                                                                      1.1,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
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
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.sectionHeaderModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: SectionHeaderWidget(
                            title: 'weapon.section_ammo_ballistics'.tr(),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(4.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: wrapWithModel(
                                          model: _model.textFieldModel6,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'weapon.bullet_weight'.tr(),
                                            helper: bWErr ? 'weapon.err_bullet_weight_range'.tr() : 'grain',
                                            hint: '175',
                                            value: '',
                                            leading_icon: Icon(
                                              Icons.monitor_weight_rounded,
                                            ),
                                            leading_icon_present: true,
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
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'weapon.bullet_length'.tr(),
                                            helper: bLErr ? 'weapon.bullet_length_err'.tr() : 'units.mm'.tr(),
                                            hint: '32.5',
                                            value: '',
                                            leading_icon: Icon(
                                              Icons.height_rounded,
                                            ),
                                            leading_icon_present: true,
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
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: wrapWithModel(
                                          model: _model.textFieldModel10,
                                          updateCallback: () => safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'weapon.caliber'.tr(),
                                            helper: calErr ? (isMetric ? 'weapon.caliber_err_metric'.tr() : 'weapon.caliber_err_imperial'.tr()) : (isMetric ? 'units.mm'.tr() : 'weapon.twist_units'.tr()),
                                            hint: '7.62',
                                            value: '',
                                            leading_icon: Icon(
                                              Icons.radio_button_checked,
                                            ),
                                            leading_icon_present: true,
                                            trailing_icon_present: false,
                                            border: Color(0x00000000),
                                            hint_color: 'hint',
                                            variant: 'outlined',
                                            error: calErr,
                                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: wrapWithModel(
                                          model: _model.textFieldModel8,
                                          updateCallback: () => safeSetState(() {}),
                                          child: TextFieldWidget(
                                            label: 'weapon.mv'.tr(),
                                            helper: mVErr ? (isMetric ? 'weapon.mv_err_metric'.tr() : 'weapon.mv_err_imperial'.tr()) : (isMetric ? 'units.speed_m_s'.tr() : 'fps'),
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
                                      ),
                                    ].divide(SizedBox(width: 16.0)),
                                  ),
                                  Divider(
                                    height: 16.0,
                                    thickness: 1.0,
                                    indent: 0.0,
                                    endIndent: 0.0,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'weapon.bc_uppercase'.tr(),
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
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                      Row(
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
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: FlutterFlowDropDown<
                                                      String>(
                                                    controller: _model
                                                            .dropdownValueController ??=
                                                        FormFieldController<
                                                            String>(
                                                      _model.dropdownValue ??=
                                                          'G7',
                                                    ),
                                                    options: [
                                                      'G7',
                                                      'G1',
                                                      'Custom'
                                                    ],
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .dropdownValue =
                                                            val),
                                                    width: 200.0,
                                                    height: 40.0,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
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
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
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
                                                    hintText: 'G7',
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                    fillColor:
                                                        FlutterFlowTheme.of(context).secondaryBackground,
                                                    elevation: 2.0,
                                                    borderColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                    borderWidth: 1.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    hidesUnderline: true,
                                                    isOverButton: false,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                    labelText: 'weapon.bc_model'.tr(),
                                                    labelTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts.spaceGrotesk(),
                                                              letterSpacing:
                                                                  0.0,
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
                                                              lineHeight: 1.1,
                                                            ),
                                                  ),
                                                ),
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
                                            label: 'weapon.bc_value'.tr(),
                                            helper: bcVErr ? 'weapon.err_bc_range'.tr() : null,
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
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.sectionHeaderModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: SectionHeaderWidget(
                            title: 'weapon.section_calibration'.tr(),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(4.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: _buildCalibrationUI(context, isMetric, parseVal),
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).background40,
                        borderRadius: BorderRadius.circular(4.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).accent30,
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
                                Icons.warning_amber_rounded,
                                color: FlutterFlowTheme.of(context).tertiary,
                                size: 20.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'weapon.warning_sight_height'.tr(),
                                  maxLines: 3,
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
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                      child: wrapWithModel(
                        model: _model.buttonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ButtonWidget(
                          content: 'weapon.add_btn'.tr(),
                          icon: Icon(
                            Icons.security_rounded,
                            color: FlutterFlowTheme.of(context).onPrimary,
                            size: 16.0,
                          ),
                          icon_present: false,
                          icon_end_present: false,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          variant: 'primary',
                          size: 'large',
                          full_width: true,
                          loading: _model.isLoading,
                          disabled: _model.isLoading,
                          onPressed: () async {
                            safeSetState(() => _model.isLoading = true);
                            try {
                              final uid = currentUserUid;
                              if (uid == null || uid.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('weapon.err_auth'.tr())));
                                safeSetState(() => _model.isLoading = false);
                                return;
                              }
                              final name = _model.textFieldModel1
                                      .inputTextController?.text.trim() ??
                                  '';
                              if (name.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('weapon.err_name'.tr())));
                                safeSetState(() => _model.isLoading = false);
                                return;
                              }

                              final isMetric =
                                  UnitsManager.instance.distanceUnit ==
                                      DistanceUnit.m;

                              double? parseValue(String? text) {
                                if (text == null || text.trim().isEmpty)
                                  return null;
                                return double.tryParse(
                                    text.trim().replaceAll(',', '.'));
                              }

                              void showError(String msg) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(msg)));
                                safeSetState(() => _model.isLoading = false);
                              }

                              double? sH = parseValue(_model.textFieldModel2
                                  .inputTextController?.text);
                              if (sH == null) {
                                showError('weapon.err_sight_height_empty'.tr());
                                return;
                              }
                              if (sH < 2.0 || sH > 12.0) {
                                showError('weapon.err_sight_height_range'.tr());
                                return;
                              }

                              double? zD = parseValue(_model.textFieldModel3
                                  .inputTextController?.text);
                              if (zD == null) {
                                showError('weapon.err_zero_dist_empty'.tr());
                                return;
                              }
                              if (!isMetric) zD *= 0.9144;
                              if (zD < 10 || zD > 1000) {
                                showError(isMetric 
                                  ? 'weapon.err_zero_dist_range_metric'.tr()
                                  : 'weapon.err_zero_dist_range_imperial'.tr());
                                return;
                              }

                              double? tw = parseValue(_model.textFieldModel4
                                  .inputTextController?.text);
                              if (tw == null) {
                                showError('weapon.err_twist_empty'.tr());
                                return;
                              }
                              if (tw < 4.0 || tw > 24.0) {
                                showError('weapon.err_twist_range'.tr());
                                return;
                              }

                              double? cV = parseValue(_model.textFieldModel5
                                  .inputTextController?.text);
                              if (cV == null || cV <= 0 || cV > 5.0) {
                                showError('weapon.err_click_val_range'.tr());
                                return;
                              }
                              if (_model.clickTypeValue == null) {
                                showError('weapon.err_click_type_empty'.tr());
                                return;
                              }

                              double? bW = parseValue(_model.textFieldModel6
                                  .inputTextController?.text);
                              if (bW == null || bW < 10 || bW > 1000) {
                                showError('weapon.err_bullet_weight_range'.tr());
                                return;
                              }

                              double? bL = parseValue(_model.textFieldModel7
                                  .inputTextController?.text);
                              if (bL == null || bL < 3 || bL > 80) {
                                showError(isMetric
                                  ? 'weapon.err_bullet_length_range_metric'.tr()
                                  : 'weapon.err_bullet_length_range_imperial'.tr());
                                return;
                              }

                              double? mV = parseValue(_model.textFieldModel8
                                  .inputTextController?.text);
                              if (mV == null) {
                                showError('weapon.err_mv_empty'.tr());
                                return;
                              }
                              if (!isMetric) mV *= 0.3048;
                              if (mV < 100 || mV > 1500) {
                                showError(isMetric
                                  ? 'weapon.err_mv_range_metric'.tr()
                                  : 'weapon.err_mv_range_imperial'.tr());
                                return;
                              }

                              double? bcV = parseValue(_model.textFieldModel9
                                  .inputTextController?.text);
                              if (bcV == null || bcV < 0.05 || bcV > 1.5) {
                                showError('weapon.err_bc_range'.tr());
                                return;
                              }

                              double? cal = parseValue(_model.textFieldModel10
                                  .inputTextController?.text);
                              if (cal == null) {
                                showError('weapon.err_caliber_empty'.tr());
                                return;
                              }
                              if (!isMetric) cal *= 25.4;
                              if (cal < 4.0 || cal > 20.0) {
                                showError(isMetric ? 'weapon.err_caliber_range_metric'.tr() : 'weapon.err_caliber_range_imperial'.tr());
                                return;
                              }

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('weapons')
                                  .add({
                                'name': name,
                                'caliber': cal.toString(),
                                'sight_height': (sH * 10.0).toString(),
                                'zero_distance': zD.toString(),
                                'twist': (tw * 25.4).toString(),
                                'click_value': cV.toString(),
                                'click_type': _model.clickTypeValue,
                                'twist_direction':
                                    _model.isRightTwist ? 'right' : 'left',
                                'bullet_weight': bW.toString(),
                                'bullet_length': bL.toString(),
                                'muzzle_velocity': mV.toString(),
                                'bc_model': _model.dropdownValue ?? 'G7',
                                'bc_value': bcV.toString(),
                                'use_multi_bc': _model.useMultiBc,
                                'calibration_points': _model.calibrationPoints,
                                'created_at': FieldValue.serverTimestamp(),
                              });
                              if (context.mounted) context.safePop();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('weapon.err_save_failed'.tr(args: [e.toString()]))));
                            } finally {
                              if (mounted) {
                                safeSetState(
                                    () => _model.isLoading = false);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 32.0,
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildCalibrationUI(BuildContext context, bool isMetric, double? Function(String?) parseVal) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'weapon.use_multi_bc'.tr(),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'weapon.multi_bc_desc'.tr(),
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                      font: GoogleFonts.inter(color: FlutterFlowTheme.of(context).secondaryText),
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: _model.useMultiBc,
              activeColor: FlutterFlowTheme.of(context).primary,
              onChanged: (val) {
                safeSetState(() {
                  _model.useMultiBc = val;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16.0),
        if (!_model.useMultiBc) ...[
          Text(
            'weapon.calibration_desc'.tr(),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.inter(color: FlutterFlowTheme.of(context).secondaryText),
            ),
          ),
          SizedBox(height: 16.0),
          ButtonWidget(
            content: 'weapon.calibrate_btn'.tr(),
            icon: Icon(Icons.calculate_rounded, color: Colors.white, size: 16.0),
            icon_present: true,
            color: FlutterFlowTheme.of(context).primary,
            onPressed: () => _showCalibrationDialog(context, isMetric, parseVal, isMultiBcPoint: false),
          ),
        ] else ...[
          Text(
            'weapon.multi_bc_points_desc'.tr(),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.inter(color: FlutterFlowTheme.of(context).secondaryText),
            ),
          ),
          SizedBox(height: 12.0),
          if (_model.calibrationPoints.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  'weapon.no_points'.tr(),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _model.calibrationPoints.length,
              separatorBuilder: (context, index) => Divider(color: FlutterFlowTheme.of(context).alternate),
              itemBuilder: (context, index) {
                final pt = _model.calibrationPoints[index];
                final dist = pt['distance'];
                final corr = pt['actual_correction'];
                final unit = pt['unit'];
                final bcVal = pt['calculated_bc'];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'weapon.point_distance'.tr(args: [dist.toStringAsFixed(0), isMetric ? 'units.m'.tr() : 'units.yd'.tr()]),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            'weapon.point_corr_bc'.tr(args: [corr.toString(), unit, bcVal.toStringAsFixed(4)]),
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(color: FlutterFlowTheme.of(context).secondaryText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline_rounded, color: FlutterFlowTheme.of(context).error),
                      onPressed: () {
                        safeSetState(() {
                          _model.calibrationPoints.removeAt(index);
                          _recalibrateAllPoints(isMetric, parseVal);
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          SizedBox(height: 16.0),
          ButtonWidget(
            content: 'weapon.add_point_btn'.tr(),
            icon: Icon(Icons.add_rounded, color: Colors.white, size: 16.0),
            icon_present: true,
            color: _model.calibrationPoints.length >= 3 
                ? FlutterFlowTheme.of(context).secondaryText 
                : FlutterFlowTheme.of(context).primary,
            disabled: _model.calibrationPoints.length >= 3,
            onPressed: _model.calibrationPoints.length >= 3
                ? null
                : () => _showCalibrationDialog(context, isMetric, parseVal, isMultiBcPoint: true),
          ),
        ],
      ],
    );
  }

  void _recalibrateAllPoints(bool isMetric, double? Function(String?) parseVal) {
    if (_model.calibrationPoints.isEmpty) return;

    final double? mV = parseVal(_model.textFieldModel8.inputTextController?.text);
    final double? bW = parseVal(_model.textFieldModel6.inputTextController?.text);
    final double? bL = parseVal(_model.textFieldModel7.inputTextController?.text);
    final double? cal = parseVal(_model.textFieldModel10.inputTextController?.text);
    final double? sH = parseVal(_model.textFieldModel2.inputTextController?.text);
    final double? zD = parseVal(_model.textFieldModel3.inputTextController?.text);
    final double? tw = parseVal(_model.textFieldModel4.inputTextController?.text);
    final double? cV = parseVal(_model.textFieldModel5.inputTextController?.text);

    if (mV == null || bW == null || bL == null || cal == null || sH == null || zD == null || tw == null || cV == null) {
      return;
    }

    final finalSH = sH * 10.0;
    final finalZD = isMetric ? zD : zD * 0.9144;
    final finalTwist = tw * 25.4;
    final finalMV = isMetric ? mV : mV * 0.3048;
    final finalCal = isMetric ? cal : cal * 25.4;

    final recalibrated = BallisticEngine.recalibrateMultiBc(
      points: _model.calibrationPoints,
      v0: finalMV,
      bcModel: _model.dropdownValue ?? 'G7',
      weightGrains: bW,
      zeroDistance: finalZD,
      windSpeed: 0.0,
      windDirectionHours: 3.0,
      temperatureC: 15.0,
      pressureHpa: 1013.25,
      humidity: 50.0,
      angleDegrees: 0.0,
      sightHeightMm: finalSH,
      clickValue: cV,
      clickType: _model.clickTypeValue ?? 'MRAD',
      caliberMm: finalCal,
      twistMm: finalTwist,
      twistDirection: _model.isRightTwist ? 'right' : 'left',
      bulletLengthMm: bL,
    );

    safeSetState(() {
      _model.calibrationPoints = recalibrated;
    });
  }

  void _showCalibrationDialog(BuildContext context, bool isMetric, double? Function(String?) parseVal, {required bool isMultiBcPoint}) {
    final double? mV = parseVal(_model.textFieldModel8.inputTextController?.text);
    final double? bW = parseVal(_model.textFieldModel6.inputTextController?.text);
    final double? bL = parseVal(_model.textFieldModel7.inputTextController?.text);
    final double? cal = parseVal(_model.textFieldModel10.inputTextController?.text);
    final double? sH = parseVal(_model.textFieldModel2.inputTextController?.text);
    final double? zD = parseVal(_model.textFieldModel3.inputTextController?.text);
    final double? tw = parseVal(_model.textFieldModel4.inputTextController?.text);
    final double? cV = parseVal(_model.textFieldModel5.inputTextController?.text);

    if (mV == null || bW == null || bL == null || cal == null || sH == null || zD == null || tw == null || cV == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('weapon.fill_params_first'.tr()),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }

    final distController = TextEditingController();
    final corrController = TextEditingController();
    String unitValue = 'MRAD';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              title: Text(
                isMultiBcPoint ? 'weapon.add_multi_bc_title'.tr() : 'weapon.calibrate_btn'.tr(),
                style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: distController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'weapon.shot_distance'.tr(args: [isMetric ? 'units.m'.tr() : 'units.yd'.tr()]),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: corrController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: 'weapon.vertical_corr'.tr(),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      DropdownButton<String>(
                        value: unitValue,
                        dropdownColor: FlutterFlowTheme.of(context).secondaryBackground,
                        onChanged: (val) {
                          if (val != null) {
                            setStateDialog(() {
                              unitValue = val;
                            });
                          }
                        },
                        items: ['MRAD', 'MOA', 'units.clicks'.tr(), 'common.cm'.tr()].map((u) {
                          return DropdownMenuItem<String>(
                            value: u,
                            child: Text(u),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('common.cancel'.tr(), style: TextStyle(color: FlutterFlowTheme.of(context).secondaryText)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onPressed: () {
                    final dVal = double.tryParse(distController.text.trim().replaceAll(',', '.'));
                    final cValText = double.tryParse(corrController.text.trim().replaceAll(',', '.'));
                    if (dVal == null || dVal <= 0 || cValText == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('weapon.validation_err'.tr())),
                      );
                      return;
                    }

                    final double targetDistMeters = isMetric ? dVal : dVal * 0.9144;
                    final double finalSH = sH * 10.0;
                    final double finalZD = isMetric ? zD : zD * 0.9144;
                    final double finalTwist = tw * 25.4;
                    final double finalMV = isMetric ? mV : mV * 0.3048;
                    final double finalCal = isMetric ? cal : cal * 25.4;

                    if (isMultiBcPoint) {
                      if (_model.calibrationPoints.any((pt) => (pt['distance'] - targetDistMeters).abs() < 0.1)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('weapon.point_exists_err'.tr())),
                        );
                        return;
                      }

                      Navigator.pop(dialogContext);

                      safeSetState(() {
                        _model.calibrationPoints.add({
                          'distance': targetDistMeters,
                          'actual_correction': cValText,
                          'unit': unitValue,
                          'calculated_bc': 0.1,
                        });
                        _recalibrateAllPoints(isMetric, parseVal);
                      });
                    } else {
                      final calBc = BallisticEngine.calibrateBc(
                        targetDistance: targetDistMeters,
                        actualCorrection: cValText,
                        correctionUnit: unitValue,
                        v0: finalMV,
                        bcModel: _model.dropdownValue ?? 'G7',
                        weightGrains: bW,
                        zeroDistance: finalZD,
                        windSpeed: 0.0,
                        windDirectionHours: 3.0,
                        temperatureC: 15.0,
                        pressureHpa: 1013.25,
                        humidity: 50.0,
                        angleDegrees: 0.0,
                        sightHeightMm: finalSH,
                        clickValue: cV,
                        clickType: _model.clickTypeValue ?? 'MRAD',
                        caliberMm: finalCal,
                        twistMm: finalTwist,
                        twistDirection: _model.isRightTwist ? 'right' : 'left',
                        bulletLengthMm: bL,
                      );

                      Navigator.pop(dialogContext);

                      safeSetState(() {
                        _model.textFieldModel9.inputTextController?.text = calBc.toStringAsFixed(4);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('weapon.calib_success'.tr(args: [calBc.toString()])),
                          backgroundColor: FlutterFlowTheme.of(context).success,
                        ),
                      );
                    }
                  },
                  child: Text('weapon.calculate'.tr(), style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
