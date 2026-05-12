import '/components/button_widget.dart';
import '/components/tactical_weapon_card_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'weapon_list_model.dart';
export 'weapon_list_model.dart';

class WeaponListWidget extends StatefulWidget {
  const WeaponListWidget({super.key});

  static String routeName = 'weaponList';
  static String routePath = '/weaponList';

  @override
  State<WeaponListWidget> createState() => _WeaponListWidgetState();
}

class _WeaponListWidgetState extends State<WeaponListWidget> {
  late WeaponListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeaponListModel());
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
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 60.0, 24.0, 20.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'МОЙ АРСЕНАЛ',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      lineHeight: 1.1,
                                    ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUserUid)
                                    .collection('weapons')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  final count = snapshot.data?.docs.length ?? 0;
                                  return Text(
                                    '$count АКТИВНЫХ СИСТЕМ',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .fontWeight,
                                            fontStyle: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .fontStyle,
                                          lineHeight: 1.1,
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Icon(
                            Icons.military_tech_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 32.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 2.0,
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
              child: Container(
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(4.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 8.0, 16.0, 8.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20.0,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: wrapWithModel(
                                            model: _model.textFieldModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: TextFieldWidget(
                                              label: null,
                                              helper: null,
                                              hint: 'ПОИСК ПО ИНВЕНТАРЮ...',
                                              value: '',
                                              leading_icon_present: false,
                                              trailing_icon_present: false,
                                              border: Color(0x00000000),
                                              hint_color: 'hint',
                                              variant: 'ghost',
                                              error: false,
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUserUid)
                                    .collection('weapons')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  final docs = snapshot.data!.docs;
                                  final searchQuery = _model.textFieldModel.inputTextController?.text.toLowerCase() ?? '';
                                  final filteredDocs = docs.where((doc) {
                                    final data = doc.data() as Map<String, dynamic>;
                                    final name = (data['name'] ?? '').toString().toLowerCase();
                                    return name.contains(searchQuery);
                                  }).toList();

                                  if (filteredDocs.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(24.0),
                                        child: Text(searchQuery.isEmpty ? 'Арсенал пуст' : 'Ничего не найдено'),
                                      ),
                                    );
                                  }
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: filteredDocs.map((doc) {
                                      final data = doc.data() as Map<String, dynamic>;
                                      return TacticalWeaponCardWidget(
                                        bc_type: data['bc_model'] ?? 'G7',
                                        bc_value: data['bc_value'] ?? '0.315',
                                        caliber: data['caliber'] ?? 'КАЛИБР',
                                        name: data['name'] ?? 'ОРУЖИЕ',
                                        twist: data['twist'] ?? '1:8\"',
                                        twist_dir: data['twist_direction'] == 'left' ? 'ЛЕВО' : 'ПРАВО',
                                        bullet_length: data['bullet_length']?.toString() ?? '30.0',
                                        v0: data['muzzle_velocity'] ?? '820',
                                        weight: data['bullet_weight'] ?? '9.1',
                                        sight_height: data['sight_height'] ?? '50',
                                        zero_distance: data['zero_distance'] ?? '100',
                                        click_value: data['click_value'] ?? '0.1',
                                        click_type: data['click_type'] ?? 'MRAD',
                                        onSelect: () async {
                                          context.goNamed(
                                            'shootPage',
                                            queryParameters: {
                                              'selectedWeaponId': doc.id,
                                              'selectedWeaponName':
                                                  data['name'] ?? 'Оружие',
                                              'selectedWeaponCaliber':
                                                  data['caliber'] ?? '',
                                              'muzzleVelocity':
                                                  data['muzzle_velocity']
                                                      ?.toString(),
                                              'bcValue': data['bc_value']
                                                  ?.toString(),
                                            }.withoutNulls,
                                          );
                                        },
                                        onEdit: () async {
                                          context.pushNamed(
                                            'editWeapon',
                                            extra: {
                                              'weaponRef': doc.reference,
                                              'weaponData': data,
                                            },
                                          );
                                        },
                                      );
                                    }).toList().divide(SizedBox(height: 16.0)),
                                  );
                                },
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: Container(
                                    child: Container(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.info_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary40,
                                            size: 16.0,
                                          ),
                                          Text(
                                            'ПРОВЕРЯЙТЕ ДАННЫЕ ПЕРЕД СТРЕЛЬБОЙ',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  font:
                                                      GoogleFonts.spaceGrotesk(
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
                                        ].divide(SizedBox(width: 16.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    height: 2.0,
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
                          content: 'ДОБАВИТЬ НОВОЕ ОРУЖИЕ',
                          icon: Icon(
                            Icons.add_rounded,
                            color: FlutterFlowTheme.of(context).onPrimary,
                            size: 16.0,
                          ),
                          icon_present: true,
                          icon_end_present: false,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          variant: 'primary',
                          size: 'large',
                          full_width: true,
                          loading: false,
                          disabled: false,
                          onPressed: () async {
                            context.pushNamed('addWeapon');
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
      ),
    );
  }
}
