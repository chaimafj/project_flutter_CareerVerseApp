import 'dart:convert';
import 'dart:io';

import 'package:careerverseapp/data/catalog.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/services/ad_service.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('results are stored offline in Hive and survive a restart', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final dir = await Directory.systemTemp.createTemp('careerverse_hive');
    addTearDown(() => dir.delete(recursive: true));

    var store = await HiveLocalStore.open(directory: dir.path);
    final state = AppState(prefs, store);
    await state.register(name: 'Offline', email: 'o@o.com', password: '123456');
    final (career, lab) = findLab('cyber-1')!;
    await state.recordResult(
      career: career,
      lab: lab,
      answers: lab.questions.map((q) => q.correct).toList(),
      durationSeconds: 30,
    );
    await store.close();

    store = await HiveLocalStore.open(directory: dir.path);
    final reloaded = AppState(prefs, store);
    expect(reloaded.profile.name, 'Offline');
    expect(reloaded.results.single.labId, 'cyber-1');
    expect(reloaded.results.single.overall, 100);
    expect(reloaded.recommendationHistory, hasLength(1));
    expect(reloaded.notifications, hasLength(2));
    await store.close();
  });

  test('data saved by the previous version is migrated', () async {
    SharedPreferences.setMockInitialValues({
      'cv_session': 'old@user.com',
      'cv_user_old@user.com': jsonEncode({
        'profile': {
          'name': 'Old User',
          'email': 'old@user.com',
          'createdAt': DateTime(2025).toIso8601String(),
        },
        'results': [],
        'notifications': [],
        'history': [],
      }),
    });
    final prefs = await SharedPreferences.getInstance();
    final store = MemoryLocalStore();

    expect(AppState(prefs, store).profile.name, 'Old User');
    expect(prefs.getString('cv_user_old@user.com'), isNull);
    expect(AppState(prefs, store).profile.name, 'Old User');
  });

  test('Lottie animations are valid', () async {
    for (final name in ['success', 'retry']) {
      final bytes = await File('assets/lottie/$name.json').readAsBytes();
      final composition = await LottieComposition.fromBytes(bytes);
      expect(composition.layers, isNotEmpty, reason: name);
      expect(composition.duration, greaterThan(Duration.zero), reason: name);
    }
  });

  test('without a loaded interstitial the flow continues immediately', () {
    var done = false;
    AdService(enabled: false).showInterstitial(onDone: () => done = true);
    expect(done, isTrue);
  });
}
