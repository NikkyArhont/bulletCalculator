import '/auth/firebase_auth/auth_util.dart';
import '/components/history_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history_model.dart';
export 'history_model.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  static String routeName = 'history';
  static String routePath = '/history';

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  late HistoryModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          'История расчетов',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                font: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.bold,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 22.0,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('shootResults')
              .where('userId', isEqualTo: currentUserUid)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text('Ошибка загрузки: ${snapshot.error}'),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              );
            }
            final docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history_rounded,
                      size: 64.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'История пока пуста',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.spaceGrotesk(),
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(24.0),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                final timestamp = data['timestamp'] as Timestamp?;
                final dateStr = timestamp != null
                    ? dateTimeFormat('d MMM, HH:mm', timestamp.toDate())
                    : 'Недавно';

                return InkWell(
                  onTap: () async {
                    context.pushNamed(
                      'shootResult',
                      queryParameters: {
                        'resultId': docs[index].id,
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
                    resultId: docs[index].id,
                    isHit: data['isHit'] == true,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
