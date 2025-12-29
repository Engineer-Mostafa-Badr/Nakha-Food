import 'package:nakha/features/home/data/models/home_utils_model.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final String notSpecified = 'not_specified'.tr();

class AppConst {
  static const appName = 'نكهة بيتنا';
  static int versionNumber = 1;
  static bool isFirstTimeCheck = true;
  static bool appInReview = false;
  static HomeModel? homeModel;
  static const String countryCode = 'EG';
  static String absenceAppointmentCost = '150';
  static const String errorText = 'something_went_wrong';
  static const String successText = 'successful_operation';
  static int userId = 0;
  static String ordersAlert = '';
  static bool isLogin = false;
  static String youtubeVideoId = '';
  static UserModel? user;
  static String currency = 'sar'.tr();
  static const Duration minimumAge = Duration(days: 6209, hours: 6);
  static const cacheExtent = 1000.0;
  static String fcmToken = '';

  static String fontName(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'ar':
        return 'Tajawal';
      case 'ur':
        return 'Tajawal';
      case 'en':
        return 'Tajawal';
      default:
        return 'Tajawal';
    }
  }

  static List<String> permissions = [];

  static DateFormat mostUsedDateFormat = DateFormat('yyyy-MM-dd', 'en_US');

  /// BOXES NAMES
  static const mainBoxName = 'mainBox';
  static const userIdBox = 'userId';
  static const isDarkBox = 'isDarkBox';
  static const introFinishBox = 'introFinish';
  static const tokenBox = 'token';
  static const isLoggedInBox = 'isLoggedIn';
  static const currencyBox = 'currency';
  static const userBox = 'userDate';
  static const isVerifiedBox = 'isVerifiedBox';
  static const isAppUpdated = 'isAppUpdated';
}
