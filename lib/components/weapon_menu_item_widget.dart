import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'weapon_menu_item_model.dart';
export 'weapon_menu_item_model.dart';

class WeaponMenuItemWidget extends StatefulWidget {
  const WeaponMenuItemWidget({
    super.key,
    String? caliber,
    String? name,
    bool? selected,
  })  : this.caliber = caliber ?? '6.5 Creedmoor',
        this.name = name ?? 'Accuracy International AT-X',
        this.selected = selected ?? true;

  final String caliber;
  final String name;
  final bool selected;

  @override
  State<WeaponMenuItemWidget> createState() => _WeaponMenuItemWidgetState();
}

class _WeaponMenuItemWidgetState extends State<WeaponMenuItemWidget> {
  late WeaponMenuItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeaponMenuItemModel());
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
        color: widget!.selected
            ? FlutterFlowTheme.of(context).primary10
            : Colors.transparent,
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
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
                    valueOrDefault<String>(
                      widget!.name,
                      'Accuracy International AT-X',
                    ),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget!.caliber,
                      '6.5 Creedmoor',
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
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                          lineHeight: 1.3,
                        ),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
              if (valueOrDefault<bool>(
                widget!.selected,
                true,
              ))
                Icon(
                  Icons.check_circle_rounded,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 20.0,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
