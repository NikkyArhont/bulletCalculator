import '/components/button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tactical_weapon_card_model.dart';
import 'package:easy_localization/easy_localization.dart';
import '/flutter_flow/units_util.dart';
export 'tactical_weapon_card_model.dart';

class TacticalWeaponCardWidget extends StatefulWidget {
  const TacticalWeaponCardWidget({
    super.key,
    String? bc_type,
    String? bc_value,
    String? caliber,
    String? name,
    String? twist,
    String? v0,
    String? weight,
    String? sight_height,
    String? zero_distance,
    String? click_value,
    String? click_type,
    String? twist_dir,
    String? bullet_length,
    this.onSelect,
    this.onEdit,
  })  : this.bc_type = bc_type ?? 'G7',
        this.bc_value = bc_value ?? '0.315',
        this.caliber = caliber ?? '6.5 CREEDMOOR',
        this.name = name ?? 'ACCURACY INTERNATIONAL AT-X',
        this.twist = twist ?? '203.2',
        this.v0 = v0 ?? '820',
        this.weight = weight ?? '9.1',
        this.sight_height = sight_height ?? '50.0',
        this.zero_distance = zero_distance ?? '100',
        this.click_value = click_value ?? '0.1',
        this.click_type = click_type ?? 'MRAD',
        this.twist_dir = twist_dir ?? 'R',
        this.bullet_length = bullet_length ?? '30.0';

  final String bc_type;
  final String bc_value;
  final String caliber;
  final String name;
  final String twist;
  final String v0;
  final String weight;
  final String sight_height;
  final String zero_distance;
  final String click_value;
  final String click_type;
  final String twist_dir;
  final String bullet_length;
  final Future Function()? onSelect;
  final Future Function()? onEdit;

  @override
  State<TacticalWeaponCardWidget> createState() =>
      _TacticalWeaponCardWidgetState();
}

class _TacticalWeaponCardWidgetState extends State<TacticalWeaponCardWidget> {
  late TacticalWeaponCardModel _model;
  bool _isSelecting = false;

  String _formatTwist(String raw) {
    final val = double.tryParse(raw.replaceAll(RegExp(r'[^\d.]'), ''));
    if (val == null) return raw;
    final inches = val / 25.4;
    return '${inches.toStringAsFixed(1)} ${'common.inch'.tr()}';
  }

  String _formatSightHeight(String raw) {
    final val = double.tryParse(raw);
    if (val == null) return raw;
    final cm = val / 10.0;
    return '${cm.toStringAsFixed(1)} ${'common.cm'.tr()}';
  }

  Widget _buildGridItem(BuildContext context, String label, String value) {
    if (label.isEmpty && value.isEmpty) {
      return Expanded(flex: 1, child: Container());
    }
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FlutterFlowTheme.of(context).labelSmall.override(
                  font: GoogleFonts.spaceGrotesk(
                    fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  lineHeight: 1.1,
                  fontSize: 10,
                ),
          ),
          Text(
            valueOrDefault<String>(value, '-'),
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                  ),
                  color: FlutterFlowTheme.of(context).primary,
                  letterSpacing: 0.0,
                  lineHeight: 1.3,
                ),
          ),
        ].divide(SizedBox(height: 4.0)),
      ),
    );
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TacticalWeaponCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(4.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                widget!.name,
                                'ACCURACY INTERNATIONAL AT-X',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.2,
                                  ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                widget!.caliber,
                                '6.5 CREEDMOOR',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.spaceGrotesk(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color:
                                        FlutterFlowTheme.of(context).primary80,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                    lineHeight: 1.1,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.precision_manufacturing_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 28.0,
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).background40,
                      borderRadius: BorderRadius.circular(2.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Row 1: Twist, Dir, V0, Weight
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                _buildGridItem(context, 'common.twist'.tr(), _formatTwist(widget!.twist)),
                                _buildGridItem(context, 'common.dir'.tr(), widget!.twist_dir == 'left' ? 'weapon.left'.tr() : 'weapon.right'.tr()),
                                _buildGridItem(context, 'common.v0'.tr(), widget!.v0),
                                _buildGridItem(context, 'common.weight'.tr(), widget!.weight),
                              ],
                            ),
                            // Row 2: Length, BC Model, BC Value, Sight Height
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                _buildGridItem(context, 'common.length'.tr(), widget!.bullet_length),
                                _buildGridItem(context, 'common.bc_model'.tr(), widget!.bc_type),
                                _buildGridItem(context, 'common.bc_val'.tr(), widget!.bc_value),
                                _buildGridItem(context, 'common.sight'.tr(), _formatSightHeight(widget!.sight_height)),
                              ],
                            ),
                            // Row 3: Zero Dist, Click, Click Type, Empty
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                _buildGridItem(context, 'common.zero_distance'.tr(args: [UnitsManager.instance.distanceLabel.toUpperCase()]), widget!.zero_distance),
                                _buildGridItem(context, 'common.click'.tr(), widget!.click_value),
                                _buildGridItem(context, 'common.click_type'.tr(), widget!.click_type),
                                _buildGridItem(context, '', ''),
                              ],
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: wrapWithModel(
                          model: _model.buttonModel,
                          updateCallback: () => safeSetState(() {}),
                          child: ButtonWidget(
                            content: 'common.select_weapon_btn'.tr(),
                            icon_present: false,
                            icon_end_present: false,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            variant: 'primary',
                            size: 'small',
                            full_width: true,
                            loading: _isSelecting,
                            disabled: _isSelecting,
                            onPressed: () async {
                              if (widget.onSelect != null) {
                                safeSetState(() => _isSelecting = true);
                                try {
                                  await widget.onSelect!();
                                } finally {
                                  if (mounted) {
                                    safeSetState(() => _isSelecting = false);
                                  }
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 4.0,
                        buttonSize: 40.0,
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        icon: Icon(
                          Icons.settings_suggest_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                        onPressed: () async {
                          if (widget.onEdit != null) {
                            await widget.onEdit!();
                          }
                        },
                      ),
                    ].divide(SizedBox(width: 16.0)),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
