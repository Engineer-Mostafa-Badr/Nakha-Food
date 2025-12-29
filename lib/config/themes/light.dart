import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/core/utils/app_sizes.dart';

ThemeData lightTheme(BuildContext context) => ThemeData(
  useMaterial3: true,
  cardColor: AppColors.cCardLight,

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.cScaffoldBackgroundColorLight,
    surfaceTintColor: AppColors.cScaffoldBackgroundColorLight,
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: AppColors.cScaffoldBackgroundColorLight,
    surfaceTintColor: AppColors.cScaffoldBackgroundColorLight,
  ),
  timePickerTheme: const TimePickerThemeData(
    dayPeriodColor: AppColors.cSecondary,
    dayPeriodTextColor: AppColors.cPrimary,
  ),
  iconTheme: const IconThemeData(color: AppColors.cIconLight),
  primaryColor: AppColors.cPrimary,
  popupMenuTheme: const PopupMenuThemeData(
    surfaceTintColor: AppColors.cScaffoldBackgroundColorLight,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.cFillTextFieldLight,
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
      color: AppColors.cTextOfTextFormLight,
      fontSize: AppFontSize.f14,
    ),
    labelStyle: TextStyle(
      color: AppColors.cTextOfTextFormLight,
      fontSize: AppFontSize.f14,
    ),
    errorStyle: TextStyle(color: AppColors.cError, fontSize: AppFontSize.f10),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppPadding.largePadding,
      vertical: AppPadding.mediumPadding,
    ),
    suffixIconColor: AppColors.cTextSubtitleLight,
    prefixIconColor: AppColors.cTextSubtitleLight,
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: TextStyle(
      color: AppColors.cTextSubtitleLight,
      fontSize: AppFontSize.f14,
      fontWeight: FontWeight.w600,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
        borderSide: const BorderSide(
          color: AppColors.cFillBorderLight,
          width: .5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
        borderSide: const BorderSide(
          color: AppColors.cFillBorderLight,
          width: .5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
        borderSide: const BorderSide(
          color: AppColors.cFillBorderLight,
          width: .5,
        ),
      ),
      outlineBorder: BorderSide.none,
      hintStyle: TextStyle(
        color: AppColors.cTextOfTextFormLight,
        fontSize: AppFontSize.f14,
      ),
      labelStyle: TextStyle(
        color: AppColors.cTextOfTextFormLight,
        fontSize: AppFontSize.f14,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.radius10),
        borderSide: const BorderSide(color: AppColors.cError, width: .5),
      ),
      errorStyle: TextStyle(color: AppColors.cError, fontSize: AppFontSize.f10),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppPadding.mediumPadding,
        vertical: AppPadding.padding12,
      ),
      suffixIconColor: AppColors.cTextSubtitleLight,
      prefixIconColor: AppColors.cTextSubtitleLight,
    ),
    menuStyle: MenuStyle(
      elevation: WidgetStateProperty.all(0.0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      backgroundColor: WidgetStateProperty.all(AppColors.cFillTextFieldLight),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.mostUsedRadius),
        ),
      ),
      surfaceTintColor: WidgetStateProperty.all(AppColors.cFillTextFieldLight),
    ),
    //backgroundColor: AppColors.cFillTextFieldLight,
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
  dividerTheme: const DividerThemeData(color: AppColors.cDividerLight),
  primarySwatch: AppColors.cPrimary,
  tabBarTheme: TabBarThemeData(
    labelColor: Colors.black,
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    unselectedLabelColor: AppColors.cTextSubtitleLight,
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
      color: AppColors.cAppBarTextLight,
      fontFamily: AppConst.fontName(context),
      fontWeight: FontWeight.w600,
      fontSize: AppFontSize.f16,
    ),
    elevation: 0.0,
    centerTitle: true,
    titleSpacing: 0.0,
    backgroundColor: AppColors.cAppBarLight,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: AppColors.cBottomBarLight,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
    ),
    iconTheme: const IconThemeData(color: AppColors.cAppBarIconLight),
  ),
  // primarySwatch: MyColors.cPrimary,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.cPrimary,
  ),
  fontFamily: AppConst.fontName(context),
  textTheme:
      const TextTheme(
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
      ).apply(
        bodyColor: AppColors.cTextLight,
        displayColor: Colors.blue,
        fontFamily: AppConst.fontName(context),
      ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedIconTheme: const IconThemeData(
      size: 26,
      color: AppColors.cUnSelectedIconLight,
    ),
    selectedIconTheme: const IconThemeData(
      size: 26,
      color: AppColors.cSelectedIcon,
    ),
    selectedItemColor: AppColors.cSelectedIcon,
    unselectedItemColor: AppColors.cUnSelectedIconLight,
    backgroundColor: AppColors.cBottomBarLight,
    elevation: 40,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: AppFontSize.f12,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: AppFontSize.f12,
      color: AppColors.cFillBorderLight,
    ),
  ),
  scaffoldBackgroundColor: AppColors.cScaffoldBackgroundColorLight,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.cPrimary,
    extendedTextStyle: TextStyle(color: Colors.white),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.cIconLight,
    textColor: AppColors.cTextLight,
    selectedColor: AppColors.cSelectedIcon,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.cScaffoldBackgroundColorLight,
    surfaceTintColor: AppColors.cScaffoldBackgroundColorLight,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    iconColor: AppColors.cIconLight,
    textColor: AppColors.cTextLight,
  ),
  fontFamilyFallback: [AppConst.fontName(context)],
);
