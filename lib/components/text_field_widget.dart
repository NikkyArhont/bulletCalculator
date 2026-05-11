import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'text_field_model.dart';
export 'text_field_model.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    String? label,
    String? helper,
    String? hint,
    String? value,
    this.leading_icon,
    bool? leading_icon_present,
    this.trailing_icon,
    bool? trailing_icon_present,
    Color? border,
    String? hint_color,
    String? variant,
    bool? error,
    this.height,
    this.inputFormatters,
    this.keyboardType,
    this.focusNode,
  })  : this.label = label,
        this.helper = helper,
        this.hint = hint ?? '900 000-00-00',
        this.value = value ?? '',
        this.leading_icon_present = leading_icon_present ?? true,
        this.trailing_icon_present = trailing_icon_present ?? false,
        this.border = border ?? const Color(0x00000000),
        this.hint_color = hint_color ?? 'hint',
        this.variant = variant ?? 'outlined',
        this.error = error ?? false;

  final String? label;
  final String? helper;
  final String hint;
  final String value;
  final Widget? leading_icon;
  final bool leading_icon_present;
  final Widget? trailing_icon;
  final bool trailing_icon_present;
  final Color border;
  final String hint_color;
  final String variant;
  final bool error;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TextFieldModel());

    _model.inputTextController ??= TextEditingController(text: widget!.value);
    _model.inputFocusNode ??= widget!.focusNode ?? FocusNode();
    _model.inputFocusNode!.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget!.label != null)
            Text(
              widget!.label!,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    font: GoogleFonts.spaceGrotesk(
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                    color: widget!.error
                        ? FlutterFlowTheme.of(context).error
                        : FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    lineHeight: 1.1,
                  ),
            ),
          Container(
            height: widget!.height ?? 40.0,
            decoration: BoxDecoration(
              color: () {
                if (widget!.variant == 'filled') {
                  return FlutterFlowTheme.of(context).secondaryBackground;
                } else if (widget!.variant == 'ghost') {
                  return Colors.transparent;
                } else {
                  return Colors.transparent;
                }
              }(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(valueOrDefault<double>(
                  () {
                    if (widget!.variant == 'filled') {
                      return 2.0;
                    } else if (widget!.variant == 'ghost') {
                      return 2.0;
                    } else {
                      return 2.0;
                    }
                  }(),
                  0.0,
                )),
                topRight: Radius.circular(valueOrDefault<double>(
                  () {
                    if (widget!.variant == 'filled') {
                      return 2.0;
                    } else if (widget!.variant == 'ghost') {
                      return 2.0;
                    } else {
                      return 2.0;
                    }
                  }(),
                  0.0,
                )),
                bottomLeft: Radius.circular(valueOrDefault<double>(
                  () {
                    if (widget!.variant == 'filled') {
                      return 2.0;
                    } else if (widget!.variant == 'ghost') {
                      return 2.0;
                    } else {
                      return 2.0;
                    }
                  }(),
                  0.0,
                )),
                bottomRight: Radius.circular(valueOrDefault<double>(
                  () {
                    if (widget!.variant == 'filled') {
                      return 2.0;
                    } else if (widget!.variant == 'ghost') {
                      return 2.0;
                    } else {
                      return 2.0;
                    }
                  }(),
                  0.0,
                )),
              ),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: () {
                  if (widget!.error) {
                    return FlutterFlowTheme.of(context).error;
                  } else if (_model.inputFocusNode?.hasFocus ?? false) {
                    return FlutterFlowTheme.of(context).tertiary;
                  } else if (widget!.variant == 'filled') {
                    return Colors.transparent;
                  } else if (widget!.variant == 'ghost') {
                    return Colors.transparent;
                  } else {
                    return FlutterFlowTheme.of(context).alternate;
                  }
                }(),
                width: () {
                  if (widget!.error) {
                    return 1.0;
                  } else if (widget!.variant == 'filled') {
                    return 1.0;
                  } else if (widget!.variant == 'ghost') {
                    return 0.0;
                  } else {
                    return 1.0;
                  }
                }(),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  8.0,
                  0.0,
                  8.0,
                  0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (valueOrDefault<bool>(
                    widget!.leading_icon_present,
                    true,
                  ))
                    widget!.leading_icon!,
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _model.inputTextController,
                      focusNode: _model.inputFocusNode,
                      obscureText: false,
                      keyboardType: widget!.keyboardType,
                      inputFormatters: widget!.inputFormatters,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: valueOrDefault<String>(
                          widget!.hint,
                          '900 000-00-00',
                        ),
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: () {
                                if (widget!.variant == 'filled') {
                                  return FlutterFlowTheme.of(context).accent3;
                                } else if (widget!.variant == 'ghost') {
                                  return FlutterFlowTheme.of(context).accent3;
                                } else {
                                  return FlutterFlowTheme.of(context).accent3;
                                }
                              }(),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                              lineHeight: 1.0,
                            ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        isCollapsed: true,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: () {
                              if (widget!.variant == 'filled') {
                                return FlutterFlowTheme.of(context).primaryText;
                              } else if (widget!.variant == 'ghost') {
                                return FlutterFlowTheme.of(context).primaryText;
                              } else {
                                return FlutterFlowTheme.of(context).primaryText;
                              }
                            }(),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                            lineHeight: 1.0,
                          ),
                      onChanged: (_) => setState(() {}),
                      validator: _model.inputTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  if (valueOrDefault<bool>(
                    widget!.trailing_icon_present,
                    false,
                  ))
                    widget!.trailing_icon!,
                ],
              ),
            ),
          ),
          if (widget!.helper != null)
            Text(
              widget!.helper!,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodySmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodySmall.fontStyle,
                    ),
                    color: widget!.error
                        ? FlutterFlowTheme.of(context).error
                        : FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodySmall.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                    lineHeight: 1.3,
                  ),
            ),
        ].divide(SizedBox(height: 6.0)),
      ),
    );
  }
}
