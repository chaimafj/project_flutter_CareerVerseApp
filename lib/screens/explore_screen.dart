import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../l10n/l10n.dart';
import '../models/career.dart';
import '../models/esco_occupation.dart';
import '../providers/app_state.dart';
import '../services/esco_career_service.dart';
import '../widgets/career_ui.dart';

const _categories = <String, List<String>>{
  'All': [
    'cloud',
    'devops',
    'backend',
    'cyber',
    'flutter',
    'java',
    'frontend',
    'data',
    'ai',
  ],
  'Development': ['backend', 'java', 'flutter', 'frontend'],
  'Mobile & Web': ['flutter', 'frontend'],
  'Data & AI': ['data', 'ai'],
  'Infrastructure': ['cloud', 'devops'],
  'Security': ['cyber', 'cloud'],
};

String _categoryLabel(AppLocalizations loc, String key) => switch (key) {
  'Infrastructure' => loc.categoryInfrastructure,
  'Development' => loc.categoryDevelopment,
  'Mobile & Web' => loc.categoryMobileWeb,
  'Data & AI' => loc.categoryDataAi,
  'Security' => loc.categorySecurity,
  _ => loc.all,
};

/// "Explore" tab: search careers and browse them by category.
class CareerExplorerScreen extends StatefulWidget {
  const CareerExplorerScreen({super.key, this.escoService});

  final EscoCareerService? escoService;

  @override
  State<CareerExplorerScreen> createState() => _CareerExplorerScreenState();
}

class _CareerExplorerScreenState extends State<CareerExplorerScreen> {
  late final EscoCareerService _escoService =
      widget.escoService ?? EscoCareerService();
  Timer? _searchDebounce;
  String _query = '';
  String? _searchLanguage;
  List<EscoOccupation> _escoResults = const [];
  EscoApiException? _escoError;
  int _escoTotal = 0;
  int _escoOffset = 0;
  bool _isSearchingEsco = false;
  bool _isLoadingMoreEsco = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final language = Localizations.localeOf(context).languageCode;
    if (_searchLanguage != language) {
      _searchLanguage = language;
      if (_query.trim().length >= 2) {
        _scheduleEscoSearch(_query, language);
      }
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    final hasRemoteQuery = value.trim().length >= 2;
    setState(() {
      _query = value;
      _escoError = null;
      _escoResults = const [];
      _isSearchingEsco = hasRemoteQuery;
      _isLoadingMoreEsco = false;
      _escoTotal = 0;
      _escoOffset = 0;
    });
    _searchDebounce?.cancel();
    if (!hasRemoteQuery) return;
    _scheduleEscoSearch(value, Localizations.localeOf(context).languageCode);
  }

  void _scheduleEscoSearch(String query, String language) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      _searchEsco(query.trim(), language);
    });
  }

  Future<void> _searchEsco(
    String query,
    String language, {
    int offset = 0,
  }) async {
    setState(() {
      if (offset == 0) {
        _isSearchingEsco = true;
        _escoResults = const [];
        _escoTotal = 0;
        _escoOffset = 0;
      } else {
        _isLoadingMoreEsco = true;
      }
      _escoError = null;
    });
    try {
      final page = await _escoService.search(
        query: query,
        languageCode: language,
        offset: offset,
      );
      if (!mounted ||
          query != _query.trim() ||
          language != _searchLanguage) {
        return;
      }
      final localTitles = careers.map((career) => career.title.toLowerCase());
      final existingUris = _escoResults.map((occupation) => occupation.uri);
      final occupations = [
        for (final result in page.occupations)
          if (!localTitles.contains(result.title.toLowerCase()) &&
              !existingUris.contains(result.uri))
            result,
      ];
      setState(() {
        _escoResults = [..._escoResults, ...occupations];
        _escoTotal = page.total;
        _escoOffset = page.nextOffset;
        _isSearchingEsco = false;
        _isLoadingMoreEsco = false;
      });
    } on EscoApiException catch (error) {
      if (!mounted ||
          query != _query.trim() ||
          language != _searchLanguage) {
        return;
      }
      setState(() {
        _escoError = error;
        _isSearchingEsco = false;
        _isLoadingMoreEsco = false;
      });
    }
  }

  void _retryEscoSearch() {
    final query = _query.trim();
    if (query.length >= 2) {
      _searchEsco(query, Localizations.localeOf(context).languageCode);
    }
  }

  void _loadMoreEsco() {
    final query = _query.trim();
    final language = Localizations.localeOf(context).languageCode;
    if (query.length >= 2 && _escoOffset < _escoTotal) {
      _searchEsco(query, language, offset: _escoOffset);
    }
  }

  bool _matchesQuery(Career career) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return [
      career.title,
      career.summary,
      ...career.tools,
      ...career.tags,
      ...career.labs.map((lab) => lab.title),
    ].any((text) => text.toLowerCase().contains(q));
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        backgroundColor: canvas,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            loc.exploreCareersTitle,
            style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                  child: TextField(
                    key: const Key('explore-search'),
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: loc.exploreSearchHint,
                      prefixIcon: const Icon(Icons.search, color: mutedInk),
                      filled: true,
                      fillColor: const Color(0xFFF0F4FC),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelColor: purple,
                  unselectedLabelColor: mutedInk,
                  indicatorColor: purple,
                  tabs: _categories.keys
                      .map((c) => Tab(text: _categoryLabel(loc, c)))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: _categories.values.map((ids) {
            final list = careers
                .where((c) => ids.contains(c.id) && _matchesQuery(c))
                .toList();
            if (list.isEmpty &&
                _escoResults.isEmpty &&
                !_isSearchingEsco &&
                _escoError == null) {
              return Center(
                child: EmptyState(
                  icon: Icons.search_off,
                  title: loc.noCareerFound,
                  message: loc.noCareerFoundMessage,
                ),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final career in list) CareerCard(career: career),
                ..._escoSearchContent(context),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Widget> _escoSearchContent(BuildContext context) {
    if (_query.trim().length < 2) return const [];
    final loc = context.l10n;
    if (_isSearchingEsco) {
      return [
        const Padding(
          key: Key('esco-loading'),
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }
    if (_escoError != null && _escoResults.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(loc.escoNetworkError, textAlign: TextAlign.center),
              TextButton(
                key: const Key('esco-retry'),
                onPressed: _retryEscoSearch,
                child: Text(loc.escoRetry),
              ),
            ],
          ),
        ),
      ];
    }
    if (_escoResults.isEmpty) {
      return [Center(child: Text(loc.escoNoResults))];
    }
    final content = <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
        child: Text(
          loc.escoMoreCareers,
          style: const TextStyle(
            color: ink,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          loc.escoMoreCareersDescription,
          style: const TextStyle(color: mutedInk, fontSize: 12),
        ),
      ),
      for (final (index, occupation) in _escoResults.indexed)
        EscoOccupationCard(
          key: Key('esco-result-$index'),
          occupation: occupation,
        ),
    ];
    if (_escoError != null) {
      content.add(
        Center(
          child: TextButton(
            key: const Key('esco-retry'),
            onPressed: _loadMoreEsco,
            child: Text(loc.escoRetry),
          ),
        ),
      );
    } else if (_escoOffset < _escoTotal) {
      content.add(
        Center(
          child: TextButton(
            key: const Key('esco-load-more'),
            onPressed: _isLoadingMoreEsco ? null : _loadMoreEsco,
            child: _isLoadingMoreEsco
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(loc.escoLoadMore),
          ),
        ),
      );
    }
    return content;
  }
}

class EscoOccupationCard extends StatelessWidget {
  const EscoOccupationCard({super.key, required this.occupation});

  final EscoOccupation occupation;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(
          context,
        ).pushNamed('/esco-career', arguments: occupation),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE8FF),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.work_outline, color: purple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      occupation.title,
                      style: const TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      context.l10n.escoRemoteSource,
                      style: const TextStyle(color: mutedInk, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: mutedInk),
            ],
          ),
        ),
      ),
    ),
  );
}

class CareerCard extends StatelessWidget {
  const CareerCard({super.key, required this.career});

  final Career career;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final done = state.completedLabs(career);
    final average = state.careerAverage(career);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () =>
              Navigator.of(context).pushNamed('/career', arguments: career.id),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'career-${career.id}',
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: career.color,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(career.icon, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            career.title,
                            style: const TextStyle(
                              color: ink,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            career.summary,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: mutedInk,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: mutedInk),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    ToolPill(career.salary, icon: Icons.euro),
                    ...career.tools.take(3).map((t) => ToolPill(t)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: done / career.labs.length,
                          minHeight: 6,
                          backgroundColor: const Color(0xFFE6ECF7),
                          color: career.color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${context.l10n.labsProgress(done, career.labs.length)}'
                      '${average != null ? ' · $average%' : ''}',
                      style: const TextStyle(
                        color: mutedInk,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// "Labs" tab: every lab of every career, filterable by level and status.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _level = 'All';
  String _status = 'All';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final loc = context.l10n;
    final entries =
        [
          for (final career in careers)
            for (final lab in career.labs) (career, lab),
        ].where((entry) {
          final lab = entry.$2;
          if (_level != 'All' && lab.level != _level) return false;
          final completed = state.isCompleted(lab.id);
          if (_status == 'Completed' && !completed) return false;
          if (_status == 'To do' && completed) return false;
          return true;
        }).toList();

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          loc.careerLabs,
          style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: Column(
              children: [
                _ChipRow(
                  values: const ['All', 'Beginner', 'Intermediate', 'Advanced'],
                  selected: _level,
                  onSelected: (v) => setState(() => _level = v),
                  labelOf: (v) => v == 'All' ? loc.all : tc(v),
                ),
                _ChipRow(
                  values: const ['All', 'To do', 'Completed'],
                  selected: _status,
                  onSelected: (v) => setState(() => _status = v),
                  labelOf: (v) => switch (v) {
                    'To do' => loc.toDo,
                    'Completed' => loc.completed,
                    _ => loc.all,
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
            child: Row(
              children: [
                Text(
                  loc.labsCount(entries.length),
                  style: const TextStyle(color: mutedInk, fontSize: 12),
                ),
                const Spacer(),
                Text(
                  loc.completedCount(state.totalCompletedLabs, state.totalLabs),
                  style: const TextStyle(
                    color: purple,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: entries.isEmpty
                ? Center(
                    child: EmptyState(
                      icon: Icons.science_outlined,
                      title: loc.noLabHere,
                      message: loc.noLabHereMessage,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final (career, lab) = entries[index];
                      final best = state.bestResult(lab.id);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          child: ListTile(
                            key: Key('lab-${lab.id}'),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onTap: () =>
                                Navigator.of(context)
                                    .pushNamed('/career', arguments: career.id),
                            leading: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: career.color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(career.icon, color: career.color),
                            ),
                            title: Text(
                              lab.title,
                              style: const TextStyle(
                                color: ink,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              '${career.title} · ${tc(lab.level)} · ~${loc.minutesShort(lab.minutes)}',
                              style: TextStyle(
                                color: levelColor(lab.level),
                                fontSize: 11,
                              ),
                            ),
                            trailing: best == null
                                ? IconButton(
                                    tooltip: loc.start,
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(
                                          '/simulation',
                                          arguments: lab.id,
                                        ),
                                    icon: const Icon(
                                      Icons.play_circle_fill,
                                      color: purple,
                                      size: 30,
                                    ),
                                  )
                                : Text(
                                    '${best.overall}%',
                                    style: TextStyle(
                                      color: scoreColor(best.overall),
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({
    required this.values,
    required this.selected,
    required this.onSelected,
    required this.labelOf,
  });

  final List<String> values;
  final String selected;
  final ValueChanged<String> onSelected;
  final String Function(String) labelOf;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: values
            .map(
              (value) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 6, top: 6),
                child: ChoiceChip(
                  label: Text(labelOf(value)),
                  selected: value == selected,
                  onSelected: (_) => onSelected(value),
                  selectedColor: const Color(0xFFEDE8FF),
                  labelStyle: TextStyle(
                    color: value == selected ? purple : mutedInk,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  showCheckmark: false,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
