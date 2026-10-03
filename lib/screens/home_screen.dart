import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../l10n/l10n.dart';
import '../providers/app_state.dart';
import '../widgets/ad_banner.dart';
import '../widgets/career_ui.dart';
import '../widgets/user_avatar.dart';
import 'explore_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _select(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    if (!context.watch<AppState>().isLoggedIn) {
      return const Scaffold(body: SizedBox.shrink());
    }
    final loc = context.l10n;
    final labels = [loc.home, loc.labs, loc.explore, loc.progress, loc.profile];
    const icons = [
      Icons.home_rounded,
      Icons.science_outlined,
      Icons.explore_outlined,
      Icons.insights_outlined,
      Icons.person_outline,
    ];
    final pages = [
      HomeDashboard(
        onSelectTab: _select,
        onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      const ExploreScreen(),
      const CareerExplorerScreen(),
      const ProgressScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: CareerDrawer(
        onNavigate: (index) {
          Navigator.of(context).pop();
          _select(index);
        },
      ),
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Test banner on the Home and Explore tabs only.
          Visibility(
            visible: _selectedIndex == 0 || _selectedIndex == 2,
            maintainState: true,
            child: const AdBanner(),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE8EEF8))),
            ),
            child: NavigationBar(
              height: 70,
              backgroundColor: Colors.white,
              indicatorColor: const Color(0xFFEDE8FF),
              selectedIndex: _selectedIndex,
              onDestinationSelected: _select,
              destinations: List.generate(
                labels.length,
                (index) => NavigationDestination(
                  icon: Icon(icons[index]),
                  selectedIcon: Icon(icons[index], color: purple),
                  label: labels[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({
    super.key,
    required this.onSelectTab,
    required this.onOpenDrawer,
  });

  final ValueChanged<int> onSelectTab;
  final VoidCallback onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final loc = context.l10n;
    final profile = state.profile;
    final matches = state.matches;
    final lastResult = state.results.isEmpty ? null : state.results.first;
    final continueEntry = lastResult != null
        ? state.nextLab(lastResult.labId)
        : (matches.first.career, matches.first.career.labs.first);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 44, 18, 18),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [navy, Color(0xFF0C2B61)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    key: const Key('open-drawer'),
                    onPressed: onOpenDrawer,
                    icon: const Icon(Icons.menu_rounded, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      loc.helloName(profile.firstName),
                      key: const Key('home-greeting'),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/notifications'),
                    icon: Badge(
                      isLabelVisible: state.unreadCount > 0,
                      label: Text('${state.unreadCount}'),
                      child: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => onSelectTab(4),
                    child: UserAvatar(profile: profile),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 12,
                  bottom: 14,
                ),
                child: Text(
                  loc.homeSubtitle,
                  style: const TextStyle(
                    color: Color(0xFFB5C8E8),
                    fontSize: 14,
                  ),
                ),
              ),
              InkWell(
                onTap: () => onSelectTab(2),
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: mutedInk, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          loc.homeSearchHint,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: mutedInk, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.track_changes,
                                color: Color(0xFF10BDAA),
                                size: 19,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  loc.yourAiProfile,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: ink,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            loc.labsPracticed(
                              state.totalCompletedLabs,
                              state.totalLabs,
                              state.totalMinutes,
                            ),
                            style: const TextStyle(
                              color: mutedInk,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 34,
                            child: FilledButton(
                              onPressed: () => onSelectTab(3),
                              style: FilledButton.styleFrom(
                                backgroundColor: purple,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),
                              child: Text(
                                loc.viewProgress,
                                style: const TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ScoreRing(
                      score: state.averageScore,
                      size: 70,
                      label: loc.avg,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
            children: [
              if (continueEntry != null) ...[
                _ContinueCard(
                  title: lastResult == null ? loc.startFirstLab : loc.upNext,
                  career: continueEntry.$1.title,
                  lab: continueEntry.$2.title,
                  color: continueEntry.$1.color,
                  icon: continueEntry.$1.icon,
                  onTap: () => Navigator.of(context)
                      .pushNamed('/simulation', arguments: continueEntry.$2.id),
                ),
                const SizedBox(height: 16),
              ],
              SectionTitle(loc.quickAccess),
              const SizedBox(height: 8),
              Row(
                children: [
                  _QuickTile(
                    icon: Icons.science_outlined,
                    label: loc.labs,
                    color: purple,
                    onTap: () => onSelectTab(1),
                  ),
                  _QuickTile(
                    icon: Icons.auto_awesome,
                    label: loc.aiMatch,
                    color: const Color(0xFF10A37F),
                    onTap: () =>
                        Navigator.of(context).pushNamed('/recommendations'),
                  ),
                  _QuickTile(
                    icon: Icons.route_outlined,
                    label: loc.path,
                    color: blue,
                    onTap: () => Navigator.of(context).pushNamed(
                      '/learning-path',
                      arguments: matches.first.career.id,
                    ),
                  ),
                  _QuickTile(
                    icon: Icons.insights_outlined,
                    label: loc.progress,
                    color: const Color(0xFFF59E0B),
                    onTap: () => onSelectTab(3),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SectionTitle(
                loc.recommendedCareers,
                action: loc.seeAll,
                onAction: () =>
                    Navigator.of(context).pushNamed('/recommendations'),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: matches.length,
                  separatorBuilder: (_, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final match = matches[index];
                    return _MatchCard(match: match);
                  },
                ),
              ),
              const SizedBox(height: 18),
              SectionTitle(loc.recentActivity),
              const SizedBox(height: 8),
              if (state.results.isEmpty)
                _HintCard(text: loc.noActivity)
              else
                ...state.results.take(3).map((result) {
                  final (career, lab) = findLab(result.labId)!;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        onTap: () =>
                            Navigator.of(context)
                                .pushNamed('/results', arguments: result.id),
                        leading: Icon(career.icon, color: career.color),
                        title: Text(
                          lab.title,
                          style: const TextStyle(
                            color: ink,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Text(
                          loc.timeAgo(result.completedAt),
                          style: const TextStyle(fontSize: 11),
                        ),
                        trailing: Text(
                          '${result.overall}%',
                          style: TextStyle(
                            color: scoreColor(result.overall),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({
    required this.title,
    required this.career,
    required this.lab,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String career;
  final String lab;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key('continue-card'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [purple, blue]),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white.withValues(alpha: 0.18),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFDCE7FF),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    lab,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    career,
                    style: const TextStyle(
                      color: Color(0xFFDCE7FF),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.play_circle_fill, color: Colors.white, size: 36),
          ],
        ),
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 19,
                    backgroundColor: color.withValues(alpha: 0.12),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    style: const TextStyle(
                      color: ink,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({required this.match});

  final CareerMatch match;

  @override
  Widget build(BuildContext context) {
    final career = match.career;
    return SizedBox(
      width: 150,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () =>
              Navigator.of(context).pushNamed('/career', arguments: career.id),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: career.color,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Icon(career.icon, color: Colors.white, size: 21),
                    ),
                    const Spacer(),
                    Text(
                      '${match.score}%',
                      style: TextStyle(
                        color: scoreColor(match.score),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  career.title,
                  maxLines: 2,
                  style: const TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Text(
                  match.tested
                      ? context.l10n.basedOnLabs
                      : context.l10n.basedOnInterests,
                  style: const TextStyle(color: mutedInk, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HintCard extends StatelessWidget {
  const _HintCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: mutedInk),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: mutedInk, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class CareerDrawer extends StatelessWidget {
  const CareerDrawer({super.key, required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final loc = context.l10n;
    final profile = state.profile;
    final navigator = Navigator.of(context);

    void push(String route, [Object? arguments]) {
      navigator.pop();
      navigator.pushNamed(route, arguments: arguments);
    }

    return Drawer(
      backgroundColor: navy,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  UserAvatar(profile: profile, radius: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          profile.email,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFB5C8E8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF1D3466)),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _DrawerItem(
                    Icons.home_rounded,
                    loc.home,
                    () => onNavigate(0),
                  ),
                  _DrawerItem(
                    Icons.science_outlined,
                    loc.careerLabs,
                    () => onNavigate(1),
                  ),
                  _DrawerItem(
                    Icons.explore_outlined,
                    loc.exploreCareers,
                    () => onNavigate(2),
                  ),
                  _DrawerItem(
                    Icons.auto_awesome,
                    loc.aiRecommendations,
                    () => push('/recommendations'),
                  ),
                  _DrawerItem(
                    Icons.route_outlined,
                    loc.learningPath,
                    () => push('/learning-path', state.matches.first.career.id),
                  ),
                  _DrawerItem(
                    Icons.insights_outlined,
                    loc.myProgress,
                    () => onNavigate(3),
                  ),
                  _DrawerItem(
                    Icons.notifications_none,
                    loc.notifications,
                    () => push('/notifications'),
                    badge: state.unreadCount,
                  ),
                  _DrawerItem(
                    Icons.person_outline,
                    loc.profile,
                    () => onNavigate(4),
                  ),
                  _DrawerItem(
                    Icons.workspace_premium_outlined,
                    loc.premium,
                    () => push('/premium'),
                    color: const Color(0xFFFFC94D),
                  ),
                  _DrawerItem(
                    Icons.settings_outlined,
                    loc.settings,
                    () => push('/settings'),
                  ),
                  _DrawerItem(Icons.info_outline, loc.about, () {
                    navigator.pop();
                    showAboutDialog(
                      context: context,
                      applicationName: 'CareerVerse',
                      applicationVersion: '1.0.0',
                      applicationLegalese: loc.aboutText,
                    );
                  }),
                ],
              ),
            ),
            const Divider(color: Color(0xFF1D3466)),
            _DrawerItem(Icons.logout, loc.logout, () async {
              await context.read<AppState>().logout();
              navigator.pushNamedAndRemoveUntil('/welcome', (_) => false);
            }, color: const Color(0xFFFF8A8A)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem(
    this.icon,
    this.label,
    this.onTap, {
    this.badge = 0,
    this.color = Colors.white,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final int badge;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color, fontSize: 14)),
      trailing: badge > 0
          ? Badge(label: Text('$badge'), backgroundColor: purple)
          : null,
      onTap: onTap,
    );
  }
}
