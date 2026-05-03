import '/components/button_widget.dart';
import '/components/specialization_option_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'choose_spec_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
export 'choose_spec_model.dart';

class ChooseSpecWidget extends StatefulWidget {
  const ChooseSpecWidget({super.key});

  @override
  State<ChooseSpecWidget> createState() => _ChooseSpecWidgetState();
}

class _ChooseSpecWidgetState extends State<ChooseSpecWidget> {
  late ChooseSpecModel _model;
  String selectedSpec = 'Стрелок-спортсмен';

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseSpecModel());

    // Fetch initial specialization from Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((doc) {
        if (doc.exists && doc.data()?.containsKey('specialization') == true) {
          setState(() {
            selectedSpec = doc.get('specialization') as String;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Material(
        color: Colors.transparent,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: 40.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(9999.0),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Text(
                    'Выберите специализацию',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.spaceGrotesk(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                          lineHeight: 1.2,
                        ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => setState(() => selectedSpec = 'Стрелок-спортсмен'),
                        child: wrapWithModel(
                          model: _model.specializationOptionModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: SpecializationOptionWidget(
                            label: 'Стрелок-спортсмен',
                            selected: selectedSpec == 'Стрелок-спортсмен',
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => setState(() => selectedSpec = 'Охотник'),
                        child: wrapWithModel(
                          model: _model.specializationOptionModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: SpecializationOptionWidget(
                            label: 'Охотник',
                            selected: selectedSpec == 'Охотник',
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => setState(() => selectedSpec = 'Тактический стрелок'),
                        child: wrapWithModel(
                          model: _model.specializationOptionModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: SpecializationOptionWidget(
                            label: 'Тактический стрелок',
                            selected: selectedSpec == 'Тактический стрелок',
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => setState(() => selectedSpec = 'Снайпер'),
                        child: wrapWithModel(
                          model: _model.specializationOptionModel4,
                          updateCallback: () => safeSetState(() {}),
                          child: SpecializationOptionWidget(
                            label: 'Снайпер',
                            selected: selectedSpec == 'Снайпер',
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => setState(() => selectedSpec = 'Любитель'),
                        child: wrapWithModel(
                          model: _model.specializationOptionModel5,
                          updateCallback: () => safeSetState(() {}),
                          child: SpecializationOptionWidget(
                            label: 'Любитель',
                            selected: selectedSpec == 'Любитель',
                          ),
                        ),
                      ),
                        ].divide(SizedBox(height: 0.0)),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                      onPressed: () {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .set({
                            'specialization': selectedSpec,
                          }, SetOptions(merge: true)).catchError((e) {
                            debugPrint('Firestore Error: $e');
                          });
                        }
                        Navigator.pop(context, selectedSpec);
                      },
                    text: 'Готово',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 56.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleMedium
                          .override(
                            font: GoogleFonts.spaceGrotesk(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontWeight,
                            ),
                            color: FlutterFlowTheme.of(context).info,
                            letterSpacing: 0.0,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ].divide(SizedBox(height: 24.0)),
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
