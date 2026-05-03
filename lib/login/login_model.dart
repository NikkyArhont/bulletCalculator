import '/components/button_widget.dart';
import '/components/social_button_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'login_widget.dart' show LoginWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for Button.
  late ButtonModel buttonModel;
  // Model for SocialButton.
  late SocialButtonModel socialButtonModel1;
  // Model for SocialButton.
  late SocialButtonModel socialButtonModel2;
  // Model for Button.
  late ButtonModel themeButtonModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
    socialButtonModel1 = createModel(context, () => SocialButtonModel());
    socialButtonModel2 = createModel(context, () => SocialButtonModel());
    themeButtonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    buttonModel.dispose();
    socialButtonModel1.dispose();
    socialButtonModel2.dispose();
    themeButtonModel.dispose();
  }
}
