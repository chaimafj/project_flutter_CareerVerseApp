import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_options.dart';
import '../providers/app_state.dart';

/// Called by FCM when a message arrives while the app is in the background
/// or terminated. Notification messages are displayed by the system; their
/// data is handled when the user taps them.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

/// Push notifications (Firebase Cloud Messaging) and system notifications
/// shown by the app itself (e.g. "Your recommendations are ready!" when a
/// lab is finished). Tapping a notification opens the related screen.
///
/// Supported data keys: `resultId` (opens the results), `route` (one of
/// [routes]) and `notificationId` (marked as read).
class NotificationService extends ChangeNotifier {
  NotificationService(
    this._prefs, {
    required this.navigatorKey,
    this.firebaseEnabled = false,
    bool? supported,
  }) : supported =
           supported ?? (!kIsWeb && (Platform.isAndroid || Platform.isIOS));

  static const channelId = 'careerverse_alerts';
  static const topic = 'careerverse';
  static const routes = {
    '/results',
    '/notifications',
    '/recommendations',
    '/learning-path',
    '/settings',
  };
  static const _enabledKey = 'cv_push_enabled';

  final SharedPreferences _prefs;
  final GlobalKey<NavigatorState> navigatorKey;
  final bool firebaseEnabled;

  /// System notifications exist only on Android and iOS.
  final bool supported;

  final _local = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  bool get enabled => _prefs.getBool(_enabledKey) ?? true;

  Future<void> initialize() async {
    if (!supported) return;
    try {
      await _local.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          ),
        ),
        onDidReceiveNotificationResponse: (response) =>
            openPayload(response.payload),
      );
      await _local
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              channelId,
              'CareerVerse',
              description: 'Lab results and recommendations',
              importance: Importance.high,
            ),
          );
      _ready = true;
      final launch = await _local.getNotificationAppLaunchDetails();
      if (launch?.didNotificationLaunchApp ?? false) {
        openPayload(launch!.notificationResponse?.payload);
      }
      if (firebaseEnabled) await _initMessaging();
      if (enabled) await _requestPermission();
    } catch (e) {
      debugPrint('Notifications init failed: $e');
    }
  }

  Future<void> _initMessaging() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((m) => openData(m.data));
    final initial = await messaging.getInitialMessage();
    if (initial != null) openData(initial.data);
    messaging.onTokenRefresh.listen(_saveToken);
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) return;
      try {
        _saveToken(await messaging.getToken());
      } catch (e) {
        // iOS needs an APNs key in the Firebase project to issue a token.
        debugPrint('FCM token unavailable: $e');
      }
    });
    if (enabled) unawaited(_subscribe(true));
  }

  Future<void> _requestPermission() async {
    if (firebaseEnabled) {
      await FirebaseMessaging.instance.requestPermission();
      return;
    }
    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    await _local
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> _subscribe(bool subscribe) async {
    if (!firebaseEnabled) return;
    try {
      final messaging = FirebaseMessaging.instance;
      subscribe
          ? await messaging.subscribeToTopic(topic)
          : await messaging.unsubscribeFromTopic(topic);
    } catch (e) {
      debugPrint('FCM topic update failed: $e');
    }
  }

  void _saveToken(String? token) {
    final user = FirebaseAuth.instance.currentUser;
    if (token == null || user == null) return;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
          'fcmToken': token,
          'platform': Platform.operatingSystem,
          'pushEnabled': enabled,
        }, SetOptions(merge: true))
        .catchError((Object e) => debugPrint('FCM token save failed: $e'));
  }

  Future<void> setEnabled(bool value) async {
    await _prefs.setBool(_enabledKey, value);
    notifyListeners();
    if (!supported) return;
    if (value) await _requestPermission();
    await _subscribe(value);
    if (firebaseEnabled) {
      _saveToken(
        await FirebaseMessaging.instance.getToken().catchError((_) => null),
      );
    }
  }

  /// Android does not display FCM notifications while the app is in the
  /// foreground, so they are shown as local notifications. iOS displays them
  /// itself thanks to the presentation options.
  void _onForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null || !Platform.isAndroid) return;
    unawaited(
      _show(
        title: notification.title ?? 'CareerVerse',
        body: notification.body ?? '',
        data: message.data,
      ),
    );
  }

  /// System notification shown when a lab is finished.
  Future<void> showLabResult({
    required String title,
    required String body,
    required String resultId,
    String? notificationId,
  }) => _show(
    title: title,
    body: body,
    data: {'resultId': resultId, 'notificationId': ?notificationId},
  );

  Future<void> _show({
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    if (!supported || !_ready || !enabled) return;
    try {
      await _local.show(
        id: DateTime.now().millisecondsSinceEpoch.remainder(1 << 31),
        title: title,
        body: body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            'CareerVerse',
            channelDescription: 'Lab results and recommendations',
            importance: Importance.high,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(body),
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(data),
      );
    } catch (e) {
      debugPrint('Notification failed: $e');
    }
  }

  void openPayload(String? payload) {
    if (payload == null || payload.isEmpty) return;
    try {
      openData(Map<String, dynamic>.from(jsonDecode(payload) as Map));
    } catch (_) {}
  }

  /// Opens the screen described by a notification's data.
  void openData(Map<String, dynamic> data, [int attempt = 0]) {
    final navigator = navigatorKey.currentState;
    final context = navigatorKey.currentContext;
    if (navigator == null || context == null) {
      // Cold start: wait until the app is built.
      if (attempt < 40) {
        Future.delayed(
          const Duration(milliseconds: 250),
          () => openData(data, attempt + 1),
        );
      }
      return;
    }
    final state = context.read<AppState>();
    if (!state.isLoggedIn) return;
    final notificationId = data['notificationId'];
    if (notificationId is String) unawaited(state.markRead(notificationId));
    final resultId = data['resultId'];
    var route = data['route'];
    if (route is! String || !routes.contains(route)) {
      route = resultId is String ? '/results' : '/notifications';
    }
    if (route == '/results' && resultId is! String) route = '/notifications';
    navigator.pushNamed(
      route,
      arguments: route == '/results' ? resultId : null,
    );
  }
}
