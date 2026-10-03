import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'providers/app_state.dart';
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'services/ad_service.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'services/local_store.dart';
import 'services/notification_service.dart';
import 'services/payment_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseReady = await _initFirebase();
  final prefs = await SharedPreferences.getInstance();
  final documents = await getApplicationDocumentsDirectory();
  final store = await HiveLocalStore.open(
    directory: '${documents.path}/careerverse_db',
  );
  final ads = AdService();
  // Not awaited: ads and notifications must never delay the app start.
  ads.initialize();
  final notifications = NotificationService(
    prefs,
    navigatorKey: appNavigatorKey,
    firebaseEnabled: firebaseReady,
  );
  notifications.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: ads),
        Provider<PaymentService>.value(value: StripePaymentService()),
        ChangeNotifierProvider.value(value: notifications),
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        ChangeNotifierProvider(create: (_) => LocaleProvider(prefs)),
        ChangeNotifierProvider(
          create: (_) => firebaseReady
              ? AppState(
                  prefs,
                  store,
                  auth: FirebaseAuthService(
                    iosClientId: DefaultFirebaseOptions.ios.iosClientId,
                  ),
                  cloud: FirestoreService(),
                )
              : AppState(prefs, store),
        ),
      ],
      child: const CareerVerseApp(),
    ),
  );
}

/// Firebase is configured for Android and iOS. On other platforms the app
/// falls back to device-only accounts.
Future<bool> _initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    return true;
  } catch (e) {
    debugPrint('Firebase unavailable, using local mode: $e');
    return false;
  }
}
