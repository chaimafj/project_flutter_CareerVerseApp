import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/esco_occupation.dart';
import '../services/esco_career_service.dart';
import '../widgets/career_ui.dart';

class EscoCareerDetailScreen extends StatefulWidget {
  const EscoCareerDetailScreen({super.key, this.service});

  final EscoCareerService? service;

  @override
  State<EscoCareerDetailScreen> createState() => _EscoCareerDetailScreenState();
}

class _EscoCareerDetailScreenState extends State<EscoCareerDetailScreen> {
  late final EscoCareerService _service = widget.service ?? EscoCareerService();
  EscoOccupation? _occupation;
  Future<EscoOccupation>? _details;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final argument = ModalRoute.of(context)?.settings.arguments;
    if (argument is EscoOccupation && argument.uri != _occupation?.uri) {
      _occupation = argument;
      _details = _service.details(argument);
    }
  }

  void _retry() {
    final occupation = _occupation;
    if (occupation == null) return;
    setState(() => _details = _service.details(occupation));
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    final occupation = _occupation;
    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        title: Text(occupation?.title ?? loc.exploreCareersTitle),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: occupation == null
          ? Center(child: Text(loc.escoNetworkError))
          : FutureBuilder<EscoOccupation>(
              future: _details,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            loc.escoNetworkError,
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            key: const Key('esco-detail-retry'),
                            onPressed: _retry,
                            child: Text(loc.escoRetry),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return _OccupationDetails(occupation: snapshot.data!);
              },
            ),
    );
  }
}

class _OccupationDetails extends StatelessWidget {
  const _OccupationDetails({required this.occupation});

  final EscoOccupation occupation;

  @override
  Widget build(BuildContext context) {
    final loc = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: navy,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.work_outline, color: Colors.white, size: 28),
              const SizedBox(height: 12),
              Text(
                occupation.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (occupation.code case final code?) ...[
                const SizedBox(height: 6),
                Text(
                  loc.escoOccupationCode(code),
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Section(
          title: loc.aboutTheJob,
          child: Text(
            occupation.description.isEmpty
                ? loc.escoNoCareerDescription
                : occupation.description,
            style: const TextStyle(color: mutedInk, height: 1.5),
          ),
        ),
        if (occupation.essentialSkills.isNotEmpty) ...[
          const SizedBox(height: 14),
          _Section(
            title: loc.escoCareerSkills,
            child: _SkillList(skills: occupation.essentialSkills),
          ),
        ],
        if (occupation.optionalSkills.isNotEmpty) ...[
          const SizedBox(height: 14),
          _Section(
            title: loc.escoOptionalCareerSkills,
            child: _SkillList(skills: occupation.optionalSkills),
          ),
        ],
        const SizedBox(height: 14),
        Container(
          key: const Key('esco-labs-notice'),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFEDE8FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            loc.escoCareerLabsNote,
            style: const TextStyle(color: ink, height: 1.4),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          loc.escoRemoteSource,
          textAlign: TextAlign.center,
          style: const TextStyle(color: mutedInk, fontSize: 12),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ink,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

class _SkillList extends StatelessWidget {
  const _SkillList({required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (final skill in skills)
        Chip(
          label: Text(skill),
          backgroundColor: const Color(0xFFF0F4FC),
          side: BorderSide.none,
          labelStyle: const TextStyle(color: ink, fontSize: 12),
        ),
    ],
  );
}
