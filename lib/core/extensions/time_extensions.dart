import 'package:easy_localization/easy_localization.dart';
import 'package:nakha/config/navigator_key/navigator_key.dart';
import 'package:nakha/core/extensions/shared_extensions.dart';
import 'package:nakha/core/utils/most_used_functions.dart';

extension TimeExtenstions on String {
  /// Convert string 2024-05-27 02:50:39 to 23-04-2024 , الساعة: 3:00 م
  String get convertToHoursDate {
    try {
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');
      final DateTime dateTime = formatter.parse(this);
      final String date = DateFormat('dd-MM-yyyy', 'en_US').format(dateTime);
      final String time = DateFormat('hh:mm a', 'en_US')
          .format(dateTime)
          .toLowerCase()
          .replaceAll('am', 'morning'.tr())
          .replaceAll('pm', 'evening'.tr());
      return '$date , ${'time'.tr()}: $time';
    } catch (e) {
      MostUsedFunctions.printFullText('convertToHoursDate error: $e');
      return this;
    }
  }

  /// to date time
  DateTime get toDateTime {
    try {
      /// remove (EEST) from the end of the string time 02:50 (EEST)
      /// add today date to the time 2024-05-27 02:50:00
      final string = takeFirstFiveCharacters;
      final now = DateTime.now();
      return DateTime(
        now.year,
        now.month,
        now.day,
        int.tryParse(string.split(':')[0])!,
        int.tryParse(string.split(':')[1])!,
      );
    } catch (e) {
      MostUsedFunctions.printFullText('toDateTime error: $e');
      return DateTime.now();
    }
  }

  /// to date time start of next day
  DateTime get toDateTimeNextDay {
    try {
      /// remove (EEST) from the end of the string time 02:50 (EEST)
      /// add today date to the time 2024-05-27 02:50:00
      final string = takeFirstFiveCharacters;
      final now = DateTime.now();
      return DateTime(
        now.year,
        now.month,
        now.day + 1,
        int.tryParse(string.split(':')[0])!,
        int.tryParse(string.split(':')[1])!,
      );
    } catch (e) {
      MostUsedFunctions.printFullText('toDateTimeNextDay error: $e');
      return DateTime.now();
    }
  }

  String get takeFirstFiveCharacters {
    try {
      return substring(0, 5);
    } catch (e) {
      MostUsedFunctions.printFullText('takeFirstFiveCharacters error: $e');
      return this;
    }
  }

  /// convert 09:00:00 to 09:00 AM
  String get convertToTime {
    try {
      final DateFormat formatter = DateFormat('HH:mm', 'en_US');
      final DateTime dateTime = formatter.parse(this);
      return DateFormat(
        'hh:mm a',
        NavigatorKey.context.locale.languageCode,
      ).format(dateTime).toEnglishNumbers;
    } catch (e) {
      MostUsedFunctions.printFullText('convertToTime error: $e');
      return this;
    }
  }

  /// convert 2025-04-26 to days
  String get convertToDays {
    try {
      final DateTime dateTime = DateTime.parse(this);
      return DateFormat(
        'EEEE',
        NavigatorKey.context.locale.languageCode,
      ).format(dateTime).toEnglishNumbers;
    } catch (e) {
      MostUsedFunctions.printFullText('convertToDays error: $e');
      return this;
    }
  }

  /// isNowPM
  bool get isNowPM {
    try {
      final DateTime now = DateTime.now();
      return now.hour >= 12;
    } catch (e) {
      MostUsedFunctions.printFullText('isNowPM error: $e');
      return false;
    }
  }

  /// convert 2025-12-28T10:50:36.000000Z to since time
  String get convertToSinceTime {
    try {
      final DateTime dateTime = DateTime.parse(this).toLocal();
      final Duration difference = DateTime.now().difference(dateTime);
      if (difference.inSeconds < 60) {
        return 'just_now'.tr();
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} ${'minutes'.tr()}';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} ${'hours'.tr()}';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} ${'days'.tr()}';
      } else {
        return DateFormat(
          'dd-MM-yyyy hh:mm a',
          NavigatorKey.context.locale.languageCode,
        ).format(dateTime).toEnglishNumbers;
      }
    } catch (e) {
      MostUsedFunctions.printFullText('convertToSinceTime error: $e');
      return this;
    }
  }
}
