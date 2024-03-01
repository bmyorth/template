import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_theme.dart';

class AppStyles {
  //..
  //THEME
  //..

  // Theme config for FlexColorScheme version 7.3.x. Make sure you use
  // same or higher package version, but still same major version. If you
  // use a lower package version, some properties may not be supported.
  // In that case remove them after copying this theme to your app.

  static final lightTheme = FlexThemeData.light(
    scheme: FlexScheme.shark,
    usedColors: 1,
    appBarStyle: FlexAppBarStyle.background,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useM2StyleDividerInM3: true,
      splashType: FlexSplashType.inkSplash,
      elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
      outlinedButtonRadius: 10.0,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      outlinedButtonPressedBorderWidth: 2.0,
      segmentedButtonSchemeColor: SchemeColor.primary,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorBackgroundAlpha: 21,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      fabSchemeColor: SchemeColor.tertiary,
      chipSelectedSchemeColor: SchemeColor.tertiary,
      cardRadius: 10.0,
      popupMenuRadius: 6.0,
      popupMenuElevation: 4.0,
      alignedDropdown: true,
      dialogElevation: 3.0,
      dialogRadius: 20.0,
      useInputDecoratorThemeInDialogs: true,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      menuRadius: 6.0,
      menuElevation: 4.0,
      menuBarElevation: 0.0,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarMutedUnselectedLabel: false,
      navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationBarMutedUnselectedIcon: false,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarIndicatorOpacity: 1.00,
      navigationBarBackgroundSchemeColor: SchemeColor.background,
      navigationBarElevation: 0.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailMutedUnselectedLabel: false,
      navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationRailMutedUnselectedIcon: false,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      keepPrimary: true,
      keepSecondary: true,
      keepTertiary: true,
      keepPrimaryContainer: true,
      keepSecondaryContainer: true,
      keepTertiaryContainer: true,
    ),
    tones: FlexTones.oneHue(Brightness.light)
        .onMainsUseBW()
        .onSurfacesUseBW()
        .surfacesUseBW(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
  static final darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.shark,
    usedColors: 1,
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    blendLevel: 4,
    appBarStyle: FlexAppBarStyle.background,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendTextTheme: true,
      useM2StyleDividerInM3: true,
      splashType: FlexSplashType.inkSplash,
      elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
      outlinedButtonRadius: 10.0,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      outlinedButtonPressedBorderWidth: 2.0,
      segmentedButtonSchemeColor: SchemeColor.primary,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorBackgroundAlpha: 43,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      fabSchemeColor: SchemeColor.tertiary,
      chipSelectedSchemeColor: SchemeColor.tertiary,
      cardRadius: 10.0,
      popupMenuRadius: 6.0,
      popupMenuElevation: 4.0,
      alignedDropdown: true,
      dialogElevation: 3.0,
      dialogRadius: 20.0,
      useInputDecoratorThemeInDialogs: true,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      menuRadius: 6.0,
      menuElevation: 4.0,
      menuBarElevation: 0.0,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarMutedUnselectedLabel: false,
      navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationBarMutedUnselectedIcon: false,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarIndicatorOpacity: 1.00,
      navigationBarBackgroundSchemeColor: SchemeColor.background,
      navigationBarElevation: 0.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailMutedUnselectedLabel: false,
      navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationRailMutedUnselectedIcon: false,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
    ),
    tones: FlexTones.oneHue(Brightness.dark),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.roboto().fontFamily,
  );

  /// Estilos de los inputs de textos [Válidos]
  static const inputsTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorDark,
    // letterSpacing: 0.5,
  );

  /// Estilos de los item bottom bar
  static const textStyleBottomBar = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  /// Estilos de los botones de textos [Válidos]
  static const buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    letterSpacing: 1.0,
    // letterSpacing: 0.5,
  );

  /// Estilos de los inputs de textos [Erroneos]
  static final inputsTextErrorStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.errorColor,
  );

  /// Estilos de los inputs de textos cuando estan en los
  /// estados [enabledBorder] y [focusedBorder]
  static final inputsBorderOK = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.accent, width: 1));

  /// Estilos de los inputs de textos cuando estan en los
  /// estados [enabledBorder] y [focusedBorder]
  static final inputsBorderFocus = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.focusInput, width: 1));

  /// Estilos de los inputs de textos cuando estan en los
  /// estados [errorBorder] y [focusedErrorBorder]
  static final inputsBorderError = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.red, width: 1));

  /// Estilo button blanco
  static final buttonElevateWhite = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.white),
    padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
    // textStyle:
    //     MaterialStateProperty.all(TextStyle(color: AppColors.primary))
  );

  static BoxShadow shadowWidgets = const BoxShadow(
    color: AppColors.secondary,
    spreadRadius: 1,
    blurRadius: 5,
    offset: Offset(0, 1), // changes position of shadow
  );
}
