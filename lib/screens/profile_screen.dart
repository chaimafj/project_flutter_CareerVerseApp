import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../data/salary_countries.dart';
import '../l10n/l10n.dart';
import '../providers/app_state.dart';
import '../widgets/career_ui.dart';
import '../widgets/user_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final profile = state.profile;
    final loc = context.l10n;
    final skills = state.skillAverages.entries.take(3).toList();
    final subtitle = [
      profile.specialty,
      profile.university,
      if (salaryCountryByCode(profile.countryCode) case final country?)
        country.name(loc),
    ].where((s) => s.isNotEmpty).join(' · ');

    return Scaffold(
      backgroundColor: canvas,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 22),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [navy, Color(0xFF0C2B61)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        loc.profile,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/settings'),
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                UserAvatar(profile: profile, radius: 44),
                const SizedBox(height: 10),
                Text(
                  profile.name,
                  key: const Key('profile-name'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle.isEmpty ? profile.email : subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFB5C8E8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  key: const Key('edit-profile'),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/edit-profile'),
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: Text(loc.editProfile),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              loc.profileCompleteness,
                              style: const TextStyle(
                                color: ink,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            '${profile.completeness}%',
                            style: const TextStyle(
                              color: purple,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: profile.completeness / 100,
                          minHeight: 7,
                          backgroundColor: const Color(0xFFE6ECF7),
                          color: purple,
                        ),
                      ),
                      if (profile.completeness < 100) ...[
                        const SizedBox(height: 6),
                        Text(
                          loc.completeProfileHint,
                          style: const TextStyle(color: mutedInk, fontSize: 11),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _Mini(
                      value: '${state.totalCompletedLabs}',
                      label: loc.labs,
                    ),
                    const SizedBox(width: 10),
                    _Mini(
                      value: state.averageScore == null
                          ? '--'
                          : '${state.averageScore}%',
                      label: loc.avgScore,
                    ),
                    const SizedBox(width: 10),
                    _Mini(
                      value: state.matches.isEmpty ? '--' : '${state.matches.first.score}%',
                      label: loc.topMatch,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SectionTitle(loc.aboutMe),
                const SizedBox(height: 8),
                _Card(
                  child: Column(
                    children: [
                      _InfoRow(Icons.mail_outline, loc.email, profile.email),
                      _InfoRow(
                        Icons.school_outlined,
                        loc.studyLevel,
                        tc(profile.studyLevel),
                      ),
                      _InfoRow(
                        Icons.account_balance_outlined,
                        loc.university,
                        profile.university,
                      ),
                      _InfoRow(
                        Icons.workspace_premium_outlined,
                        loc.specialty,
                        profile.specialty,
                      ),
                      _InfoRow(Icons.notes, loc.bio, profile.bio),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionTitle(loc.interests),
                const SizedBox(height: 8),
                if (profile.interests.isEmpty)
                  Text(
                    loc.noInterestsYet,
                    style: const TextStyle(color: mutedInk, fontSize: 12),
                  )
                else
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: profile.interests
                        .map(
                          (i) => Chip(
                            label: Text(tc(i)),
                            backgroundColor: const Color(0xFFEDE8FF),
                            labelStyle: const TextStyle(
                              color: purple,
                              fontSize: 12,
                            ),
                            side: BorderSide.none,
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 16),
                SectionTitle(loc.topSkills),
                const SizedBox(height: 8),
                if (skills.isEmpty)
                  Text(
                    loc.noTopSkills,
                    style: const TextStyle(color: mutedInk, fontSize: 12),
                  )
                else
                  ...skills.map(
                    (e) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: const Icon(Icons.bolt, color: purple),
                      title: Text(
                        tc(e.key),
                        style: const TextStyle(color: ink),
                      ),
                      trailing: Text(
                        '${e.value}%',
                        style: TextStyle(
                          color: scoreColor(e.value),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    loc.memberSince(
                      '${profile.createdAt.day.toString().padLeft(2, '0')}/'
                      '${profile.createdAt.month.toString().padLeft(2, '0')}/${profile.createdAt.year}',
                    ),
                    style: const TextStyle(color: mutedInk, fontSize: 11),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton.icon(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await context.read<AppState>().logout();
                      navigator.pushNamedAndRemoveUntil(
                        '/welcome',
                        (_) => false,
                      );
                    },
                    icon: const Icon(Icons.logout, color: Color(0xFFE5484D)),
                    label: Text(
                      loc.logout,
                      style: const TextStyle(color: Color(0xFFE5484D)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class _Mini extends StatelessWidget {
  const _Mini({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _Card(
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: ink,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
            Text(label, style: const TextStyle(color: mutedInk, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: const Color(0xFF526B99)),
          const SizedBox(width: 10),
          SizedBox(
            width: 82,
            child: Text(
              label,
              style: const TextStyle(color: mutedInk, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? context.l10n.notSet : value,
              style: TextStyle(
                color: value.isEmpty ? const Color(0xFFAAB6CB) : ink,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
