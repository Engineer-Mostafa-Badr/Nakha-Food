// ignore_for_file: avoid_redundant_argument_values

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart'
    show GlobalKey, NavigatorState, debugPrint;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../firebase_notification_handler_plus.dart';
import 'constants.dart';
import 'image_downloader.dart';

/// Internal implementation class
@pragma('vm:entry-point')
class PushNotificationService {
  /// Internal [FirebaseMessaging] instance
  static final _fcm = FirebaseMessaging.instance;

  /// {@macro navigatorKey}
  static GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// [_navigatorKey] getter.
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// [_fcmToken] getter
  static String? get fcmToken => _fcmToken;

  /// {@macro fcmToken}
  static String? _fcmToken;

  /// {@macro enableLogs}
  static bool? _enableLogs;

  /// {@macro customSound}
  static String? _customSound;

  /// {@macro channelId}
  static String? _channelId;

  /// {@macro channelName}
  static String? _channelName;

  /// {@macro channelDescription}
  static String? _channelDescription;

  /// {@macro groupKey}
  static String? _groupKey;

  /// Called when token is refreshed.
  static Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;

  /// {@macro onTap}
  static void Function(
    GlobalKey<NavigatorState>,
    AppState,
    Map<String, dynamic> payload,
  )?
  _onTap;

  /// {@macro openedAppFromNotification}
  static bool _openedAppFromNotification = false;

  /// {@macro openedAppFromNotification}
  static bool get openedAppFromNotification => _openedAppFromNotification;

  /// {@macro notificationIdCallback}
  static int Function(RemoteMessage)? _notificationIdCallback;

  /// {@macro onOpenNotificationArrive}
  static late void Function(
    GlobalKey<NavigatorState> navigatorKey,
    Map<String, dynamic> payload,
  )?
  _onOpenNotificationArrive;

  /// Initialize the implementation class
  static Future<String?> initialize({
    String? vapidKey,
    bool enableLogs = Constants.enableLogs,
    void Function(
      GlobalKey<NavigatorState>,
      AppState,
      Map<String, dynamic> payload,
    )?
    onTap,
    GlobalKey<NavigatorState>? navigatorKey,
    String? customSound,
    required bool handleInitialMessage,
    required String channelId,
    required String channelName,
    required String channelDescription,
    required String? groupKey,
    int Function(RemoteMessage)? notificationIdCallback,
    required void Function(
      GlobalKey<NavigatorState> navigatorKey,
      Map<String, dynamic> payload,
    )?
    onOpenNotificationArrive,
  }) async {
    _onTap = onTap;
    _enableLogs = enableLogs;
    _customSound = customSound;
    _notificationIdCallback = notificationIdCallback;
    _onOpenNotificationArrive = onOpenNotificationArrive;

    _channelId = channelId;
    _channelName = channelName;
    _channelDescription = channelDescription;
    _groupKey = groupKey;

    if (navigatorKey != null) _navigatorKey = navigatorKey;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      await androidImplementation?.requestNotificationsPermission();
    }

    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    _fcmToken = await initializeFCMToken(vapidKey: vapidKey);

    if (handleInitialMessage) {
      final bgMessage = await _fcm.getInitialMessage();
      if (bgMessage != null) {
        _openedAppFromNotification = true;
        _onBackgroundMessage(bgMessage);
      }
    }

    /// Registering the listeners
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    return fcmToken;
  }

  static Future<String?> initializeFCMToken({
    String? vapidKey,
    bool log = true,
  }) async {
    _fcmToken ??= await _fcm.getToken(vapidKey: vapidKey);

    if (_enableLogs ?? log) debugPrint('FCM Token initialized: $_fcmToken');

    _fcm.onTokenRefresh.listen((token) {
      _fcmToken = token;
      if (_enableLogs ?? log) debugPrint('FCM Token updated: $_fcmToken');
    });

    return _fcmToken;
  }

  /// [_onMessage] callback for the notification
  static Future<void> _onMessage(RemoteMessage message) =>
      _notificationHandler(message, appState: AppState.open);

  /// [_onBackgroundMessage] callback for the notification
  @pragma('vm:entry-point')
  static Future<void> _onBackgroundMessage(RemoteMessage message) =>
      _notificationHandler(message, appState: AppState.closed);

  /// [_onMessageOpenedApp] callback for the notification
  static Future<void> _onMessageOpenedApp(RemoteMessage message) =>
      _notificationHandler(message, appState: AppState.background);

  /// [_initializeLocalNotifications] function to initialize the local
  /// notifications to show a notification when the app is in foreground.
  static Future<FlutterLocalNotificationsPlugin>
  _initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@drawable/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;

        if (_onTap != null) {
          _onTap?.call(
            navigatorKey,
            AppState.open,
            payload == null ? {} : jsonDecode(payload),
          );
        }
      },
    );

    return flutterLocalNotificationsPlugin;
  }

  /// [_notificationHandler] implementation
  static Future<void> _notificationHandler(
    RemoteMessage message, {
    required AppState appState,
  }) async {
    _enableLogs ??= Constants.enableLogs;
    if (_enableLogs!) {
      debugPrint('''
     
    ******************************************************* 
                      NEW NOTIFICATION
    *******************************************************
    Title: ${message.notification?.title}
    Body: ${message.notification?.body}
    Payload: ${message.data}
    *******************************************************
    
''');
    }

    _channelId ??= Constants.channelId;
    _channelName ??= Constants.channelName;
    _channelDescription ??= Constants.channelDescription;

    StyleInformation? styleInformation;

    String? imageUrl;
    if (message.notification?.android?.imageUrl != null) {
      imageUrl = message.notification?.android?.imageUrl;
    } else if (message.notification?.apple?.imageUrl != null) {
      imageUrl = message.notification?.apple?.imageUrl;
    }

    if (appState == AppState.open && imageUrl != null) {
      final notificationImage = await ImageDownloaderService.downloadImage(
        url: imageUrl,
        fileName: 'notificationImage',
      );

      if (notificationImage != null) {
        styleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(notificationImage),
          largeIcon: FilePathAndroidBitmap(notificationImage),
          hideExpandedLargeIcon: true,
        );
      }
    }

    final androidSpecifics = AndroidNotificationDetails(
      message.notification?.android?.channelId ?? _channelId!,
      _channelName!,
      channelDescription: _channelDescription,
      importance: Importance.max,
      styleInformation: styleInformation,
      priority: Priority.high,
      groupKey: _groupKey,
      sound: _customSound == null
          ? null
          : RawResourceAndroidNotificationSound(_customSound),
      playSound: true,
      enableLights: true,
      enableVibration: true,
    );

    final iOsSpecifics = DarwinNotificationDetails(sound: _customSound);

    final notificationPlatformSpecifics = NotificationDetails(
      android: androidSpecifics,
      iOS: iOsSpecifics,
    );

    final localNotifications = await _initializeLocalNotifications();

    _notificationIdCallback ??= (_) => DateTime.now().hashCode;

    if (appState == AppState.open) {
      await localNotifications.show(
        _notificationIdCallback!(message),
        message.notification?.title,
        message.notification?.body,
        notificationPlatformSpecifics,
        payload: jsonEncode(message.data),
      );

      if (_onOpenNotificationArrive != null) {
        _onOpenNotificationArrive?.call(_navigatorKey, message.data);
      }
    }
    /// if AppState is open, do not handle onTap here because it will trigger as soon as
    /// notification arrives, instead handle in initialize method in onSelectNotification callback.
    else if (_onTap != null) {
      _onTap?.call(_navigatorKey, appState, message.data);
    }
  }

  /// show notification with title and body
  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    final androidSpecifics = AndroidNotificationDetails(
      _channelId!,
      _channelName!,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: _groupKey,
      sound: _customSound == null
          ? null
          : RawResourceAndroidNotificationSound(_customSound),
      playSound: true,
      enableLights: true,
      enableVibration: true,
      icon: '@drawable/ic_launcher',
    );

    final iOsSpecifics = DarwinNotificationDetails(sound: _customSound);

    final notificationPlatformSpecifics = NotificationDetails(
      android: androidSpecifics,
      iOS: iOsSpecifics,
    );

    final localNotifications = await _initializeLocalNotifications();

    await localNotifications.show(
      title.hashCode,
      title,
      body,
      notificationPlatformSpecifics,
      payload: payload,
    );
  }

  /// schedule notification with title and body
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    String? payload,
  }) async {
    final androidSpecifics = AndroidNotificationDetails(
      _channelId!,
      _channelName!,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: _groupKey,
      sound: _customSound == null
          ? null
          : RawResourceAndroidNotificationSound(_customSound),
      playSound: true,
      enableLights: true,
      enableVibration: true,
      icon: '@drawable/ic_launcher',
    );

    final iOsSpecifics = DarwinNotificationDetails(sound: _customSound);

    final notificationPlatformSpecifics = NotificationDetails(
      android: androidSpecifics,
      iOS: iOsSpecifics,
    );

    final localNotifications = await _initializeLocalNotifications();

    await localNotifications.zonedSchedule(
      title.hashCode,
      title,
      body,
      scheduledDate,
      notificationPlatformSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  /// cancel all scheduled notifications and other notifications
  static Future<void> cancelAllNotifications() async {
    final localNotifications = await _initializeLocalNotifications();
    await localNotifications.cancelAll();
  }
}
