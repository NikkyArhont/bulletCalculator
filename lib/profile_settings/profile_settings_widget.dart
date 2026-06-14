import '/components/button_widget.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_settings_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '/flutter_flow/units_util.dart';
import '/components/choose_spec_widget.dart';
import '/components/delete_account_widget.dart';
import '/components/logout_widget.dart';
import '/main.dart';
import 'package:easy_localization/easy_localization.dart';
export 'profile_settings_model.dart';

class ProfileSettingsWidget extends StatefulWidget {
  const ProfileSettingsWidget({super.key});

  static String routeName = 'profileSettings';
  static String routePath = '/profileSettings';

  @override
  State<ProfileSettingsWidget> createState() => _ProfileSettingsWidgetState();
}

class _ProfileSettingsWidgetState extends State<ProfileSettingsWidget> {
  late ProfileSettingsModel _model;
  bool isUploadingPhoto = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileSettingsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              context.safePop();
                            },
                          ),
                          Text(
                            'profile.edit_profile'.tr(),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.spaceGrotesk(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                  lineHeight: 1.2,
                                ),
                          ),
                          wrapWithModel(
                            model: _model.buttonModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: ButtonWidget(
                              content: 'profile.save'.tr(),
                              icon_present: false,
                              icon_end_present: false,
                              color: FlutterFlowTheme.of(context).tertiary,
                              variant: 'ghost',
                              size: 'small',
                              full_width: false,
                              loading: _model.isLoading,
                              disabled: _model.isLoading,
                              onPressed: () async {
                                final name = _model
                                    .textFieldModel1.inputTextController.text;
                                final surname = _model
                                    .textFieldModel2.inputTextController.text;
                                final combinedName = '$name $surname'.trim();

                                safeSetState(() {
                                  _model.isLoading = true;
                                });

                                try {
                                  try {
                                    await FirebaseAuth.instance.currentUser
                                        ?.updateDisplayName(combinedName);
                                  } catch (_) {}

                                  // Save to Firestore (always, independently of Auth update)
                                  final user = FirebaseAuth.instance.currentUser;
                                  if (user != null) {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .set({
                                      'display_name': combinedName,
                                      'name': name,
                                      'surname': surname,
                                      'distance_unit': _model.distanceUnit,
                                      'temp_unit': _model.temperatureUnit,
                                      'pressure_unit': _model.pressureUnit,
                                    }, SetOptions(merge: true));
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('profile.updated'.tr()),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).success,
                                    ),
                                  );
                                  context.safePop();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('profile.update_error'.tr(args: [e.toString()])),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).error,
                                    ),
                                  );
                                } finally {
                                  safeSetState(() {
                                    _model.isLoading = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                primary: false,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUserUid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    final userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};
                    final specialization = userData['specialization'] as String? ?? 'profile.user'.tr();
                    final distUnit = userData['distance_unit'] as String? ?? 'm';
                    final tUnit = userData['temp_unit'] as String? ?? 'c';
                    final pUnit = userData['pressure_unit'] as String? ?? 'mm';

                    if (!_model.isInitialized && snapshot.hasData) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!_model.isInitialized) {
                          _model.distanceUnit = distUnit;
                          _model.temperatureUnit = tUnit;
                          _model.pressureUnit = pUnit;

                          // Pre-fill name/surname from Firestore if available
                          final fsName = userData['name'] as String? ?? '';
                          final fsSurname = userData['surname'] as String? ?? '';
                          if (fsName.isNotEmpty) {
                            _model.textFieldModel1.inputTextController?.text = fsName;
                          }
                          if (fsSurname.isNotEmpty) {
                            _model.textFieldModel2.inputTextController?.text = fsSurname;
                          }

                          _model.isInitialized = true;
                          safeSetState(() {});
                        }
                      });
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  children: [
                                    Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: isUploadingPhoto
                                          ? Padding(
                                              padding: EdgeInsets.all(32.0),
                                              child: CircularProgressIndicator(
                                                color: FlutterFlowTheme.of(context).primary,
                                              ),
                                            )
                                          : (currentUserPhoto.isNotEmpty
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(50.0),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(milliseconds: 0),
                                                    fadeOutDuration: Duration(milliseconds: 0),
                                                    imageUrl: currentUserPhoto,
                                                    width: 100.0,
                                                    height: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Text(
                                                  'АП',
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.spaceGrotesk(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(context)
                                                                .primary,
                                                        fontSize: 38.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(context)
                                                                .labelMedium
                                                                .fontStyle,
                                                        lineHeight: 1.1,
                                                      ),
                                                  overflow: TextOverflow.clip,
                                                )),
                                    ),
                                  ],
                                ),
                                wrapWithModel(
                                  model: _model.buttonModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ButtonWidget(
                                    content: 'profile.change_photo'.tr(),
                                    icon_present: false,
                                    icon_end_present: false,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    variant: 'ghost',
                                    size: 'small',
                                    full_width: false,
                                    loading: isUploadingPhoto,
                                    disabled: isUploadingPhoto,
                                    onPressed: () async {
                                      final picker = ImagePicker();
                                      final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
                                      if (pickedFile != null) {
                                        safeSetState(() {
                                          isUploadingPhoto = true;
                                        });
                                        try {
                                          final user = FirebaseAuth.instance.currentUser;
                                          if (user != null) {
                                            final storageRef = FirebaseStorage.instance
                                                .ref()
                                                .child('users/${user.uid}/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg');
                                            
                                            if (kIsWeb) {
                                              final bytes = await pickedFile.readAsBytes();
                                              await storageRef.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
                                            } else {
                                              final file = File(pickedFile.path);
                                              await storageRef.putFile(file);
                                            }
                                            final downloadUrl = await storageRef.getDownloadURL();
                                            await user.updatePhotoURL(downloadUrl);
                                            await FirebaseFirestore.instance.collection('users').doc(user.uid).set({'photo_url': downloadUrl}, SetOptions(merge: true));
                                            
                                            await currentUser?.refreshUser();
                                            
                                            // Trigger auth util to rebuild if it depends on stream, or just setState to update local UI
                                            safeSetState(() {});
                                            
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text('profile.photo_updated'.tr()),
                                              backgroundColor: FlutterFlowTheme.of(context).success,
                                            ));
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text('profile.upload_error'.tr(args: [e.toString()])),
                                            backgroundColor: FlutterFlowTheme.of(context).error,
                                          ));
                                        } finally {
                                          safeSetState(() {
                                            isUploadingPhoto = false;
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                wrapWithModel(
                                  model: _model.textFieldModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    label: null,
                                    helper: null,
                                    hint: 'profile.first_name_hint'.tr(),
                                    value: currentUserDisplayName.split(' ').first,
                                    leading_icon_present: false,
                                    trailing_icon_present: false,
                                    border: Color(0x00000000),
                                    hint_color: 'hint',
                                    variant: 'outlined',
                                    error: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.textFieldModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    label: null,
                                    helper: null,
                                    hint: 'profile.last_name_hint'.tr(),
                                    value: currentUserDisplayName.split(' ').length > 1
                                        ? currentUserDisplayName
                                            .split(' ')
                                            .sublist(1)
                                            .join(' ')
                                        : '',
                                    leading_icon_present: false,
                                    trailing_icon_present: false,
                                    border: Color(0x00000000),
                                    hint_color: 'hint',
                                    variant: 'outlined',
                                    error: false,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'profile.specialization'.tr(),
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.spaceGrotesk(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                            lineHeight: 1.1,
                                          ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: ChooseSpecWidget(),
                                            );
                                          },
                                         ).then((value) {
                                           if (value != null) {
                                             safeSetState(() {});
                                           }
                                         });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  localizeSpecialization(specialization),
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            letterSpacing:
                                                                0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                            lineHeight: 1.4,
                                                          ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 24.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 6.0)),
                                ),
                                wrapWithModel(
                                  model: _model.textFieldModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    label: null,
                                    helper: null,
                                    hint: 'Email',
                                    value: currentUserEmail,
                                    leading_icon_present: false,
                                    trailing_icon_present: false,
                                    border: Color(0x00000000),
                                    hint_color: 'hint',
                                    variant: 'outlined',
                                    error: false,
                                  ),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                wrapWithModel(
                                  model: _model.themeButtonModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ButtonWidget(
                                    content: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? 'Светлая тема'
                                        : 'Темная тема',
                                    icon: Icon(
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Icons.light_mode_rounded
                                          : Icons.dark_mode_rounded,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      size: 20.0,
                                    ),
                                    icon_present: true,
                                    variant: 'ghost',
                                    size: 'medium',
                                    onPressed: () async {
                                      if (Theme.of(context).brightness ==
                                          Brightness.dark) {
                                        MyApp.of(context)
                                            .setThemeMode(ThemeMode.light);
                                      } else {
                                        MyApp.of(context)
                                            .setThemeMode(ThemeMode.dark);
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  'profile.units'.tr(),
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'profile.distance'.tr(),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.spaceGrotesk(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                            lineHeight: 1.1,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () async {
                                              safeSetState(() {
                                                _model.distanceUnit = 'm';
                                              });
                                              await UnitsManager.instance.updateDistanceUnit('m');
                                              await FirebaseFirestore.instance.collection('users').doc(currentUserUid).set({
                                                'distance_unit': 'm',
                                              }, SetOptions(merge: true));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _model.distanceUnit == 'm'
                                                    ? FlutterFlowTheme.of(context).primary
                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: _model.distanceUnit == 'm'
                                                    ? null
                                                    : Border.all(
                                                        color: FlutterFlowTheme.of(context).alternate,
                                                        width: 1.0,
                                                      ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'profile.meters'.tr(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: _model.distanceUnit == 'm'
                                                              ? FlutterFlowTheme.of(context).onPrimary
                                                              : FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () async {
                                              safeSetState(() {
                                                _model.distanceUnit = 'yd';
                                              });
                                              await UnitsManager.instance.updateDistanceUnit('yd');
                                              await FirebaseFirestore.instance.collection('users').doc(currentUserUid).set({
                                                'distance_unit': 'yd',
                                              }, SetOptions(merge: true));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _model.distanceUnit == 'yd'
                                                    ? FlutterFlowTheme.of(context).primary
                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: _model.distanceUnit == 'yd'
                                                    ? null
                                                    : Border.all(
                                                        color: FlutterFlowTheme.of(context).alternate,
                                                        width: 1.0,
                                                      ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'profile.yards'.tr(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: _model.distanceUnit == 'yd'
                                                              ? FlutterFlowTheme.of(context).onPrimary
                                                              : FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'profile.temperature'.tr(),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.spaceGrotesk(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                            lineHeight: 1.1,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () async {
                                              safeSetState(() {
                                                _model.temperatureUnit = 'c';
                                              });
                                              await UnitsManager.instance.updateTemperatureUnit('c');
                                              await FirebaseFirestore.instance.collection('users').doc(currentUserUid).set({
                                                'temp_unit': 'c',
                                              }, SetOptions(merge: true));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _model.temperatureUnit == 'c'
                                                    ? FlutterFlowTheme.of(context).primary
                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: _model.temperatureUnit == 'c'
                                                    ? null
                                                    : Border.all(
                                                        color: FlutterFlowTheme.of(context).alternate,
                                                        width: 1.0,
                                                      ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'profile.celsius'.tr(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: _model.temperatureUnit == 'c'
                                                              ? FlutterFlowTheme.of(context).onPrimary
                                                              : FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () async {
                                              safeSetState(() {
                                                _model.temperatureUnit = 'f';
                                              });
                                              await UnitsManager.instance.updateTemperatureUnit('f');
                                              await FirebaseFirestore.instance.collection('users').doc(currentUserUid).set({
                                                'temp_unit': 'f',
                                              }, SetOptions(merge: true));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _model.temperatureUnit == 'f'
                                                    ? FlutterFlowTheme.of(context).primary
                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: _model.temperatureUnit == 'f'
                                                    ? null
                                                    : Border.all(
                                                        color: FlutterFlowTheme.of(context).alternate,
                                                        width: 1.0,
                                                      ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'profile.fahrenheit'.tr(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: _model.temperatureUnit == 'f'
                                                              ? FlutterFlowTheme.of(context).onPrimary
                                                              : FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'profile.pressure'.tr(),
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.spaceGrotesk(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                            lineHeight: 1.1,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () async {
                                              safeSetState(() {
                                                _model.pressureUnit = 'hpa';
                                              });
                                              await UnitsManager.instance.updatePressureUnit('hpa');
                                              await FirebaseFirestore.instance.collection('users').doc(currentUserUid).set({
                                                'pressure_unit': 'hpa',
                                              }, SetOptions(merge: true));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _model.pressureUnit == 'hpa'
                                                    ? FlutterFlowTheme.of(context).primary
                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: _model.pressureUnit == 'hpa'
                                                    ? null
                                                    : Border.all(
                                                        color: FlutterFlowTheme.of(context).alternate,
                                                        width: 1.0,
                                                      ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'hPa',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: _model.pressureUnit == 'hpa'
                                                              ? FlutterFlowTheme.of(context).onPrimary
                                                              : FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () async {
                                              safeSetState(() {
                                                _model.pressureUnit = 'inhg';
                                              });
                                              await UnitsManager.instance.updatePressureUnit('inhg');
                                              await FirebaseFirestore.instance.collection('users').doc(currentUserUid).set({
                                                'pressure_unit': 'inhg',
                                              }, SetOptions(merge: true));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _model.pressureUnit == 'inhg'
                                                    ? FlutterFlowTheme.of(context).primary
                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: _model.pressureUnit == 'inhg'
                                                    ? null
                                                    : Border.all(
                                                        color: FlutterFlowTheme.of(context).alternate,
                                                        width: 1.0,
                                                      ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'inHg',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: _model.pressureUnit == 'inhg'
                                                              ? FlutterFlowTheme.of(context).onPrimary
                                                              : FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () async {
                                              safeSetState(() {
                                                _model.pressureUnit = 'mm';
                                              });
                                              await UnitsManager.instance.updatePressureUnit('mm');
                                              await FirebaseFirestore.instance.collection('users').doc(currentUserUid).set({
                                                'pressure_unit': 'mm',
                                              }, SetOptions(merge: true));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _model.pressureUnit == 'mm'
                                                    ? FlutterFlowTheme.of(context).primary
                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                shape: BoxShape.rectangle,
                                                border: _model.pressureUnit == 'mm'
                                                    ? null
                                                    : Border.all(
                                                        color: FlutterFlowTheme.of(context).alternate,
                                                        width: 1.0,
                                                      ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'mmHg',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: _model.pressureUnit == 'mm'
                                                              ? FlutterFlowTheme.of(context).onPrimary
                                                              : FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 1.1,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Divider(
                                    height: 16.0,
                                    thickness: 1.0,
                                    indent: 0.0,
                                    endIndent: 0.0,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                  wrapWithModel(
                                    model: _model.themeButtonModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ButtonWidget(
                                      content: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? 'profile.theme_light'.tr()
                                          : 'profile.theme_dark'.tr(),
                                      icon: Icon(
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Icons.light_mode_rounded
                                            : Icons.dark_mode_rounded,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? FlutterFlowTheme.of(context).primary
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                        size: 20.0,
                                      ),
                                      icon_present: true,
                                      variant: 'ghost',
                                      size: 'medium',
                                      onPressed: () async {
                                        if (Theme.of(context).brightness ==
                                            Brightness.dark) {
                                          MyApp.of(context)
                                              .setThemeMode(ThemeMode.light);
                                        } else {
                                          MyApp.of(context)
                                              .setThemeMode(ThemeMode.dark);
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child: DropdownButtonFormField<Locale>(
                                      value: context.locale,
                                      decoration: InputDecoration(
                                        labelText: 'language'.tr(),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).alternate,
                                          ),
                                        ),
                                      ),
                                      dropdownColor: FlutterFlowTheme.of(context).secondaryBackground,
                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                      items: const [
                                        DropdownMenuItem(
                                          value: Locale('ru'),
                                          child: Text('Русский'),
                                        ),
                                        DropdownMenuItem(
                                          value: Locale('en'),
                                          child: Text('English'),
                                        ),
                                      ],
                                      onChanged: (Locale? newLocale) {
                                        if (newLocale != null) {
                                          context.setLocale(newLocale);
                                        }
                                      },
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.buttonModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ButtonWidget(
                                      content: 'profile.delete_account'.tr(),
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        size: 16.0,
                                      ),
                                      icon_present: true,
                                      icon_end_present: false,
                                      color: FlutterFlowTheme.of(context).error,
                                      variant: 'ghost',
                                      size: 'medium',
                                      full_width: true,
                                      loading: false,
                                      disabled: false,
                                      onPressed: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment: Alignment(0.0, 0.0),
                                              child: DeleteAccountWidget(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ),
                                ].divide(SizedBox(height: 32.0)),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}
