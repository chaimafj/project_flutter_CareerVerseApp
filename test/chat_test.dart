import 'dart:convert';

import 'package:careerverseapp/data/catalog.dart';
import 'package:careerverseapp/l10n/app_localizations.dart';
import 'package:careerverseapp/models/chat_message.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/providers/chat_provider.dart';
import 'package:careerverseapp/services/career_assistant.dart';
import 'package:careerverseapp/services/chat_service.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget_test.dart' show buildApp, tapKey, useTallScreen;

class _FakeChat implements ChatService {
  _FakeChat(this.answer);

  final Future<String> Function() answer;
  String? lastPrompt;
  List<ChatMessage> lastHistory = const [];

  @override
  bool get isConfigured => true;

  @override
  Future<String> reply({
    required String systemPrompt,
    required List<ChatMessage> history,
  }) {
    lastPrompt = systemPrompt;
    lastHistory = history;
    return answer();
  }
}

Finder _bubble(String text) => find.byWidgetPredicate(
  (widget) => widget is SelectableText && widget.data!.contains(text),
);

Future<AppState> _loggedIn() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final state = AppState(prefs, MemoryLocalStore());
  await state.register(name: 'Sara', email: 'sara@x.com', password: 'p');
  return state;
}

void main() {
  tearDown(() => setCatalogLanguage('en'));

  group('LocalAssistant', () {
    late AppState state;
    setUp(() async => state = await _loggedIn());

    LocalAssistant assistant(String code) {
      setCatalogLanguage(code);
      return LocalAssistant(state, lookupAppLocalizations(Locale(code)));
    }

    test('recommends careers in English', () {
      final en = assistant('en');
      final answer = en.answer('Which career suits me?');
      expect(answer.text, startsWith(en.loc.chatLocalRecommendIntro));
      expect(answer.actions.map((a) => a.route), contains('/career'));
    });

    test('describes a career and its salary', () {
      final en = assistant('en');
      final data = careerById('data')!;
      final about = en.answer('Tell me about the Data Scientist job');
      expect(about.text, contains(data.description));
      expect(about.actions.first.argument, 'data');

      final salary = en.answer('How much does a Flutter developer earn?');
      expect(
        salary.text,
        contains(
          en.loc.chatLocalSalary(
            careerById('flutter')!.title,
            careerById('flutter')!.salary,
          ),
        ),
      );
      expect(salary.text, isNot(contains(careerById('flutter')!.description)));
    });

    test('understands French questions', () {
      final fr = assistant('fr');
      final next = fr.answer('Que dois-je faire ensuite ?');
      expect(next.actions, isNotEmpty);
      expect(
        next.actions.map((a) => a.route),
        anyOf(contains('/course'), contains('/simulation')),
      );
      expect(
        fr.answer('Où en suis-je ?').text,
        startsWith(fr.loc.chatLocalNoProgress),
      );
      // "j'ai" must not be read as AI.
      expect(fr.findCareer("J'ai une question"), isNull);
    });

    test('understands Arabic questions', () {
      final ar = assistant('ar');
      expect(
        ar.answer('كيف هو تقدّمي؟').text,
        startsWith(ar.loc.chatLocalNoProgress),
      );
      expect(
        ar.answer('ما المهنة التي تناسبني؟').text,
        startsWith(ar.loc.chatLocalRecommendIntro),
      );
      expect(ar.findCareer('أريد العمل في تحليل البيانات')?.id, 'data');
    });

    test('falls back to a help message', () {
      final en = assistant('en');
      expect(en.answer('blue banana').text, en.loc.chatLocalUnknown);
      expect(en.findCareer('I love salaries'), isNull);
    });

    test('finds career titles in Gemini answers', () {
      final en = assistant('en');
      final actions = en.actionsFor('Try Java Developer or Data Scientist.');
      expect(actions.map((a) => a.argument), containsAll(['java', 'data']));
    });
  });

  group('GeminiChatService', () {
    final history = [
      ChatMessage(role: ChatRole.user, text: 'Hi', createdAt: DateTime(2025)),
    ];

    test('sends the key and parses the answer', () async {
      late http.Request sent;
      final service = GeminiChatService(
        apiKey: 'test-key',
        model: 'gemini-test',
        client: MockClient((request) async {
          sent = request;
          return http.Response(
            jsonEncode({
              'candidates': [
                {
                  'content': {
                    'parts': [
                      {'text': 'Hello '},
                      {'text': 'there'},
                    ],
                  },
                },
              ],
            }),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        }),
      );
      expect(service.isConfigured, isTrue);
      final reply = await service.reply(systemPrompt: 'sys', history: history);
      expect(reply, 'Hello there');
      expect(sent.url.path, endsWith('/models/gemini-test:generateContent'));
      expect(sent.headers['x-goog-api-key'], 'test-key');
      final body = jsonDecode(sent.body) as Map<String, dynamic>;
      expect(body['contents'][0]['role'], 'user');
      expect(body['system_instruction']['parts'][0]['text'], 'sys');
    });

    test('reports HTTP errors', () async {
      final service = GeminiChatService(
        apiKey: 'bad',
        client: MockClient((_) async => http.Response('{"error":{}}', 403)),
      );
      expect(
        service.reply(systemPrompt: 's', history: history),
        throwsA(isA<ChatException>()),
      );
      expect(GeminiChatService(apiKey: '').isConfigured, isFalse);
    });
  });

  group('ChatProvider', () {
    test('uses Gemini, then falls back offline on failure', () async {
      final state = await _loggedIn();
      final prefs = await SharedPreferences.getInstance();
      final loc = lookupAppLocalizations(const Locale('en'));
      var fail = false;
      final fake = _FakeChat(() async {
        if (fail) throw const ChatException('offline');
        return '**Data Scientist** fits you well.';
      });
      final chat = ChatProvider(prefs, service: fake);

      await chat.send('Which career suits me?', state: state, loc: loc);
      expect(chat.messages, hasLength(2));
      expect(chat.messages.last.fromAi, isTrue);
      expect(chat.messages.last.text, 'Data Scientist fits you well.');
      expect(chat.messages.last.actions.single.argument, 'data');
      expect(fake.lastPrompt, contains('Sara'));
      expect(fake.lastHistory.single.text, 'Which career suits me?');

      fail = true;
      await chat.send('How am I doing?', state: state, loc: loc);
      expect(chat.messages.last.fallback, isTrue);
      expect(chat.messages.last.text, startsWith(loc.chatLocalNoProgress));

      // The conversation is stored per user.
      final reopened = ChatProvider(prefs)..open('sara@x.com');
      expect(reopened.messages, hasLength(4));
      reopened.open('other@x.com');
      expect(reopened.messages, isEmpty);

      await chat.clear();
      expect((ChatProvider(prefs)..open('sara@x.com')).messages, isEmpty);
    });
  });

  testWidgets('chat screen answers a suggestion and opens the career', (
    tester,
  ) async {
    useTallScreen(tester);
    final state = await _loggedIn();
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(buildApp(prefs, state));
    await tester.pumpAndSettle();
    await tapKey(tester, 'open-chat');
    expect(find.text('Offline assistant'), findsOneWidget);

    await tapKey(tester, 'chat-suggestion-3');
    final chat = Provider.of<ChatProvider>(
      tester.element(find.byKey(const Key('chat-list'))),
      listen: false,
    );
    expect(chat.messages.first.text, 'Tell me about the Data Scientist job');
    expect(_bubble('Average salary for Data Scientist'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('chat-input')), 'Thanks!');
    await tapKey(tester, 'chat-send');
    expect(_bubble('Thanks!'), findsOneWidget);
    expect(_bubble("You're welcome!"), findsOneWidget);

    await tester.tap(find.text('Open Data Scientist').first);
    await tester.pumpAndSettle();
    expect(find.text('Data Scientist'), findsWidgets);
    expect(find.byKey(const Key('chat-input')), findsNothing);
  });
}
