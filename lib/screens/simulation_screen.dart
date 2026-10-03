import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../models/career.dart';
import '../providers/app_state.dart';
import '../widgets/career_ui.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  late final Career _career;
  late final Lab _lab;
  bool _initialized = false;

  final _stopwatch = Stopwatch();
  Timer? _ticker;
  int _index = 0;
  Set<int> _selected = {};
  bool _checked = false;
  bool _saving = false;
  final List<Set<int>> _answers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    final labId = ModalRoute.of(context)!.settings.arguments as String;
    final found = findLab(labId)!;
    _career = found.$1;
    _lab = found.$2;
    _initialized = true;
    _stopwatch.start();
    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  LabQuestion get _question => _lab.questions[_index];
  bool get _isLast => _index == _lab.questions.length - 1;

  void _toggle(int option) {
    if (_checked) return;
    setState(() {
      if (_question.isMultiple) {
        _selected.contains(option)
            ? _selected.remove(option)
            : _selected.add(option);
      } else {
        _selected = {option};
      }
    });
  }

  void _check() {
    setState(() {
      _checked = true;
      _answers.add(Set.of(_selected));
    });
  }

  Future<void> _next() async {
    if (!_isLast) {
      setState(() {
        _index++;
        _selected = {};
        _checked = false;
      });
      return;
    }
    setState(() => _saving = true);
    _stopwatch.stop();
    _ticker?.cancel();
    final result = await context.read<AppState>().recordResult(
      career: _career,
      lab: _lab,
      answers: _answers,
      durationSeconds: _stopwatch.elapsed.inSeconds,
    );
    if (!mounted) return;
    Navigator.of(context)
        .pushReplacementNamed('/results', arguments: result.id);
  }

  Future<bool> _confirmExit() async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave the lab?'),
        content: const Text('Your progress in this lab will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Stay'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    return leave ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final total = _lab.questions.length;
    final progress = (_index + (_checked ? 1 : 0)) / total;
    final correctSoFar = [
      for (var i = 0; i < _answers.length; i++)
        if (_lab.questions[i].isCorrect(_answers[i])) 1,
    ].length;

    return PopScope(
      canPop: _saving,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final navigator = Navigator.of(context);
        if (await _confirmExit()) navigator.pop();
      },
      child: Scaffold(
        backgroundColor: canvas,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 44, 18, 18),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [navy, Color(0xFF0C2B61)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(26),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _lab.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${_career.title} · ${_lab.level}',
                              style: const TextStyle(
                                color: Color(0xFFB5C8E8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formatDuration(_stopwatch.elapsed.inSeconds),
                              key: const Key('sim-timer'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Text(
                          'Question ${_index + 1} of $total',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '$correctSoFar correct',
                          style: const TextStyle(
                            color: Color(0xFF7CF2D7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(end: progress),
                        duration: const Duration(milliseconds: 400),
                        builder: (context, value, _) => LinearProgressIndicator(
                          value: value,
                          minHeight: 7,
                          backgroundColor: Colors.white.withValues(alpha: 0.15),
                          color: const Color(0xFF10D3D0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: ListView(
                  key: ValueKey(_index),
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                  children: [
                    if (_index == 0) ...[
                      _ScenarioCard(text: _lab.scenario),
                      const SizedBox(height: 14),
                    ],
                    Row(
                      children: [
                        ToolPill(_question.skill, icon: Icons.bolt),
                        const SizedBox(width: 6),
                        if (_question.isMultiple)
                          ToolPill(
                            'Select ${_question.correct.length} answers',
                            icon: Icons.checklist,
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _question.prompt,
                      style: const TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (var i = 0; i < _question.options.length; i++)
                      _OptionTile(
                        key: Key('option-$i'),
                        label: _question.options[i],
                        multiple: _question.isMultiple,
                        selected: _selected.contains(i),
                        state: !_checked
                            ? _OptionState.idle
                            : _question.correct.contains(i)
                            ? _OptionState.correct
                            : _selected.contains(i)
                            ? _OptionState.wrong
                            : _OptionState.idle,
                        onTap: () => _toggle(i),
                      ),
                    AnimatedOpacity(
                      opacity: _checked ? 1 : 0,
                      duration: const Duration(milliseconds: 350),
                      child: _checked
                          ? _FeedbackCard(
                              correct: _question.isCorrect(_selected),
                              explanation: _question.explanation,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 14),
                child: _saving
                    ? const SizedBox(
                        height: 50,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : GradientActionButton(
                        key: const Key('sim-action'),
                        label: !_checked
                            ? 'Check answer'
                            : _isLast
                            ? 'Finish lab'
                            : 'Next question',
                        icon: !_checked
                            ? Icons.check_rounded
                            : _isLast
                            ? Icons.flag_rounded
                            : Icons.arrow_forward_rounded,
                        onPressed: !_checked
                            ? (_selected.isEmpty ? null : _check)
                            : _next,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  const _ScenarioCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE8FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.assignment_outlined, color: purple, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Scenario',
                  style: TextStyle(color: purple, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(color: ink, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _OptionState { idle, correct, wrong }

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    super.key,
    required this.label,
    required this.multiple,
    required this.selected,
    required this.state,
    required this.onTap,
  });

  final String label;
  final bool multiple;
  final bool selected;
  final _OptionState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final (border, background, icon) = switch (state) {
      _OptionState.correct => (
        const Color(0xFF10A37F),
        const Color(0xFFE7F8F2),
        Icons.check_circle,
      ),
      _OptionState.wrong => (
        const Color(0xFFE5484D),
        const Color(0xFFFDECEC),
        Icons.cancel,
      ),
      _OptionState.idle => (
        selected ? purple : const Color(0xFFDDE7F8),
        selected ? const Color(0xFFF3F0FF) : Colors.white,
        multiple
            ? (selected ? Icons.check_box : Icons.check_box_outline_blank)
            : (selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked),
      ),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border, width: 1.6),
          ),
          child: Row(
            children: [
              Icon(icon, color: border, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({required this.correct, required this.explanation});

  final bool correct;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    final color = correct ? const Color(0xFF10A37F) : const Color(0xFFE5484D);
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                correct ? Icons.celebration : Icons.lightbulb_outline,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                correct ? 'Correct!' : 'Not quite',
                style: TextStyle(color: color, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            explanation,
            style: const TextStyle(color: ink, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }
}
