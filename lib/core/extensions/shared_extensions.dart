import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nakha/config/themes/colors.dart';
import 'package:nakha/core/utils/app_sizes.dart';

extension CurrentLanguage on BuildContext {
  bool get isArabic => locale == const Locale('ar', 'SA');

  bool get isEnglish => locale == const Locale('en', 'US');
}

extension ConvertDinarToIQD on String {
  /// convert string number to comma separated
  String get toCommaSeparated => replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );

  /// remove all commas from string
  String get removeCommas => replaceAll(',', '');

  /// convert number to english numbers
  String get toEnglishNumbers {
    return replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');
  }

  /// to title case
  String get toTitleCase {
    if (isEmpty) {
      return ''; // Handle null or empty strings.
    }
    return split(' ')
        .where((word) => word.isNotEmpty) // Ignore empty words
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  /// remove new line
  String get removeNewLine {
    return replaceAll('\n', '');
  }

  /// convert string date to 12:00 AM/PM
  String convertTo12HourFormat() {
    try {
      final DateTime dateTime = DateTime.parse(this).toLocal();
      return DateFormat('hh:mm a', 'en_US')
          .format(dateTime)
          .toUpperCase()
          .replaceAll('AM', 'am'.tr())
          .replaceAll('PM', 'pm'.tr())
          .toEnglishNumbers;
    } catch (e) {
      return 'not_specified'.tr();
    }
  }

  /// make string have max length n and add ... at the end
  String maxLength(int n) {
    return (length <= n) ? this : '${substring(0, n)}...';
  }

  /// get n of word from start
  String getFirstNWords(int n) {
    // if n > number of words return the whole string
    if (split(' ').length <= n) return this;
    return split(' ').take(n).join(' ');
  }

  /// search in word so delete arabic letters like (ا, أ, إ, آ) and replace it with (ا)
  /// and (ى) with (ي) and (ؤ) with (و) and (ئ) with (ي) and (ة) with (ه)
  /// replace ُ, َ, ِ, ْ, ً, ٍ, ٌ, ـ etc with empty string
  /// in english convert all letters to lower case
  String get removeUnUsedLetters {
    return replaceAll(RegExp('[أإآ]'), 'ا')
        .replaceAll(RegExp('[ة]'), 'ه')
        .replaceAll(RegExp(r'[\u064B-\u065F\u0670\u06E0\u08F0\u08F3]'), '')
        .replaceAll(RegExp('ۡ'), '')
        .toLowerCase();
  }

  String get showTopSuccessToast {
    Fluttertoast.showToast(
      msg: this.tr(),
      backgroundColor: AppColors.toastColor,
      textColor: Colors.white,
      fontSize: AppFontSize.f12,
    );
    return this;
  }

  String get showTopErrorToast {
    Fluttertoast.showToast(
      msg: this.tr(),
      backgroundColor: AppColors.toastColor,
      textColor: Colors.white,
      fontSize: AppFontSize.f12,
    );
    return this;
  }

  String get showTopInfoToast {
    Fluttertoast.showToast(
      msg: this.tr(),
      backgroundColor: AppColors.toastColor,
      textColor: Colors.white,
      fontSize: AppFontSize.f12,
    );
    return this;
  }

  // isLink
  bool get isLink {
    const urlPattern = r'^(http|https):\/\/[^\s$.?#].[^\s]*$';
    final result = RegExp(urlPattern, caseSensitive: false).hasMatch(this);
    return result;
  }
}
