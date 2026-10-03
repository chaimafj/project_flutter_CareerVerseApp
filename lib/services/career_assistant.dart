import '../data/catalog.dart';
import '../l10n/l10n.dart';
import '../models/career.dart';
import '../models/chat_message.dart';
import '../providers/app_state.dart';

/// An answer of the assistant with optional buttons.
class AssistantAnswer {
  const AssistantAnswer(this.text, [this.actions = const []]);

  final String text;
  final List<ChatAction> actions;
}

enum _Intent {
  greeting,
  thanks,
  recommend,
  progress,
  next,
  premium,
  list,
  salary,
  skills,
  education,
  outlook,
}

/// Words (lower case, accents removed) that reveal what the user asks for,
/// in English, French and Arabic. A trailing `*` matches any word ending.
const _intentWords = <_Intent, List<String>>{
  _Intent.greeting: [
    'hello', 'hi', 'hey', 'bonjour', 'salut', 'bonsoir', 'coucou', //
    'مرحبا', 'السلام', 'اهلا', 'أهلا',
  ],
  _Intent.thanks: ['merci', 'thanks', 'thank you', 'thx', 'شكرا'],
  _Intent.recommend: [
    'recommand*', 'recommend*', 'conseil*', 'advice', 'advise', 'suggest*',
    'quel metier', 'quelle carriere', 'which career', 'what career',
    'which job', 'what job', 'convient', 'correspond*', 'suits me', 'suit me',
    'fait pour moi', 'match*', 'orient*', 'choisir', 'choose', //
    'ناسب', 'انصح', 'أنصح', 'توصي', 'اقترح', 'توجيه',
  ],
  _Intent.progress: [
    'progress*', 'progres', 'progression', 'score*', 'resultat*', 'result*',
    'how am i', 'how i am doing', 'ou j en suis', 'ou en suis', 'bilan',
    'stats', //
    'تقدم', 'نتائج', 'نتيجة', 'مستواي',
  ],
  _Intent.next: [
    'next', 'suivant*', 'prochain*', 'ensuite', 'commencer', 'start', 'begin',
    'what should i do', 'what to do', 'que faire', 'quoi faire', 'que dois',
    'par ou', 'continuer', 'continue', //
    'التالي', 'ابدأ', 'أبدأ', 'ماذا افعل', 'ماذا أفعل', 'بعد ذلك',
  ],
  _Intent.premium: [
    'premium', 'abonnement*', 'subscri*', 'stripe', 'paiement', 'payment',
    'prix', 'price', 'debloquer', 'unlock*', //
    'بريميوم', 'اشتراك', 'دفع',
  ],
  _Intent.list: [
    'liste', 'list', 'quels metiers', 'which careers', 'what careers',
    'all careers', 'tous les metiers', 'metiers disponibles',
    'careers available', 'available careers', 'combien de metiers', //
    'المهن', 'الوظائف', 'قائمة',
  ],
  _Intent.salary: [
    'salaire*', 'salary', 'salaries', 'gagn*', 'earn*', 'pay', 'paid', 'paye',
    'remuneration', 'combien', 'how much', 'argent', 'money', //
    'راتب', 'اجر', 'أجر', 'دخل',
  ],
  _Intent.skills: [
    'competence*', 'skill*', 'outil*', 'tool*', 'technolog*', 'langage*',
    'language*', 'apprend*', 'learn*', 'savoir', 'stack', //
    'مهار', 'ادوات', 'أدوات', 'تعلم',
  ],
  _Intent.education: [
    'etude*', 'diplome*', 'study', 'studies', 'degree*', 'education',
    'formation*', 'ecole*', 'school*', 'universit*', 'bac', //
    'دراس', 'شهاد', 'تكوين', 'جامع',
  ],
  _Intent.outlook: [
    'avenir', 'futur*', 'outlook', 'debouche*', 'perspective*', 'in demand',
    'embauche*', 'recrut*', 'hiring', 'job market', 'emploi*', //
    'مستقبل', 'افاق', 'آفاق', 'سوق العمل',
  ],
};

/// Extra words pointing to each career (tools and titles are added
/// automatically).
const _careerWords = <String, List<String>>{
  'cloud': ['cloud', 'aws', 'azure', 'gcp', 'سحاب'],
  'devops': ['devops', 'dev ops', 'ci/cd', 'cicd', 'pipeline*'],
  'backend': ['backend', 'back-end', 'back end', 'api', 'serveur*', 'server*'],
  'cyber': [
    'cyber*',
    'securite',
    'security',
    'hacker*',
    'hacking',
    'pentest*',
    'soc',
    'أمن',
    'سيبران',
  ],
  'flutter': ['flutter', 'dart', 'mobile', 'android', 'ios', 'جوال', 'هاتف'],
  'java': ['java', 'spring', 'jvm'],
  'data': [
    'data',
    'donnees',
    'data scien*',
    'statisti*',
    'pandas',
    'data analyst*',
    'بيانات',
  ],
  'ai': [
    'ia',
    'ai',
    'intelligence artificielle',
    'artificial intelligence',
    'machine learning',
    'ml',
    'deep learning',
    'llm*',
    'neural',
    'neurone*',
    'ذكاء',
    'تعلم الآلة',
  ],
  'frontend': [
    'frontend',
    'front-end',
    'front end',
    'web',
    'react',
    'html',
    'css',
    'javascript',
    'js',
    'site*',
    'واجهات',
    'ويب',
  ],
};

String _normalize(String text) {
  const accents = {
    'à': 'a',
    'â': 'a',
    'ä': 'a',
    'á': 'a',
    'ç': 'c',
    'é': 'e',
    'è': 'e',
    'ê': 'e',
    'ë': 'e',
    'î': 'i',
    'ï': 'i',
    'í': 'i',
    'ô': 'o',
    'ö': 'o',
    'ó': 'o',
    'ù': 'u',
    'û': 'u',
    'ü': 'u',
    'ú': 'u',
    'œ': 'oe',
    '’': "'",
  };
  final buffer = StringBuffer();
  for (final char in text.toLowerCase().split('')) {
    buffer.write(accents[char] ?? char);
  }
  return buffer
      .toString()
      // Arabic diacritics (shadda, harakat) and tatweel.
      .replaceAll(RegExp('[\u064B-\u0652\u0640]'), '')
      // "j'ai" must not be read as the word "ai" (AI).
      .replaceAll(RegExp(r"\bj'ai\b"), 'jai')
      .replaceAll(RegExp(r"['?!.,;:()«»“”؟،]"), ' ');
}

final _latin = RegExp(r'^[a-z0-9 /+\-]+$');

/// Latin words must match whole words ("ai" is not in "salaire"); Arabic
/// words may carry prefixes and suffixes, so they only need to be contained.
bool _has(String text, String word) {
  final prefix = word.endsWith('*');
  final core = prefix ? word.substring(0, word.length - 1) : word;
  if (core.isEmpty) return false;
  if (!_latin.hasMatch(core)) return text.contains(core);
  final end = prefix ? '' : r'($|[^a-z0-9])';
  return RegExp('(^|[^a-z0-9])${RegExp.escape(core)}$end').hasMatch(text);
}

/// Offline career assistant: answers from the catalog, the courses and the
/// user's own progress. It is also the fallback when Gemini is unavailable.
class LocalAssistant {
  LocalAssistant(this.state, this.loc);

  final AppState state;
  final AppLocalizations loc;

  Set<_Intent> _intents(String text) => {
    for (final entry in _intentWords.entries)
      if (entry.value.any((word) => _has(text, word))) entry.key,
  };

  /// Career the message is about, if any.
  Career? findCareer(String message) {
    final text = _normalize(message);
    Career? best;
    var bestHits = 0;
    for (final career in careers) {
      final words = {
        ...?_careerWords[career.id],
        for (final tool in career.tools) _normalize(tool).trim(),
        _normalize(career.title).trim(),
      };
      final hits = words.where((word) => _has(text, word)).length;
      if (hits > bestHits) {
        best = career;
        bestHits = hits;
      }
    }
    return best;
  }

  AssistantAnswer answer(String message) {
    final text = _normalize(message);
    final intents = _intents(text);
    final career = findCareer(message);

    if (career != null) {
      if (intents.contains(_Intent.next)) return _next(career);
      return _careerAnswer(career, intents);
    }
    if (intents.contains(_Intent.recommend)) return _recommend();
    if (intents.contains(_Intent.next)) return _next(null);
    if (intents.contains(_Intent.progress)) return _progress();
    if (intents.contains(_Intent.premium)) return _premium();
    if (intents.contains(_Intent.list)) return _list();
    if (intents.contains(_Intent.thanks)) {
      return AssistantAnswer(loc.chatLocalThanks);
    }
    if (intents.contains(_Intent.greeting)) {
      return AssistantAnswer(
        '${loc.chatLocalGreeting(state.profile.firstName)}\n\n${loc.chatLocalHelp}',
      );
    }
    return AssistantAnswer(loc.chatLocalUnknown, [
      ChatAction(label: loc.chatOpenRecommendations, route: '/recommendations'),
    ]);
  }

  ChatAction _openCareer(Career career) => ChatAction(
    label: loc.chatOpenCareer(career.title),
    route: '/career',
    argument: career.id,
  );

  AssistantAnswer _careerAnswer(Career career, Set<_Intent> intents) {
    final lines = <String>[];
    final skills = career.labs
        .expand((lab) => lab.skills)
        .toSet()
        .map(tc)
        .join(', ');
    final specific = {
      _Intent.salary,
      _Intent.skills,
      _Intent.education,
      _Intent.outlook,
    }.intersection(intents);
    if (specific.isEmpty) {
      lines
        ..add('${career.title}: ${career.summary}')
        ..add(career.description)
        ..add(loc.chatLocalSalary(career.title, career.salary))
        ..add(loc.chatLocalTools(career.tools.join(', ')))
        ..add(loc.chatLocalLabs(career.labs.length));
    } else {
      if (specific.contains(_Intent.salary)) {
        lines.add(loc.chatLocalSalary(career.title, career.salary));
      }
      if (specific.contains(_Intent.skills)) {
        lines
          ..add(loc.chatLocalTools(career.tools.join(', ')))
          ..add(loc.chatLocalSkills(skills));
      }
      if (specific.contains(_Intent.education)) {
        lines.add(loc.chatLocalEducation(career.education));
      }
      if (specific.contains(_Intent.outlook)) {
        lines.add(loc.chatLocalOutlook(career.outlook));
      }
    }
    if (specific.isEmpty && career.dailyTasks.isNotEmpty) {
      lines.add(
        loc.chatLocalDaily(career.dailyTasks.take(3).join(', ').toLowerCase()),
      );
    }
    final average = state.careerAverage(career);
    if (average != null) {
      lines.add(
        loc.chatLocalCareerProgress(
          state.completedLabs(career),
          career.labs.length,
          average,
        ),
      );
    }
    return AssistantAnswer(lines.join('\n\n'), [
      _openCareer(career),
      ChatAction(
        label: loc.learningPath,
        route: '/learning-path',
        argument: career.id,
      ),
    ]);
  }

  AssistantAnswer _recommend() {
    final top = state.matches.take(3).toList();
    final lines = [
      loc.chatLocalRecommendIntro,
      for (var i = 0; i < top.length; i++)
        loc.chatLocalRecommendLine(i + 1, top[i].career.title, top[i].score),
      if (top.isNotEmpty) loc.matchReason(top.first),
      if (top.any((match) => !match.tested)) loc.chatLocalRecommendTip,
    ];
    return AssistantAnswer(lines.join('\n'), [
      if (top.isNotEmpty) _openCareer(top.first.career),
      ChatAction(label: loc.chatOpenRecommendations, route: '/recommendations'),
    ]);
  }

  AssistantAnswer _progress() {
    final done = state.totalCompletedLabs;
    if (done == 0) {
      final next = _next(null);
      return AssistantAnswer(
        '${loc.chatLocalNoProgress}\n\n${next.text}',
        next.actions,
      );
    }
    final lines = [
      loc.chatLocalProgress(done, state.totalLabs, state.totalMinutes),
      if (state.averageScore != null) loc.chatLocalAverage(state.averageScore!),
      if (state.skillAverages.isNotEmpty)
        loc.chatLocalStrongest(tc(state.skillAverages.keys.first)),
    ];
    final next = _next(null);
    return AssistantAnswer('${lines.join('\n')}\n\n${next.text}', next.actions);
  }

  /// Next course or lab in [career], or in the best-matching unfinished one.
  AssistantAnswer _next(Career? career) {
    final candidates = career != null
        ? [career]
        : state.matches.map((match) => match.career).toList();
    for (final candidate in candidates) {
      final lab = state.currentLab(candidate);
      if (lab == null) continue;
      final locked = state.isLabLocked(lab);
      if (!state.isCourseCompleted(lab.id)) {
        return AssistantAnswer(
          loc.chatLocalNextCourse(lab.title, candidate.title),
          [
            ChatAction(
              label: loc.chatReadCourse(lab.title),
              route: '/course',
              argument: lab.id,
            ),
            ChatAction(
              label: loc.learningPath,
              route: '/learning-path',
              argument: candidate.id,
            ),
          ],
        );
      }
      return AssistantAnswer(loc.chatLocalNextLab(lab.title, candidate.title), [
        locked
            ? ChatAction(label: loc.chatOpenPremium, route: '/premium')
            : ChatAction(
                label: loc.chatStartLab(lab.title),
                route: '/simulation',
                argument: lab.id,
              ),
        _openCareer(candidate),
      ]);
    }
    final finished = career ?? careers.first;
    return AssistantAnswer(loc.chatLocalPathDone(finished.title), [
      ChatAction(label: loc.chatOpenRecommendations, route: '/recommendations'),
    ]);
  }

  AssistantAnswer _premium() => state.isPremium
      ? AssistantAnswer(loc.chatLocalPremiumActive)
      : AssistantAnswer(loc.chatLocalPremium, [
          ChatAction(label: loc.chatOpenPremium, route: '/premium'),
        ]);

  AssistantAnswer _list() => AssistantAnswer(
    loc.chatLocalCareersList(
      careers.length,
      careers.map((career) => career.title).join(', '),
    ),
    [ChatAction(label: loc.chatOpenRecommendations, route: '/recommendations')],
  );

  /// Buttons for the careers named in a Gemini answer.
  List<ChatAction> actionsFor(String reply) {
    final text = _normalize(reply);
    return [
      for (final career in careers)
        if (_has(text, _normalize(career.title).trim())) _openCareer(career),
    ].take(2).toList();
  }

  /// Instructions and user context sent to Gemini with each question.
  String systemPrompt(String languageCode) {
    final profile = state.profile;
    final language = switch (languageCode) {
      'fr' => 'French',
      'ar' => 'Arabic',
      _ => 'English',
    };
    final buffer = StringBuffer()
      ..writeln(
        'You are the CareerVerse assistant, a friendly career-orientation '
        'coach inside a mobile app for students. Help the user discover '
        'tech careers, choose one, and progress with the app courses and '
        'labs (interactive quizzes). Stay on careers, studies, skills and '
        'learning; politely decline unrelated requests.',
      )
      ..writeln(
        'Always answer in $language, even if the question uses another '
        'language. Be concise (at most about 150 words), use short '
        'paragraphs or "- " bullet lists, plain text only (no Markdown '
        'headings, tables or bold). When you suggest a career of the '
        'catalog, use its exact title so the app can link it.',
      )
      ..writeln()
      ..writeln('USER PROFILE')
      ..writeln('- Name: ${profile.firstName}')
      ..writeln('- Study level: ${_or(profile.studyLevel)}')
      ..writeln('- Specialty: ${_or(profile.specialty)}')
      ..writeln('- Interests: ${_or(profile.interests.join(', '))}')
      ..writeln(
        '- Labs completed: ${state.totalCompletedLabs}/${state.totalLabs}, '
        'average score: ${state.averageScore ?? 'none yet'}%',
      )
      ..writeln('- Premium: ${state.isPremium ? 'yes' : 'no'}')
      ..writeln()
      ..writeln('CAREER MATCHES (computed by the app, best first)');
    for (final match in state.matches) {
      final career = match.career;
      final next = state.currentLab(career);
      buffer.writeln(
        '- ${career.title} [${career.id}]: match ${match.score}%, '
        'labs ${match.labsDone}/${career.labs.length}'
        '${match.performance != null ? ', lab average ${match.performance}%' : ''}'
        '${next != null ? ', next lab "${next.title}" (${next.level})' : ', all labs done'}'
        '. Salary ${career.salary}. Tools: ${career.tools.join(', ')}. '
        '${career.summary}',
      );
    }
    buffer
      ..writeln()
      ..writeln(
        'APP FEATURES: each career has a learning path of 3 steps '
        '(Beginner, Intermediate, Advanced); every step is a course followed '
        'by a lab. Advanced labs need Premium (Stripe test mode). The '
        'Recommendations screen ranks careers; the Progress tab shows '
        'scores per skill.',
      );
    return buffer.toString();
  }

  static String _or(String value) => value.trim().isEmpty ? 'unknown' : value;
}
