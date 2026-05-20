import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pin_digit_model.dart';
export 'pin_digit_model.dart';

class PinDigitWidget extends StatefulWidget {
  const PinDigitWidget({
    super.key,
    String? digit,
    bool? active,
    bool? error,
  })  : this.digit = digit ?? '',
        this.active = active ?? true,
        this.error = error ?? false;

  final String digit;
  final bool active;
  final bool error;

  @override
  State<PinDigitWidget> createState() => _PinDigitWidgetState();
}

class _PinDigitWidgetState extends State<PinDigitWidget> {
  late PinDigitModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinDigitModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.error
        ? FlutterFlowTheme.of(context).error
        : widget.active
            ? FlutterFlowTheme.of(context).primary
            : FlutterFlowTheme.of(context).alternate;

    return Container(
      width: 48.0,
      height: 56.0,
      decoration: BoxDecoration(
        color: widget.error
            ? FlutterFlowTheme.of(context).error.withOpacity(0.08)
            : FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(6.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        widget.digit,
        style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.bold,
                fontStyle:
                    FlutterFlowTheme.of(context).headlineMedium.fontStyle,
              ),
              color: widget.error
                  ? FlutterFlowTheme.of(context).error
                  : FlutterFlowTheme.of(context).primaryText,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
              lineHeight: 1.1,
            ),
      ),
    );
  }
}
