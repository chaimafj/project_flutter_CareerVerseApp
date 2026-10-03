class EscoOccupation {
  const EscoOccupation({
    required this.uri,
    required this.title,
    required this.languageCode,
    this.code,
    this.description = '',
    this.essentialSkills = const [],
    this.optionalSkills = const [],
  });

  final String uri;
  final String title;
  final String languageCode;
  final String? code;
  final String description;
  final List<String> essentialSkills;
  final List<String> optionalSkills;

  factory EscoOccupation.fromSearch(
    Map<String, dynamic> json, {
    required String languageCode,
  }) {
    final uri = json['uri'];
    if (uri is! String || uri.isEmpty) {
      throw const FormatException('ESCO search result is missing its URI.');
    }

    final labels = json['preferredLabel'];
    final localizedTitle = labels is Map
        ? labels[languageCode] ??
              (languageCode == 'en' ? labels['en-us'] : null)
        : null;
    final title = localizedTitle is String && localizedTitle.isNotEmpty
        ? localizedTitle
        : json['title'];
    if (title is! String || title.isEmpty) {
      throw const FormatException('ESCO search result is missing its title.');
    }

    return EscoOccupation(
      uri: uri,
      title: title,
      languageCode: languageCode,
      code: json['code'] is String ? json['code'] as String : null,
    );
  }

  factory EscoOccupation.withDetails(
    EscoOccupation searchResult,
    Map<String, dynamic> json,
  ) {
    final localizedDescription = _localizedLiteral(
      json['description'],
      searchResult.languageCode,
    );
    return EscoOccupation(
      uri: searchResult.uri,
      title: json['title'] is String
          ? json['title'] as String
          : searchResult.title,
      languageCode: searchResult.languageCode,
      code: json['code'] is String ? json['code'] as String : searchResult.code,
      description: localizedDescription,
      essentialSkills: _relationTitles(json, 'hasEssentialSkill'),
      optionalSkills: _relationTitles(json, 'hasOptionalSkill'),
    );
  }

  static String _localizedLiteral(dynamic value, String languageCode) {
    if (value is! Map) return '';
    final localized =
        value[languageCode] ?? (languageCode == 'en' ? value['en-us'] : null);
    return localized is Map && localized['literal'] is String
        ? localized['literal'] as String
        : '';
  }

  static List<String> _relationTitles(Map<String, dynamic> json, String key) {
    final links = json['_links'];
    if (links is! Map) return const [];
    final relation = links[key];
    final entries = relation is List
        ? relation
        : relation is Map
        ? [relation]
        : const [];
    return [
      for (final entry in entries)
        if (entry is Map && entry['title'] is String)
          (entry['title'] as String),
    ];
  }
}

class EscoOccupationPage {
  const EscoOccupationPage({
    required this.occupations,
    required this.total,
    required this.offset,
    required this.limit,
  });

  final List<EscoOccupation> occupations;
  final int total;
  final int offset;
  final int limit;

  int get nextOffset => offset + limit;
}
