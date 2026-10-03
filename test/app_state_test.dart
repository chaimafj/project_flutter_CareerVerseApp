import 'package:careerverseapp/data/catalog.dart';
import 'package:careerverseapp/models/lab_result.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Set<int>> perfectAnswers(String labId) =>
    findLab(labId)!.$2.questions.map((q) => q.correct).toList();

void main() {
  late SharedPreferences prefs;
  late LocalStore store;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    store = MemoryLocalStore();
  });

  test('catalog labs are well formed', () {
    for (final career in careers) {
      expect(career.labs, hasLength(3));
      for (final lab in career.labs) {
        expect(lab.questions, isNotEmpty);
        for (final q in lab.questions) {
          expect(
            q.correct.every((i) => i >= 0 && i < q.options.length),
            isTrue,
          );
        }
      }
    }
  });

  test('question correctness requires the exact set of answers', () {
    final question = findLab('cloud-1')!.$2.questions.first;
    expect(question.isMultiple, isTrue);
    expect(question.isCorrect({0, 1}), isTrue);
    expect(question.isCorrect({0}), isFalse);
    expect(question.isCorrect({0, 1, 2}), isFalse);
  });

  test('lab result score combines accuracy and speed', () {
    LabResult result(int correct, int seconds) => LabResult(
      id: 'r',
      careerId: 'cloud',
      labId: 'cloud-1',
      correct: correct,
      total: 4,
      durationSeconds: seconds,
      expectedSeconds: 240,
      skillScores: const {},
      completedAt: DateTime(2025),
    );
    expect(result(4, 100).overall, 100);
    expect(result(2, 100).overall, 60);
    expect(result(4, 480).timeScore, 40);
    expect(result(4, 480).overall, 88);
  });

  test('register, logout, login and wrong password', () async {
    final state = AppState(prefs, store);
    expect(
      await state.register(
        name: 'Chaima Fejjari',
        email: 'Chaima@Example.com',
        password: 'secret123',
      ),
      isNull,
    );
    expect(state.isLoggedIn, isTrue);
    expect(state.profile.firstName, 'Chaima');
    expect(
      await state.register(
        name: 'Other',
        email: 'chaima@example.com',
        password: 'secret123',
      ),
      isNotNull,
    );

    await state.logout();
    expect(state.isLoggedIn, isFalse);
    expect(await state.login('chaima@example.com', 'bad-pass'), isNotNull);
    expect(await state.login('chaima@example.com', 'secret123'), isNull);
    expect(
      AppState(prefs, store).isLoggedIn,
      isTrue,
      reason: 'session persisted',
    );
  });

  test('results drive progress, recommendations and next lab', () async {
    final state = AppState(prefs, store);
    await state.register(name: 'Test', email: 't@t.com', password: '123456');
    final (cyber, cyberLab) = findLab('cyber-1')!;

    final result = await state.recordResult(
      career: cyber,
      lab: cyberLab,
      answers: perfectAnswers('cyber-1'),
      durationSeconds: 60,
    );
    expect(result.overall, 100);
    expect(state.isCompleted('cyber-1'), isTrue);
    expect(state.completedLabs(cyber), 1);
    expect(state.matches.first.career.id, 'cyber');
    expect(state.nextLab('cyber-1')!.$2.id, 'cyber-2');
    expect(state.unreadCount, 2);
    expect(state.notifications.first.resultId, result.id);
    expect(state.recommendationHistory, hasLength(1));

    // Data survives a restart.
    final reloaded = AppState(prefs, store);
    expect(reloaded.resultById(result.id)?.overall, 100);

    await state.resetProgress();
    expect(state.results, isEmpty);
  });

  test('profile updates are persisted and affect matches', () async {
    final state = AppState(prefs, store);
    await state.register(name: 'Test', email: 'p@t.com', password: '123456');
    await state.updateProfile(
      state.profile.copyWith(
        university: 'ESPRIT',
        interests: ['Security', 'Networks', 'Problem solving', 'Data'],
      ),
    );
    expect(AppState(prefs, store).profile.university, 'ESPRIT');
    expect(state.matches.first.career.id, 'cyber');
  });
}
