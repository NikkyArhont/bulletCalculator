import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'data_input_field_model.dart';
export 'data_input_field_model.dart';

class DataInputFieldWidget extends StatefulWidget {
  const DataInputFieldWidget({
    super.key,
    String? hint,
    this.icon,
    String? label,
    String? unit,
    String? value,
  })  : this.hint = hint ?? '0',
        this.label = label ?? 'Угол',
        this.unit = unit ?? '°',
        this.value = value ?? '3';

  final String hint;
  final Widget? icon;
  final String label;
  final String unit;
  final String value;

  @override
  State<DataInputFieldWidget> createState() => _DataInputFieldWidgetState();
}

class _DataInputFieldWidgetState extends State<DataInputFieldWidget> {
  late DataInputFieldModel _model;
  FocusNode? _focusNode;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataInputFieldModel());
    _focusNode = FocusNode();
    _focusNode!.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    _focusNode?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueOrDefault<String>(
            widget!.label,
            'Угол',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.spaceGrotesk(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.1,
              ),
        ),
        Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(4.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: _focusNode?.hasFocus ?? false
                  ? FlutterFlowTheme.of(context).tertiary
                  : FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 16.0),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget!.icon!,
                  Expanded(
                    flex: 1,
                    child: wrapWithModel(
                      model: _model.textFieldModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TextFieldWidget(
                        label: null,
                        helper: null,
                        hint: valueOrDefault<String>(
                          widget!.hint,
                          '0',
                        ),
                        value: valueOrDefault<String>(
                          widget!.value,
                          '3',
                        ),
                        leading_icon_present: false,
                        trailing_icon_present: false,
                        border: Color(0x00000000),
                        hint_color: 'hint',
                        variant: 'ghost',
                        error: false,
                        focusNode: _focusNode,
                      ),
                    ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget!.unit,
                      '°',
                    ),
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).accent3,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                          lineHeight: 1.3,
                        ),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
          ),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
