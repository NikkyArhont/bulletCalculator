import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'specialization_option_model.dart';
import 'package:easy_localization/easy_localization.dart';
export 'specialization_option_model.dart';

class SpecializationOptionWidget extends StatefulWidget {
  const SpecializationOptionWidget({
    super.key,
    String? label,
    bool? selected,
  })  : this.label = label ?? 'Стрелок-спортсмен',
        this.selected = selected ?? true;

  final String label;
  final bool selected;

  @override
  State<SpecializationOptionWidget> createState() =>
      _SpecializationOptionWidgetState();
}

class _SpecializationOptionWidgetState
    extends State<SpecializationOptionWidget> {
  late SpecializationOptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpecializationOptionModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: widget!.selected
                ? FlutterFlowTheme.of(context).primary10
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: widget!.selected
                  ? FlutterFlowTheme.of(context).primary
                  : FlutterFlowTheme.of(context).alternate,
              width: widget!.selected ? 1.0 : 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.label,
                      'spec.sport'.tr(),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: widget!.selected
                              ? FlutterFlowTheme.of(context).primaryText
                              : FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                  if (valueOrDefault<bool>(
                    widget!.selected,
                    true,
                  ))
                    Container(
                      width: 20.0,
                      height: 20.0,
                      child: Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        children: [
                          if (widget!.selected ? true : false)
                            Icon(
                              Icons.check_circle_rounded,
                              color: widget!.selected
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).accent3,
                              size: 20.0,
                            ),
                          if (widget!.selected ? false : true)
                            Icon(
                              Icons.radio_button_unchecked_rounded,
                              color: widget!.selected
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).accent3,
                              size: 20.0,
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
