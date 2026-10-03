import 'package:careerverseapp/models/career.dart';
import 'package:careerverseapp/models/career_pack.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every English string of [career] that is shown translated in the app.
Set<String> careerStrings(Career career) {
  final strings = <String>{...career.tags};
  career.translate((s) {
    strings.add(s);
    return s;
  });
  for (final lab in career.labs) {
    strings.add(lab.level);
    strings.addAll(lab.skills);
  }
  return strings;
}

/// Checks that a career pack is complete and consistent.
void checkCareerPack(CareerPack pack) {
  final career = pack.career;

  test('${career.id}: career structure', () {
    expect(career.labs, hasLength(3));
    expect(career.labs.map((lab) => lab.level), [
      'Beginner',
      'Intermediate',
      'Advanced',
    ]);
    for (var i = 0; i < career.labs.length; i++) {
      final lab = career.labs[i];
      expect(lab.id, '${career.id}-${i + 1}');
      expect(lab.questions.length, inInclusiveRange(4, 5), reason: lab.id);
      for (final q in lab.questions) {
        expect(q.options, hasLength(4), reason: q.prompt);
        expect(q.correct, isNotEmpty, reason: q.prompt);
        expect(q.correct.every((i) => i >= 0 && i < 4), isTrue);
        expect(
          q.isMultiple,
          q.prompt.contains('(select ${q.correct.length})'),
          reason: 'multi-answer prompts end with "(select N)": ${q.prompt}',
        );
      }
    }
    expect(pack.interests, isNotEmpty);
  });

  test('${career.id}: content translated in French and Arabic', () {
    final strings = careerStrings(career);
    expect(strings.where((s) => !pack.contentFr.containsKey(s)), isEmpty);
    expect(strings.where((s) => !pack.contentAr.containsKey(s)), isEmpty);
    for (final s in strings) {
      expect(pack.contentFr[s], isNotEmpty);
      expect(pack.contentAr[s], isNotEmpty);
    }
  });

  test('${career.id}: one course per lab, same structure in 3 languages', () {
    for (final lab in career.labs) {
      final en = pack.coursesEn[lab.id];
      expect(en, isNotNull, reason: lab.id);
      expect(en!.labId, lab.id);
      expect(en.sections, hasLength(3), reason: lab.id);
      expect(en.takeaways, hasLength(3), reason: lab.id);
      for (final translated in [
        pack.coursesFr[lab.id],
        pack.coursesAr[lab.id],
      ]) {
        expect(translated, isNotNull, reason: lab.id);
        expect(translated!.labId, lab.id);
        expect(translated.intro, isNotEmpty);
        expect(translated.sections.length, en.sections.length);
        expect(translated.takeaways.length, en.takeaways.length);
        for (var i = 0; i < en.sections.length; i++) {
          expect(
            translated.sections[i].points.length,
            en.sections[i].points.length,
            reason: '${lab.id} section $i',
          );
        }
      }
      expect(pack.courseExamples[lab.id], hasLength(en.sections.length));
    }
  });
}
