import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nakha/core/utils/app_const.dart';
import 'package:nakha/features/auth/data/models/user_model.dart';

class MainSecureStorage {
  static AndroidOptions _getAndroidOptions() => AndroidOptions.defaultOptions;

  static const iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );

  // Instance of Flutter Secure Storage
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
    iOptions: iosOptions,
  );

  /// put data in secure storage ====>>>
  Future<void> putValue(String key, dynamic value) async {
    await _secureStorage.write(
      key: key,
      value: jsonEncode(value),
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
  }

  /// get data from secure storage ====>>>
  Future<dynamic> getValue(String key) async {
    final String? value = await _secureStorage.read(
      key: key,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
    return value != null ? jsonDecode(value) : null;
  }

  /// user id ====>>>
  Future<int> getUserId() async {
    final String? userId = await _secureStorage.read(
      key: AppConst.userIdBox,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
    return AppConst.userId = userId != null ? int.parse(userId) : 0;
  }

  Future<void> saveUserId(int userId) async {
    AppConst.userId = userId;
    await _secureStorage.write(
      key: AppConst.userIdBox,
      value: userId.toString(),
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
  }

  Future<void> deleteUserId() async {
    await _secureStorage.delete(
      key: AppConst.userIdBox,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
  }

  /// token ====>>>
  Future<String?> getToken() async {
    return _secureStorage.read(
      key: AppConst.tokenBox,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(
      key: AppConst.tokenBox,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(
      key: AppConst.tokenBox,
      value: token,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
  }

  /// get isDark ====>>>
  Future<bool> getIsDark() async {
    final String? isDark = await _secureStorage.read(
      key: AppConst.isDarkBox,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
    return isDark == 'true';
  }

  /// check if intro is seen ====>>>
  Future<bool> isOnboardingFinished() async {
    final String? introFinish = await _secureStorage.read(
      key: AppConst.introFinishBox,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
    return introFinish == 'true';
  }

  /// check if user is logged in ====>>>
  Future<bool> getIsLoggedIn() async {
    final String? token = await _secureStorage.read(
      key: AppConst.tokenBox,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
    return AppConst.isLogin = token != null;
  }

  /// is verified ====>>>
  Future<void> putIsVerified(bool value) async {
    await _secureStorage.write(
      key: AppConst.isVerifiedBox,
      value: value.toString(),
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
  }

  Future<bool> getIsVerified() async {
    final String? isVerified = await _secureStorage.read(
      key: AppConst.isVerifiedBox,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
    return isVerified == null || isVerified == 'true';
  }

  /// is app updated ====>>>
  Future<void> putIsAppUpdated(bool value) async {
    await _secureStorage.write(
      key: AppConst.isAppUpdated,
      value: value.toString(),
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
  }

  Future<bool> getIsAppUpdated() async {
    final String? isAppUpdated = await _secureStorage.read(
      key: AppConst.isAppUpdated,
      aOptions: _getAndroidOptions(),
      iOptions: iosOptions,
    );
    return isAppUpdated == null || isAppUpdated == 'true';
  }

  /// login ====>>>
  Future<void> login(UserModel user) async {
    await Future.wait([
      saveToken(user.accessToken),
      saveUserId(user.id),
      // putIsVerified(user.isProfileCompleted),
      saveUserData(user),
    ]);
    await getIsLoggedIn();
  }

  /// user data ====>>>
  Future<void> saveUserData(UserModel user) async {
    AppConst.user = user;
    await putValue(AppConst.userBox, user.toJson());
  }

  Future<UserModel?> getUserData() async {
    final dynamic user = await getValue(AppConst.userBox);
    AppConst.user = user != null ? UserModel.fromJson(user) : null;
    return user != null ? UserModel.fromJson(user) : null;
  }

  /// logout ====>>>
  Future<void> logout() async {
    AppConst.user = null;
    AppConst.userId = 0;
    debugPrint('Logout: Deleting secure storage data');
    AppConst.isLogin = false;
    await Future.wait([
      _secureStorage.delete(
        key: AppConst.isLoggedInBox,
        aOptions: _getAndroidOptions(),
        iOptions: iosOptions,
      ),
      _secureStorage.delete(
        key: AppConst.currencyBox,
        aOptions: _getAndroidOptions(),
        iOptions: iosOptions,
      ),
      _secureStorage.delete(
        key: AppConst.isVerifiedBox,
        aOptions: _getAndroidOptions(),
        iOptions: iosOptions,
      ),
      _secureStorage.delete(
        key: AppConst.userBox,
        aOptions: _getAndroidOptions(),
        iOptions: iosOptions,
      ),
      deleteToken(),
      deleteUserId(),
      getUserData(),
      getIsLoggedIn(),
      FirebaseMessaging.instance.deleteToken(),
    ]);
  }
}
