// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';

SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color onPrimary;
  late Color onSecondary;
  late Color onSurface;
  late Color onError;
  late Color transparent;
  late Color primary20;
  late Color surface30;
  late Color divider50;
  late Color surface50;
  late Color success10;
  late Color success30;
  late Color primary80;
  late Color background40;
  late Color primary40;
  late Color surface20;
  late Color accent30;
  late Color success20;
  late Color success40;
  late Color error10;
  late Color hint20;
  late Color primary10;
  late Color surface80;
  late Color primary30;
  late Color success50;
  late Color primary100;

  FFDesignTokens get designToken => FFDesignTokens(this);

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  bool get displayLargeIsCustom => typography.displayLargeIsCustom;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  bool get displayMediumIsCustom => typography.displayMediumIsCustom;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  bool get displaySmallIsCustom => typography.displaySmallIsCustom;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  bool get headlineLargeIsCustom => typography.headlineLargeIsCustom;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  bool get headlineMediumIsCustom => typography.headlineMediumIsCustom;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  bool get headlineSmallIsCustom => typography.headlineSmallIsCustom;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  bool get titleLargeIsCustom => typography.titleLargeIsCustom;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  bool get titleMediumIsCustom => typography.titleMediumIsCustom;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  bool get titleSmallIsCustom => typography.titleSmallIsCustom;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  bool get labelLargeIsCustom => typography.labelLargeIsCustom;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  bool get labelMediumIsCustom => typography.labelMediumIsCustom;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  bool get labelSmallIsCustom => typography.labelSmallIsCustom;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  bool get bodyLargeIsCustom => typography.bodyLargeIsCustom;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  bool get bodyMediumIsCustom => typography.bodyMediumIsCustom;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  bool get bodySmallIsCustom => typography.bodySmallIsCustom;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF33793B);
  late Color secondary = const Color(0xFFF3F4F6);
  late Color tertiary = const Color(0xFF10B981);
  late Color alternate = const Color(0xFFE5E7EB);
  late Color primaryText = const Color(0xFF111827);
  late Color secondaryText = const Color(0xFF4B5563);
  late Color primaryBackground = const Color(0xFFF9FAFB);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0xFF9CA3AF);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF059669);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFDC2626);
  late Color info = const Color(0xFFFFFFFF);

  late Color onPrimary = const Color(0xFFFFFFFF);
  late Color onSecondary = const Color(0xFF111827);
  late Color onSurface = const Color(0xFF111827);
  late Color onError = const Color(0xFFFFFFFF);
  late Color transparent = const Color(0x00000000);
  late Color primary20 = const Color(0x3333793B);
  late Color surface30 = const Color(0x4DFFFFFF);
  late Color divider50 = const Color(0x80E5E7EB);
  late Color surface50 = const Color(0x80FFFFFF);
  late Color success10 = const Color(0x1A059669);
  late Color success30 = const Color(0x4D059669);
  late Color primary80 = const Color(0xCC33793B);
  late Color background40 = const Color(0x66F9FAFB);
  late Color primary40 = const Color(0x6633793B);
  late Color surface20 = const Color(0x33FFFFFF);
  late Color accent30 = const Color(0x4D10B981);
  late Color success20 = const Color(0x33059669);
  late Color success40 = const Color(0x66059669);
  late Color error10 = const Color(0x1ADC2626);
  late Color hint20 = const Color(0x339CA3AF);
  late Color primary10 = const Color(0x1A33793B);
  late Color surface80 = const Color(0xCCFFFFFF);
  late Color primary30 = const Color(0x4D33793B);
  late Color success50 = const Color(0x80059669);
  late Color primary100 = const Color(0xFF33793B);
}

abstract class Typography {
  String get displayLargeFamily;
  bool get displayLargeIsCustom;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  bool get displayMediumIsCustom;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  bool get displaySmallIsCustom;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  bool get headlineLargeIsCustom;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  bool get headlineMediumIsCustom;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  bool get headlineSmallIsCustom;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  bool get titleLargeIsCustom;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  bool get titleMediumIsCustom;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  bool get titleSmallIsCustom;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  bool get labelLargeIsCustom;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  bool get labelMediumIsCustom;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  bool get labelSmallIsCustom;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  bool get bodyLargeIsCustom;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  bool get bodyMediumIsCustom;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  bool get bodySmallIsCustom;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Inter Tight';
  bool get displayLargeIsCustom => false;
  TextStyle get displayLarge => GoogleFonts.interTight(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 64.0,
      );
  String get displayMediumFamily => 'Inter Tight';
  bool get displayMediumIsCustom => false;
  TextStyle get displayMedium => GoogleFonts.interTight(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 44.0,
      );
  String get displaySmallFamily => 'Inter Tight';
  bool get displaySmallIsCustom => false;
  TextStyle get displaySmall => GoogleFonts.interTight(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      );
  String get headlineLargeFamily => 'Space Grotesk';
  bool get headlineLargeIsCustom => false;
  TextStyle get headlineLarge => GoogleFonts.spaceGrotesk(
        color: theme.primaryText,
        fontWeight: FontWeight.w800,
        fontSize: 34.0,
        height: 1.1,
      );
  String get headlineMediumFamily => 'Space Grotesk';
  bool get headlineMediumIsCustom => false;
  TextStyle get headlineMedium => GoogleFonts.spaceGrotesk(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 28.0,
        height: 1.1,
      );
  String get headlineSmallFamily => 'Inter Tight';
  bool get headlineSmallIsCustom => false;
  TextStyle get headlineSmall => GoogleFonts.interTight(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      );
  String get titleLargeFamily => 'Space Grotesk';
  bool get titleLargeIsCustom => false;
  TextStyle get titleLarge => GoogleFonts.spaceGrotesk(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
        height: 1.2,
      );
  String get titleMediumFamily => 'Space Grotesk';
  bool get titleMediumIsCustom => false;
  TextStyle get titleMedium => GoogleFonts.spaceGrotesk(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 17.0,
        height: 1.2,
      );
  String get titleSmallFamily => 'Inter Tight';
  bool get titleSmallIsCustom => false;
  TextStyle get titleSmall => GoogleFonts.interTight(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Space Grotesk';
  bool get labelLargeIsCustom => false;
  TextStyle get labelLarge => GoogleFonts.spaceGrotesk(
        color: theme.secondaryText,
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
        height: 1.1,
      );
  String get labelMediumFamily => 'Space Grotesk';
  bool get labelMediumIsCustom => false;
  TextStyle get labelMedium => GoogleFonts.spaceGrotesk(
        color: theme.secondaryText,
        fontWeight: FontWeight.bold,
        fontSize: 13.0,
        height: 1.1,
      );
  String get labelSmallFamily => 'Space Grotesk';
  bool get labelSmallIsCustom => false;
  TextStyle get labelSmall => GoogleFonts.spaceGrotesk(
        color: theme.secondaryText,
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        height: 1.1,
      );
  String get bodyLargeFamily => 'Inter';
  bool get bodyLargeIsCustom => false;
  TextStyle get bodyLarge => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
        height: 1.4,
      );
  String get bodyMediumFamily => 'Inter';
  bool get bodyMediumIsCustom => false;
  TextStyle get bodyMedium => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 15.0,
        height: 1.4,
      );
  String get bodySmallFamily => 'Inter';
  bool get bodySmallIsCustom => false;
  TextStyle get bodySmall => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 13.0,
        height: 1.3,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF33793B);
  late Color secondary = const Color(0xFF1E293B);
  late Color tertiary = const Color(0xFF34D399);
  late Color alternate = const Color(0xFF334155);
  late Color primaryText = const Color(0xFFF9FAFB);
  late Color secondaryText = const Color(0xFF94A3B8);
  late Color primaryBackground = const Color(0xFF0F172A);
  late Color secondaryBackground = const Color(0xFF1E293B);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0xFF64748B);
  late Color accent4 = const Color(0xB2262D34);
  late Color success = const Color(0xFF10B981);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFEF4444);
  late Color info = const Color(0xFFFFFFFF);

  late Color onPrimary = const Color(0xFF000000);
  late Color onSecondary = const Color(0xFFFFFFFF);
  late Color onSurface = const Color(0xFFF9FAFB);
  late Color onError = const Color(0xFFFFFFFF);
  late Color transparent = const Color(0x00000000);
  late Color primary20 = const Color(0x3333793B);
  late Color surface30 = const Color(0x4D1E293B);
  late Color divider50 = const Color(0x80334155);
  late Color surface50 = const Color(0x801E293B);
  late Color success10 = const Color(0x1A10B981);
  late Color success30 = const Color(0x4D10B981);
  late Color primary80 = const Color(0xCC33793B);
  late Color background40 = const Color(0x660F172A);
  late Color primary40 = const Color(0x6633793B);
  late Color surface20 = const Color(0x331E293B);
  late Color accent30 = const Color(0x4D34D399);
  late Color success20 = const Color(0x3310B981);
  late Color success40 = const Color(0x6610B981);
  late Color error10 = const Color(0x1AEF4444);
  late Color hint20 = const Color(0x3364748B);
  late Color primary10 = const Color(0x1A33793B);
  late Color surface80 = const Color(0xCC1E293B);
  late Color primary30 = const Color(0x4D33793B);
  late Color success50 = const Color(0x8010B981);
  late Color primary100 = const Color(0xFF33793B);
}

class FFDesignTokens {
  const FFDesignTokens(this.theme);
  final FlutterFlowTheme theme;
  FFSpacing get spacing => const FFSpacing();
  FFRadius get radius => const FFRadius();
  FFShadows get shadow => FFShadows(theme);
}

class FFSpacing {
  const FFSpacing();
  double get none => 0.0;
  double get xs => 4.0;
  double get sm => 8.0;
  double get md => 16.0;
  double get lg => 24.0;
  double get xl => 32.0;
  double get xxl => 48.0;
  double get xxxl => 64.0;
}

class FFRadius {
  const FFRadius();
  double get none => 0.0;
  double get xs => 2.0;
  double get sm => 2.0;
  double get md => 4.0;
  double get lg => 6.0;
  double get xl => 24.0;
  double get xxl => 32.0;
  double get full => 9999.0;
}

class FFShadows {
  const FFShadows(this.theme);
  final FlutterFlowTheme theme;
  BoxShadow get sm => const BoxShadow(
      blurRadius: 2.0,
      color: const Color(0x4D000000),
      offset: const Offset(0.0, 1.0),
      spreadRadius: 0.0);
  BoxShadow get md => const BoxShadow(
      blurRadius: 8.0,
      color: const Color(0x66000000),
      offset: const Offset(0.0, 4.0),
      spreadRadius: 0.0);
  BoxShadow get lg => const BoxShadow(
      blurRadius: 16.0,
      color: const Color(0x80000000),
      offset: const Offset(0.0, 8.0),
      spreadRadius: 0.0);
  BoxShadow get xl => const BoxShadow(
      blurRadius: 24.0,
      color: const Color(0x99000000),
      offset: const Offset(0.0, 12.0),
      spreadRadius: 0.0);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    String? package,
  }) {
    if (useGoogleFonts && fontFamily != null) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }

    return font != null
        ? font.copyWith(
            color: color ?? this.color,
            fontSize: fontSize ?? this.fontSize,
            letterSpacing: letterSpacing ?? this.letterSpacing,
            fontWeight: fontWeight ?? this.fontWeight,
            fontStyle: fontStyle ?? this.fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          )
        : copyWith(
            fontFamily: fontFamily,
            package: package,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          );
  }
}
