import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../models/career.dart';
import '../providers/app_state.dart';
import '../widgets/career_ui.dart';

const _categories = <String, List<String>>{
  'All': ['cloud', 'devops', 'backend', 'cyber'],
  'Infrastructure': ['cloud', 'devops'],
  'Development': ['backend', 'devops'],
  'Security': ['cyber', 'cloud'],
};

/// "Explore" tab: search careers and browse them by category.
class CareerExplorerScreen extends StatefulWidget {
  const CareerExplorerScreen({super.key});

  @override
  State<CareerExplorerScreen> createState() => _CareerExplorerScreenState();
}

class _CareerExplorerScreenState extends State<CareerExplorerScreen> {
  String _query = '';

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
    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        backgroundColor: canvas,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Text(
            'Explore Careers',
            style: TextStyle(color: ink, fontWeight: FontWeight.w800),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                  child: TextField(
                    key: const Key('explore-search'),
                    onChanged: (value) => setState(() => _query = value),
                    decoration: InputDecoration(
                      hintText: 'Search careers, tools or labs...',
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
                  tabs: _categories.keys.map((c) => Tab(text: c)).toList(),
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
            if (list.isEmpty) {
              return const Center(
                child: EmptyState(
                  icon: Icons.search_off,
                  title: 'No career found',
                  message: 'Try another keyword, e.g. "AWS" or "Docker".',
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              itemBuilder: (context, index) => CareerCard(career: list[index]),
            );
          }).toList(),
        ),
      ),
    );
  }
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
                      '$done/${career.labs.length} labs'
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
        title: const Text(
          'Career Labs',
          style: TextStyle(color: ink, fontWeight: FontWeight.w800),
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
                ),
                _ChipRow(
                  values: const ['All', 'To do', 'Completed'],
                  selected: _status,
                  onSelected: (v) => setState(() => _status = v),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
            child: Row(
              children: [
                Text(
                  '${entries.length} labs',
                  style: const TextStyle(color: mutedInk, fontSize: 12),
                ),
                const Spacer(),
                Text(
                  '${state.totalCompletedLabs}/${state.totalLabs} completed',
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
                ? const Center(
                    child: EmptyState(
                      icon: Icons.science_outlined,
                      title: 'No lab here',
                      message: 'Change the filters to see more labs.',
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
                              '${career.title} · ${lab.level} · ~${lab.minutes} min',
                              style: TextStyle(
                                color: levelColor(lab.level),
                                fontSize: 11,
                              ),
                            ),
                            trailing: best == null
                                ? IconButton(
                                    tooltip: 'Start',
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
  });

  final List<String> values;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: values
            .map(
              (value) => Padding(
                padding: const EdgeInsets.only(right: 6, top: 6),
                child: ChoiceChip(
                  label: Text(value),
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
