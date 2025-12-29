import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:nakha/core/utils/app_const.dart';

class Validators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_cannot_be_empty'.tr();
    } else if (value.length < 6) {
      return 'password_must_be_at_least_6_characters'.tr();
    }
    return null;
  }

  static String? validatePasswordConfirmation(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'password_cannot_be_empty'.tr();
    } else if (value != password) {
      return 'passwords_do_not_match'.tr();
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'phone_cannot_be_empty'.tr();
    } else if (value.length != 10) {
      return 'phone_must_be_10_digits'.tr();
    } // must start with 05
    else if (!RegExp(r'^05[0-9]{8}$').hasMatch(value) && !kDebugMode) {
      // return 'phone_must_start_with_05'.tr();
      return 'your_phone_number_is_not_valid'.tr();
    }
    return null;
  }

  static String? requiredField(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'field_cannot_be_empty'.tr();
    }
    return null;
  }

  // name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'name_cannot_be_empty'.tr();
    } else if (RegExp(r'[0-9!@#<>?":_`~;[\]\\|=+)(*&^%0-9]').hasMatch(value)) {
      return 'name_can_only_contain_letters'.tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_cannot_be_empty'.tr();
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'email_is_not_valid'.tr();
    }
    return null;
  }

  // username validation
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'username_cannot_be_empty'.tr();
    } else if (value.length < 3) {
      return 'username_must_be_at_least_3_characters'.tr();
    } else if (!RegExp(r'^[a-zA-Z0-9_]*$').hasMatch(value)) {
      return 'username_can_only_contain_letters_numbers_and_underscores'.tr();
    } else if (value.length > 20) {
      return 'username_must_be_at_most_20_characters'.tr();
    }
    return null;
  }

  // email or username validation
  static String? validateEmailOrUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_or_username_cannot_be_empty'.tr();
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) &&
        !RegExp(r'^[a-zA-Z0-9_]*$').hasMatch(value)) {
      return 'email_or_username_is_not_valid'.tr();
    }
    return null;
  }

  /// validate the description
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'description_cannot_be_empty'.tr();
    }
    // can't be less than 10 characters without spaces
    if (value.replaceAll(' ', '').length < 10) {
      return 'description_must_be_at_least_10_characters'.tr();
    }
    return null;
  }

  /// validateBirthDate
  static String? validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'birth_date_cannot_be_empty'.tr();
    }
    // birth date must be in the past
    final DateTime birthDate = DateTime.parse(value);
    if (birthDate.isAfter(DateTime.now())) {
      return 'birth_date_must_be_in_the_past'.tr();
    }
    // birth date must be at least 17 years ago
    final DateTime minDate = DateTime.now().subtract(AppConst.minimumAge);
    if (birthDate.isAfter(minDate)) {
      return 'you_must_be_at_least_17_years_old'.tr();
    }
    return null;
  }

  /// validate civil number
  static String? validateCivilNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'civil_number_cannot_be_empty'.tr();
    } else if (value.length != 10) {
      return 'civil_number_must_be_10_digits'.tr();
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'civil_number_must_be_numeric'.tr();
    }
    return null;
  }

  /// validateGender
  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'gender_cannot_be_empty'.tr();
    } else if (value != 'male' && value != 'female') {
      return 'gender_must_be_male_or_female'.tr();
    }
    return null;
  }

  /// validate price
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'price_cannot_be_empty'.tr();
    }
    return null;
  }
}
