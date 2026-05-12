import '/components/button_widget.dart';
import '/components/history_card_widget.dart';
import '/components/profile_stat_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/components/logout_widget.dart';
import 'profile_model.dart';
import '/auth/firebase_auth/auth_util.dart';
export 'profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  static String routeName = 'profile';
  static String routePath = '/profile';

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9999.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(46.0),
                                      child: currentUserPhoto.isNotEmpty
                                          ? CachedNetworkImage(
                                              fadeInDuration:
                                                  Duration(milliseconds: 0),
                                              fadeOutDuration:
                                                  Duration(milliseconds: 0),
                                              imageUrl: currentUserPhoto,
                                              width: 92.0,
                                              height: 92.0,
                                              fit: BoxFit.cover,
                                              alignment: Alignment(0.0, 0.0),
                                            )
                                          : Image.asset(
                                              'assets/images/logo.png',
                                              width: 92.0,
                                              height: 92.0,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 1.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    context.pushNamed('shootPage');
                                  },
                                  child: Container(
                                    width: 32.0,
                                    height: 32.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).primary,
                                      borderRadius:
                                          BorderRadius.circular(9999.0),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 3.0,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.bar_chart_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(1.0, 1.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    context.pushNamed('profileSettings');
                                  },
                                  child: Container(
                                    width: 32.0,
                                    height: 32.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).primary,
                                      borderRadius:
                                          BorderRadius.circular(9999.0),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 3.0,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.edit_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  currentUserDisplayName,
                                  currentPhoneNumber,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      lineHeight: 1.1,
                                    ),
                              ),
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUserUid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  final specialization = (snapshot.data?.data()
                                              as Map<String, dynamic>?)?[
                                          'specialization'] as String? ??
                                      'Пользователь';
                                  return Text(
                                    specialization,
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
                                              .secondaryText,
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
                                  );
                                },
                              ),
                            ].divide(SizedBox(height: 4.0)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(24.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 24.0, 16.0, 24.0),
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('shootResults')
                                            .where('userId', isEqualTo: currentUserUid)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          final count = snapshot.data?.docs.length ?? 0;
                                          return InkWell(
                                            onTap: () async {
                                              context.pushNamed('history');
                                            },
                                            child: wrapWithModel(
                                              model: _model.profileStatModel1,
                                              updateCallback: () => safeSetState(() {}),
                                              child: ProfileStatWidget(
                                                label: 'Расчетов',
                                                value: count.toString(),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    Container(
                                      width: 1.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        shape: BoxShape.rectangle,
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
                                          return InkWell(
                                            onTap: () async {
                                              context.pushNamed('weaponList');
                                            },
                                            child: wrapWithModel(
                                              model: _model.profileStatModel2,
                                              updateCallback: () => safeSetState(() {}),
                                              child: ProfileStatWidget(
                                                label: 'Винтовок',
                                                value: count.toString(),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    Container(
                                      width: 1.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        shape: BoxShape.rectangle,
                                      ),
                                    ),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('shootResults')
                                            .where('userId', isEqualTo: currentUserUid)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          final total = snapshot.data?.docs.length ?? 0;
                                          final hits = snapshot.data?.docs.where((doc) => (doc.data() as Map<String, dynamic>)['isHit'] == true).length ?? 0;
                                          final accuracy = total > 0 ? (hits / total * 100).toInt() : 0;
                                          
                                          return wrapWithModel(
                                            model: _model.profileStatModel3,
                                            updateCallback: () => safeSetState(() {}),
                                            child: ProfileStatWidget(
                                              label: 'Точность',
                                              value: '$accuracy%',
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 24.0)),
                      ),
                      wrapWithModel(
                        model: _model.buttonModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: ButtonWidget(
                          content: 'Мои устройства',
                          icon_present: false,
                          icon_end_present: false,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          variant: 'primary',
                          size: 'medium',
                          full_width: false,
                          loading: _model.isLoadingDevices,
                          disabled: _model.isLoadingDevices,
                          onPressed: () async {
                            safeSetState(() => _model.isLoadingDevices = true);
                            await context.pushNamed('myDevices');
                            safeSetState(() => _model.isLoadingDevices = false);
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(4.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Icon(
                                    Icons.bluetooth_connected_rounded,
                                    color: FlutterFlowTheme.of(context).success,
                                    size: 20.0,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kestrel 5700',
                                        maxLines: 1,
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
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Подключено • 0.8 м/с ЮЗ',
                                        maxLines: 1,
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
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'История расчетов',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                      lineHeight: 1.2,
                                    ),
                              ),
                              InkWell(
                                onTap: () async {
                                  context.pushNamed('history');
                                },
                                child: Text(
                                  'См. все',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.spaceGrotesk(
                                          fontWeight: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).primary,
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
                              ),
                            ],
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('shootResults')
                                .where('userId', isEqualTo: currentUserUid)
                                .orderBy('timestamp', descending: true)
                                .limit(4)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                print('FIRESTORE ERROR: ${snapshot.error}');
                                return Center(
                                  child: Text('Ошибка загрузки истории: ${snapshot.error}'),
                                );
                              }
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: CircularProgressIndicator(
                                      color: FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                );
                              }
                              final docs = snapshot.data!.docs;
                              if (docs.isEmpty) {
                                return Center(
                                  child: Text('История пока пуста'),
                                );
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: docs.map((doc) {
                                  final data = doc.data() as Map<String, dynamic>;
                                  final timestamp = data['timestamp'] as Timestamp?;
                                  final dateStr = timestamp != null
                                      ? dateTimeFormat('d MMM, HH:mm', timestamp.toDate())
                                      : 'Недавно';

                                  return InkWell(
                                    onTap: () async {
                                      context.pushNamed(
                                        'shootResult',
                                        queryParameters: {
                                          'resultId': doc.id,
                                          'distance': data['distance']?.toString(),
                                          'windSpeed': data['windSpeed']?.toString(),
                                          'windDirection': data['windDirection']?.toString(),
                                          'muzzleVelocity': data['muzzleVelocity']?.toString(),
                                          'bcValue': data['bcValue']?.toString(),
                                          'bulletWeight': data['bulletWeight']?.toString(),
                                          'temperature': data['temperature']?.toString(),
                                          'pressure': data['pressure']?.toString(),
                                          'angle': data['angle']?.toString(),
                                          'sightHeight': data['sightHeight']?.toString(),
                                          'clickValue': data['clickValue']?.toString(),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: HistoryCardWidget(
                                      date: dateStr,
                                      distance: data['distance']?.toString() ?? '0',
                                      elevation: data['vertical_correction']?.toString() ?? '0.0',
                                      weapon: data['weaponName'] ?? 'Оружие',
                                      wind: data['horizontal_correction']?.toString() ?? '0.0',
                                      resultId: doc.id,
                                      isHit: data['isHit'] == true,
                                    ),
                                  );
                                }).toList().divide(SizedBox(height: 8.0)),
                              );
                            },
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          wrapWithModel(
                            model: _model.buttonModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: ButtonWidget(
                              content: 'Выйти из аккаунта',
                              icon: Icon(
                                Icons.logout_rounded,
                                color: FlutterFlowTheme.of(context).error,
                                size: 16.0,
                              ),
                              icon_present: true,
                              icon_end_present: false,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              variant: 'outline',
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
                                      alignment: AlignmentDirectional(0, 0),
                                      child: LogoutWidget(),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                      Container(
                        height: 24.0,
                      ),
                    ].divide(SizedBox(height: 32.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
