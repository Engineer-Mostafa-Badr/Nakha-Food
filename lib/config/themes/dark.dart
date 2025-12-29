import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';

/// dark theme not used in this project
/// need to specify the colors
ThemeData darkTheme(BuildContext context) => ThemeData(
  useMaterial3: true,
  cardColor: AppColors.cCardDark,
  dialogTheme: const DialogThemeData(
    // backgroundColor: AppColors.cScaffoldBackgroundColorDark,
    // surfaceTintColor: AppColors.cScaffoldBackgroundColorDark,
  ),
  timePickerTheme: const TimePickerThemeData(
    dayPeriodColor: AppColors.cSecondary,
    dayPeriodTextColor: AppColors.cPrimary,
  ),
  iconTheme: const IconThemeData(color: AppColors.cIconDark),
  primaryColor: AppColors.cPrimary,
  popupMenuTheme: const PopupMenuThemeData(
    surfaceTintColor: AppColors.cScaffoldBackgroundColorDark,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.cFillTextFieldDark,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.mostUsedRadius),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.mostUsedRadius),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppBorderRadius.mostUsedRadius),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(
      color: AppColors.cTextOfTextFormDark,
      fontSize: AppFontSize.f13,
    ),
    labelStyle: TextStyle(
      color: AppColors.cTextOfTextFormDark,
      fontSize: AppFontSize.f13,
    ),
    errorStyle: TextStyle(color: AppColors.cError, fontSize: AppFontSize.f10),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppPadding.largePadding,
      vertical: AppPadding.mediumPadding,
    ),
    suffixIconColor: AppColors.cTextSubtitleDark,
    prefixIconColor: AppColors.cTextSubtitleDark,
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: TextStyle(
      color: AppColors.cTextSubtitleDark,
      fontSize: AppFontSize.f14,
      fontWeight: FontWeight.w600,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.cFillTextFieldDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.mostUsedRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.mostUsedRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.mostUsedRadius),
        borderSide: BorderSide.none,
      ),
      outlineBorder: BorderSide.none,
      hintStyle: TextStyle(
        color: AppColors.cTextSubtitleDark,
        fontSize: AppFontSize.f14,
      ),
      labelStyle: TextStyle(
        color: AppColors.cTextSubtitleDark,
        fontSize: AppFontSize.f14,
      ),
      errorStyle: TextStyle(color: AppColors.cError, fontSize: AppFontSize.f10),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppPadding.mediumPadding,
        vertical: AppPadding.mediumPadding,
      ),
      suffixIconColor: AppColors.cTextSubtitleDark,
      prefixIconColor: AppColors.cTextSubtitleDark,
    ),
    menuStyle: MenuStyle(
      elevation: WidgetStateProperty.all(0.0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      backgroundColor: WidgetStateProperty.all(AppColors.cFillTextFieldDark),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.mostUsedRadius),
        ),
      ),
      surfaceTintColor: WidgetStateProperty.all(AppColors.cFillTextFieldDark),
    ),
    //backgroundColor: AppColors.cFillTextFieldDark,
    //borderRadius: BorderRadius.all(Radius.circular(AppBorderRadius.textformRadius)),
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.cPrimary,
    //secondary: AppColors.cPrimary,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(AppColors.cPrimary),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
  ),
  dividerTheme: const DividerThemeData(color: AppColors.cDividerDark),
  primarySwatch: AppColors.cPrimary,
  tabBarTheme: TabBarThemeData(
    labelColor: Colors.black,
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    unselectedLabelColor: AppColors.cTextSubtitleDark,
    labelStyle: TextStyle(
      fontSize: AppFontSize.f14,
      fontWeight: FontWeight.w600,
      fontFamily: AppConst.fontName(context),
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: AppFontSize.f14,
      fontWeight: FontWeight.w600,
      fontFamily: AppConst.fontName(context),
    ),
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColors.cPrimary, width: 2.0),
      insets: EdgeInsets.symmetric(horizontal: 16.0),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: AppColors.cAppBarTextDark,
      fontFamily: AppConst.fontName(context),
      fontWeight: FontWeight.w600,
      fontSize: AppFontSize.f16,
    ),
    elevation: 0.0,
    centerTitle: true,
    titleSpacing: 0.0,
    backgroundColor: AppColors.cAppBarDark,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: AppColors.cBottomBarDark,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
    ),
    iconTheme: const IconThemeData(color: AppColors.cAppBarIconDark),
  ),
  //primarySwatch: MyColors.cPrimary,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.cPrimary,
  ),
  fontFamily: AppConst.fontName(context),
  textTheme: const TextTheme(
    labelLarge: TextStyle(),
    labelMedium: TextStyle(),
    labelSmall: TextStyle(),
    titleLarge: TextStyle(),
    titleMedium: TextStyle(),
    titleSmall: TextStyle(),
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(),
    bodySmall: TextStyle(),
    headlineLarge: TextStyle(),
    headlineMedium: TextStyle(),
    headlineSmall: TextStyle(),
    displayLarge: TextStyle(),
    displayMedium: TextStyle(),
    displaySmall: TextStyle(),
  ).apply(bodyColor: AppColors.cTextDark, displayColor: Colors.blue),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedIconTheme: const IconThemeData(size: 26),
    selectedIconTheme: const IconThemeData(
      size: 26,
      color: AppColors.cSelectedIcon,
    ),
    selectedItemColor: AppColors.cSelectedIcon,
    unselectedItemColor: AppColors.cUnSelectedIconDark,
    backgroundColor: AppColors.cBottomBarDark,
    elevation: 40,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: AppFontSize.f12,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: AppFontSize.f12,
    ),
  ),
  scaffoldBackgroundColor: AppColors.cScaffoldBackgroundColorDark,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.cPrimary,
    extendedTextStyle: TextStyle(color: Colors.white),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.cIconDark,
    textColor: AppColors.cTextDark,
    selectedColor: AppColors.cSelectedIcon,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.cScaffoldBackgroundColorDark,
    surfaceTintColor: AppColors.cScaffoldBackgroundColorDark,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    iconColor: AppColors.cIconDark,
    textColor: AppColors.cTextDark,
  ),
  fontFamilyFallback: [AppConst.fontName(context)],
);
