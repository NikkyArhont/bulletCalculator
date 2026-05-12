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
  })  : this.digit = digit ?? '',
        this.active = active ?? true;

  final String digit;
  final bool active;

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
    return Container(
      width: 48.0,
      height: 56.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(6.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: widget!.active
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).alternate,
          width: widget!.active ? 2.0 : 2.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        widget!.digit,
        style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.bold,
                fontStyle:
                    FlutterFlowTheme.of(context).headlineMedium.fontStyle,
              ),
              color: FlutterFlowTheme.of(context).primaryText,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
              lineHeight: 1.1,
            ),
      ),
    );
  }
}
