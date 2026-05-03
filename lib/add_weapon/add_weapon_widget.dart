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
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                              'Новое оружие',
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
                            title: 'ОСНОВНЫЕ ПАРАМЕТРЫ',
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
                                      label: false,
                                      helper: false,
                                      hint: 'Напр. TIKKA T3X .308',
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
                                            label: false,
                                            helper: false,
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
                                            error: false,
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
                                            label: false,
                                            helper: false,
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
                                            error: false,
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
                            title: 'СТВОЛ И ОПТИКА',
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
                                            label: false,
                                            helper: false,
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
                                            error: false,
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
                                            label: false,
                                            helper: false,
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
                                            error: false,
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 16.0)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                          GestureDetector(
                                            onTap: () => safeSetState(
                                                () => _model.isRightTwist = true),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _model.isRightTwist
                                                    ? FlutterFlowTheme.of(context).primary
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: _model.isRightTwist
                                                      ? FlutterFlowTheme.of(context).primary
                                                      : FlutterFlowTheme.of(context).alternate,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 10.0, 12.0, 10.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    if (_model.isRightTwist)
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                                                        child: Icon(
                                                          Icons.check_rounded,
                                                          color: FlutterFlowTheme.of(context).onPrimary,
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                    Text(
                                                      'Правое',
                                                      style: FlutterFlowTheme.of(context)
                                                          .labelMedium
                                                          .override(
                                                            font: GoogleFonts.spaceGrotesk(
                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                            ),
                                                            color: _model.isRightTwist
                                                                ? FlutterFlowTheme.of(context).onPrimary
                                                                : FlutterFlowTheme.of(context).secondaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                            lineHeight: 1.1,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => safeSetState(
                                                () => _model.isRightTwist = false),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: !_model.isRightTwist
                                                    ? FlutterFlowTheme.of(context).primary
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                  color: !_model.isRightTwist
                                                      ? FlutterFlowTheme.of(context).primary
                                                      : FlutterFlowTheme.of(context).alternate,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 10.0, 12.0, 10.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    if (!_model.isRightTwist)
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                                                        child: Icon(
                                                          Icons.check_rounded,
                                                          color: FlutterFlowTheme.of(context).onPrimary,
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                    Text(
                                                      'Левое',
                                                      style: FlutterFlowTheme.of(context)
                                                          .labelMedium
                                                          .override(
                                                            font: GoogleFonts.spaceGrotesk(
                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                            ),
                                                            color: !_model.isRightTwist
                                                                ? FlutterFlowTheme.of(context).onPrimary
                                                                : FlutterFlowTheme.of(context).secondaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                            lineHeight: 1.1,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
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
                            title: 'БОЕПРИПАС И БАЛЛИСТИКА',
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
                                            label: false,
                                            helper: false,
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
                                            error: false,
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
                                            label: false,
                                            helper: false,
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
                                            error: false,
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 16.0)),
                                  ),
                                  wrapWithModel(
                                    model: _model.textFieldModel8,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TextFieldWidget(
                                      label: false,
                                      helper: false,
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
                                      error: false,
                                    ),
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
                                        'БАЛЛИСТИЧЕСКИЙ КОЭФФИЦИЕНТ',
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
                                                        Colors.transparent,
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
                                                    labelText: 'МОДЕЛЬ',
                                                    labelTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .spaceGrotesk(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
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
                                                label: false,
                                                helper: false,
                                                hint: '0.243',
                                                value: '',
                                                leading_icon_present: false,
                                                trailing_icon_present: false,
                                                border: Color(0x00000000),
                                                hint_color: 'hint',
                                                variant: 'outlined',
                                                error: false,
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
                                  'ВНИМАНИЕ: Ошибка в высоте прицела на 5мм может дать критическое отклонение на дистанциях свыше 500м. Проверьте данные перед сохранением.',
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
                          content: '+ Добавить оружие',
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
                              if (uid == null || uid.isEmpty) return;
                              final name = _model.textFieldModel1
                                      .inputTextController?.text.trim() ??
                                  '';
                              if (name.isEmpty) {
                                safeSetState(
                                    () => _model.isLoading = false);
                                return;
                              }
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('weapons')
                                  .add({
                                'name': name,
                                'sight_height': _model.textFieldModel2
                                        .inputTextController?.text
                                        .trim() ??
                                    '',
                                'zero_distance': _model.textFieldModel3
                                        .inputTextController?.text
                                        .trim() ??
                                    '',
                                'twist': _model.textFieldModel4
                                        .inputTextController?.text
                                        .trim() ??
                                    '',
                                'click_value': _model.textFieldModel5
                                        .inputTextController?.text
                                        .trim() ??
                                    '',
                                'twist_direction':
                                    _model.isRightTwist ? 'right' : 'left',
                                'bullet_weight': _model.textFieldModel6
                                        .inputTextController?.text
                                        .trim() ??
                                    '',
                                'bullet_length': _model.textFieldModel7
                                        .inputTextController?.text
                                        .trim() ??
                                    '',
                                'muzzle_velocity': _model.textFieldModel8
                                        .inputTextController?.text
                                        .trim() ??
                                    '',
                                'bc_model':
                                    _model.dropdownValue ?? 'G7',
                                'bc_value': _model.textFieldModel9
                                        .inputTextController?.text
                                        .trim() ??
                                    '',
                                'created_at':
                                    FieldValue.serverTimestamp(),
                              });
                              if (context.mounted) context.safePop();
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
    );
  }
}
