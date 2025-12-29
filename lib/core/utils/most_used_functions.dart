import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakha/config/navigator_key/navigator_key.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/utils/other_helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class MostUsedFunctions {
  static Future<void> copyToClipboardFun(String text) async {
    Clipboard.setData(ClipboardData(text: text));
  }

  static void printFullText(String text) {
    if (!kDebugMode) return;
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((match) => debugPrint(match.group(0).toString()));
  }

  static void closeKeyBoard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void showSnackBarFun(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: Text(text, style: const TextStyle(color: Colors.white)).tr(),
        backgroundColor: AppColors.cPrimary,
      ),
    );
  }

  /// copy to clipboard and show snackbar
  static Future<void> copyToClipboardAndShowSnackBarFun(String text) async {
    await copyToClipboardFun(text);
    OtherHelper.showTopSuccessToast('copied_to_clipboard');
  }

  /// url launcher
  static Future<void> urlLauncherFun(
    String url, {
    LaunchMode launchMode = LaunchMode.externalApplication,
  }) async {
    try {
      await launchUrl(Uri.parse(url), mode: launchMode);
    } catch (e) {
      MostUsedFunctions.printFullText(e.toString());
    }
  }

  /// open map
  static Future<void> openMapFunWithLatLong(
    double latitude,
    double longitude,
  ) async {
    final url = Platform.isIOS
        ? 'http://maps.apple.com/?q=$latitude,$longitude'
        : 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    urlLauncherFun(url);
  }

  /// open map with location
  static Future<void> openMapWithLocationFun(String location) async {
    final url = Platform.isIOS
        ? 'http://maps.apple.com/?q=$location'
        : 'https://www.google.com/maps/search/?api=1&query=$location';

    urlLauncherFun(url);
  }

  /// status color
  static Color statusColor(String status) {
    switch (status) {
      case 'partially paid' || 'transferred' || 'retreat' || 'pending':
        return AppColors.cAlert;
      case 'refused' ||
          'cancelled' ||
          'rejected' ||
          'withdraw' ||
          'failed' ||
          'refunded':
        return AppColors.cError;
      case 'in_progress' ||
          'in-progress' ||
          'paid' ||
          'active' ||
          'approved' ||
          'completed' ||
          'accepted' ||
          'deposit' ||
          'payment':
        return AppColors.cSuccess;
      default:
        return Colors.grey;
    }
  }

  /// convert number to K
  static String convertNumberToK(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}m';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }

  /// return shift name
  static String getShiftName(int shiftOrder) {
    switch (shiftOrder) {
      case 0:
        return 'full_day';
      case 1:
        return 'first_shift';
      case 2:
        return 'second_shift';
      case 3:
        return 'third_shift';
      case 4:
        return 'fourth_shift';
      default:
        return '';
    }
  }

  /// function give it range of dates like from 1-1-2022 to 1-1-2023 and return list of string of days and the start and end date is included
  // static List<String> getDaysOfRange(
  //   String from,
  //   String to,
  //   BuildContext context,
  // ) {
  //   final List<String> days = [];
  //   final DateTime startDate = DateTime.parse(from);
  //   final DateTime endDate = DateTime.parse(to);
  //   for (DateTime date = startDate;
  //       date.isBefore(endDate);
  //       date = date.add(const Duration(days: 1))) {
  //     days.add(
  //       DateFormat('E', Localizations.localeOf(context).languageCode)
  //           .format(date),
  //     );
  //   }
  //   days.add(
  //     DateFormat('E', Localizations.localeOf(context).languageCode)
  //         .format(endDate),
  //   );
  //   return days;
  // }

  /// convert time from 2023-12-30 06:37:00 to yyyy-MM-dd hh:mm a
  static String convertDateTimeDDMMYYY(String time) {
    // if contains 0000-00-00 return not_spiffied
    if (time.contains('0000-00-00')) {
      return 'not_spiffied'.tr();
    }

    // Parse time strings
    final DateTime parseDate = DateTime.parse(time).toLocal();

    String formattedDate = '';
    try {
      // Format time in 12-hour format with AM/PM using English numbers and Arabic words for AM/PM
      formattedDate = DateFormat('yyyy-MM-dd   hh:mm a', 'en_US')
          .format(parseDate)
          .replaceAllMapped(RegExp(r'\b(AM|PM)\b'), (match) {
            return match.group(0) == 'AM' ? 'am'.tr() : 'pm'.tr();
          });
    } catch (e) {
      return 'not_spiffied'.tr();
    }

    return formattedDate;
  }

  static Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Unique ID for Android devices
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // Unique ID for iOS devices
    }
    return null;
  }

  /// open call
  static Future<void> openCallFun(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    await urlLauncherFun(url);
  }

  /// payment status color
  static Color paymentStatusColor(String status) {
    switch (status) {
      case 'active':
      case 'in_progress':
      case 'finished':
        return AppColors.cSuccess;

      case 'waiting_vendor_offers':
      case 'offer_selected_waiting_vendor':
      case 'waiting_vendor_accept':
      case 'vendor_accepted':
      case 'advance_payment_paid':
      case 'delivery_confirmed':
      case 'cancelled':
      case 'vendor_rejected':
      case 'completed_by_vendor':
      case 'waiting_advance_payment':
      case 'waiting_final_payment':
        return AppColors.cError;

      default:
        return AppColors.cAlert;
    }
  }

  /// subscribe to topic
  static Future<void> subscribeToTopic() async {
    String topicName = 'topic_name';
    final lanCode = NavigatorKey.context.locale.languageCode;
    switch (lanCode) {
      case 'ar':
        topicName = 'client_topic_ar';
        break;
      case 'en':
        topicName = 'client_topic_en';
        break;
      default:
        topicName = 'client_topic_ar';
        break;
    }

    printFullText('topicName: $topicName');

    await FirebaseMessaging.instance.subscribeToTopic(topicName);
  }
}
