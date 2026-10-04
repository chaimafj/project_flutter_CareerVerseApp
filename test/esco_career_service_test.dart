import 'dart:convert';

import 'package:careerverseapp/l10n/app_localizations.dart';
import 'package:careerverseapp/models/esco_occupation.dart';
import 'package:careerverseapp/providers/app_state.dart';
import 'package:careerverseapp/providers/salary_currency_provider.dart';
import 'package:careerverseapp/screens/esco_career_detail_screen.dart';
import 'package:careerverseapp/screens/explore_screen.dart';
import 'package:careerverseapp/services/esco_career_service.dart';
import 'package:careerverseapp/services/local_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const uri = 'http://data.europa.eu/esco/occupation/test-occupation';

  test('search parses localized ESCO occupation results', () async {
    late http.Request request;
    final service = EscoCareerService(
      client: MockClient((sent) async {
        request = sent;
        return http.Response(
          jsonEncode({
            '_embedded': {
              'results': [
                {
                  'uri': uri,
                  'title': 'data scientist',
                  'preferredLabel': {'fr': 'scientifique des données'},
                  'code': '2511.3',
                },
              ],
            },
          }),
          200,
        );
      }),
    );

    final results = await service.search(query: 'data', languageCode: 'fr');
    expect(request.url.host, 'ec.europa.eu');
    expect(request.url.path, '/esco/api/search');
    expect(request.url.queryParameters['type'], 'occupation');
    expect(request.url.queryParameters['language'], 'fr');
    expect(request.url.queryParameters['offset'], '0');
    expect(results.occupations.single.title, 'scientifique des données');
    expect(results.occupations.single.code, '2511.3');
  });

  test('details parse translated description and skills', () async {
    final service = EscoCareerService(
      client: MockClient((request) async {
        expect(request.url.path, '/esco/api/resource/occupation');
        expect(request.url.queryParameters['uri'], uri);
        expect(request.url.queryParameters['language'], 'fr');
        return http.Response(
          jsonEncode({
            'title': 'Scientifique des données',
            'description': {
              'fr': {'literal': 'Analyse des données complexes.'},
            },
            '_links': {
              'hasEssentialSkill': [
                {'title': 'Analyser des données'},
                {'title': 'Créer des modèles'},
              ],
              'hasOptionalSkill': [
                {'title': 'Visualiser des données'},
              ],
            },
          }),
          200,
        );
      }),
    );
    const result = EscoOccupation(
      uri: uri,
      title: 'Scientifique des données',
      languageCode: 'fr',
    );

    final details = await service.details(result);
    expect(details.description, 'Analyse des données complexes.');
    expect(details.essentialSkills, [
      'Analyser des données',
      'Créer des modèles',
    ]);
    expect(details.optionalSkills, ['Visualiser des données']);
  });

  test('reports HTTP and invalid JSON errors', () async {
    final httpError = EscoCareerService(
      client: MockClient((_) async => http.Response('unavailable', 503)),
    );
    await expectLater(
      httpError.search(query: 'data', languageCode: 'en'),
      throwsA(isA<EscoApiException>()),
    );

    final invalidJson = EscoCareerService(
      client: MockClient((_) async => http.Response('{', 200)),
    );
    await expectLater(
      invalidJson.search(query: 'data', languageCode: 'en'),
      throwsA(isA<EscoApiException>()),
    );
  });

  testWidgets('searches ESCO and opens a dynamic occupation profile', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final state = AppState(prefs, MemoryLocalStore());
    await state.register(
      name: 'Sara',
      email: 'sara@example.com',
      password: 'p',
    );
    final service = EscoCareerService(
      client: MockClient((request) async {
        if (request.url.path == '/esco/api/search') {
          final offset = int.parse(request.url.queryParameters['offset']!);
          final title = offset == 0
              ? 'Quantum systems analyst'
              : 'Quantum systems researcher';
          return http.Response(
            jsonEncode({
              'total': 20,
              'offset': offset,
              'limit': 10,
              '_embedded': {
                'results': [
                  {
                    'uri': '$uri-$offset',
                    'title': title,
                    'preferredLabel': {'en': title},
                    'code': '9999.1',
                  },
                ],
              },
            }),
            200,
          );
        }
        return http.Response(
          jsonEncode({
            'title': 'Quantum systems analyst',
            'description': {
              'en': {'literal': 'Studies complex quantum systems.'},
            },
            '_links': {
              'hasEssentialSkill': [
                {'title': 'Analyze complex systems'},
              ],
            },
          }),
          200,
        );
      }),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: state,
        child: ChangeNotifierProvider(
          create: (_) => SalaryCurrencyProvider(prefs, autoRefresh: false),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: CareerExplorerScreen(escoService: service),
            onGenerateRoute: (settings) {
              if (settings.name == '/esco-career') {
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => EscoCareerDetailScreen(service: service),
                );
              }
              return null;
            },
          ),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('explore-search')), 'Quantum');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Quantum systems analyst'), findsOneWidget);
    expect(find.text('European Commission · ESCO'), findsOneWidget);
    expect(find.byKey(const Key('esco-load-more')), findsOneWidget);
    await tester.tap(find.byKey(const Key('esco-load-more')));
    await tester.pumpAndSettle();
    expect(find.text('Quantum systems researcher'), findsOneWidget);

    await tester.tap(find.text('Quantum systems analyst'));
    await tester.pumpAndSettle();
    expect(find.text('Studies complex quantum systems.'), findsOneWidget);
    expect(find.text('Analyze complex systems'), findsOneWidget);
    expect(find.byKey(const Key('esco-labs-notice')), findsOneWidget);
  });
}
