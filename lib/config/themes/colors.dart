import 'package:flutter/material.dart';

class AppColors {
  /// primary colors
  static const MaterialColor cPrimary = MaterialColor(0xffE9B00A, <int, Color>{
    50: Color(0xffE9B00A),
    100: Color(0xffE9B00A),
    200: Color(0xffE9B00A),
    300: Color(0xffE9B00A),
    400: Color(0xffE9B00A),
    500: Color(0xffE9B00A),
    600: Color(0xffE9B00A),
    700: Color(0xffE9B00A),
    800: Color(0xffE9B00A),
    900: Color(0xffE9B00A),
  });

  static const cPrimaryBold = Color(0xff004B40);

  // static const cBlueColor = Color(0xff4285F4);
  static const cSecondary = Color(0xff182B7B);
  static const cRate = Color(0xffFFC800);
  static const cAlert = Color(0xffE39233);
  static const cError = Color(0xFFFF2A2A);
  static const cSuccess = Color(0xFF00BE49);
  static const toastColor = Color(0xff404040);
  static const cyanDarkColor = Color(0xFF1E9D9F);

  /// backgrounds
  static const cScaffoldBackgroundColorLight = Color(0xffF8F9FA);
  static const cScaffoldBackgroundColorDark = Color(0xff3e3e3e);
  static const cAppBarLight = cScaffoldBackgroundColorLight;
  static const cAppBarDark = Colors.transparent;
  static const cBottomBarLight = Colors.white;
  static const cBottomBarDark = cScaffoldBackgroundColorDark;

  /// icons
  static const cSelectedIcon = Color(0xffE9B00A);
  static const cUnSelectedIconLight = Color(0xff9CA3AF);
  static const cUnSelectedIconDark = Colors.white;

  static const cAppBarIconLight = Colors.black;
  static const cAppBarIconDark = Colors.white;

  static const cIconLight = cPrimary;
  static const cIconDark = Colors.white;

  static const boldGreyColor = Color(0xff9CA3AF);
  static const greyBDColor = Color(0xffBDBDBD);
  static const greyD2Color = Color(0xffD2D2D2);
  static const grey54Color = Color(0xff545454);
  static const grey67Color = Color(0xff676767);

  // static const greyF9Color = Color(0xffF9F9F9);
  // static const greyEFColor = Color(0xffEFEFEF);
  // static const greyDDColor = Color(0xffDDDDDD);

  /// textformfield
  static const cFillTextFieldLight = Color(0xffEDEAF1);
  static const cFillTextFieldDark = Color(0xffEFF2F5);
  static const cFillBorderLight = Color(0xffDDDDDD);
  static const cTextOfTextFormLight = Color(0xff8C8888);
  static const cTextOfTextFormDark = Color(0xffB3BFCB);
  static const cLowPrimaryTitle = Color(0xff6A798A);

  /// cards
  static const cCardLight = Color(0xffF5F5F5);
  static const cCardDark = Color(0xff0a1217);

  /// divider
  static const cDividerLight = Color(0xffE3E3E3);
  static const cDividerDark = Color(0xffA39797);

  /// text color
  static const cTextLight = Colors.black;
  static const cTextDark = Colors.white;
  static const cAppBarTextLight = Colors.black;
  static const cAppBarTextDark = cTextDark;
  static const cTextSubtitleLight = Color(0xff626262);
  static const cTextSubtitleDark = Color(0xff756F6F);
}
