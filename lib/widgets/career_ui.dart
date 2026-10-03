import 'package:flutter/material.dart';

const navy = Color(0xFF07183D);
const ink = Color(0xFF122650);
const mutedInk = Color(0xFF7586A8);
const canvas = Color(0xFFF4F7FD);
const purple = Color(0xFF633BFF);
const blue = Color(0xFF1677FF);

class CareerLogo extends StatelessWidget {
  const CareerLogo({super.key, this.compact = false, this.dark = false});

  final bool compact;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final mark = Container(
      width: compact ? 34 : 54,
      height: compact ? 34 : 54,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10D3D0), Color(0xFF1677FF), Color(0xFF8148FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(compact ? 11 : 18),
      ),
      child: Icon(
        Icons.all_inclusive_rounded,
        color: Colors.white,
        size: compact ? 26 : 42,
      ),
    );
    if (compact) return mark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: dark ? Colors.white : navy,
              fontWeight: FontWeight.w800,
              fontSize: 25,
              letterSpacing: -0.6,
            ),
            children: const [
              TextSpan(text: 'Career'),
              TextSpan(
                text: 'Verse',
                style: TextStyle(color: Color(0xFF3978F6)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GradientActionButton extends StatelessWidget {
  const GradientActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.arrow_forward_rounded,
    this.gradient,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: onPressed == null ? const Color(0xFFC9D3E6) : null,
          gradient: onPressed == null
              ? null
              : gradient ??
                    const LinearGradient(
                      colors: [purple, blue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: purple.withValues(alpha: 0.18),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: ink,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: blue,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
            child: Text(action!, style: const TextStyle(fontSize: 12)),
          ),
      ],
    );
  }
}

class ToolPill extends StatelessWidget {
  const ToolPill(this.label, {super.key, this.icon = Icons.circle});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: const Color(0xFF526B99)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF526B99),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreRing extends StatelessWidget {
  const ScoreRing({
    super.key,
    required this.score,
    this.size = 68,
    this.color = const Color(0xFF10BDAA),
    this.label,
    this.textColor = ink,
  });

  final int? score;
  final double size;
  final Color color;
  final String? label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: (score ?? 0) / 100),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => CircularProgressIndicator(
              value: value,
              strokeWidth: size / 10,
              backgroundColor: const Color(0xFFE6ECF7),
              color: color,
              strokeCap: StrokeCap.round,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  score == null ? '--' : '$score%',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: size / 4.6,
                  ),
                ),
                if (label != null)
                  Text(
                    label!,
                    style: TextStyle(color: mutedInk, fontSize: size / 9),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: const Color(0xFFEDE8FF),
            child: Icon(icon, color: purple, size: 32),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ink,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: mutedInk, fontSize: 13),
          ),
          if (action != null) ...[
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(backgroundColor: purple),
              child: Text(action!),
            ),
          ],
        ],
      ),
    );
  }
}

String formatDuration(int seconds) {
  final m = seconds ~/ 60;
  final s = seconds % 60;
  return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
}

String timeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inHours < 1) return '${diff.inMinutes} min ago';
  if (diff.inDays < 1) return '${diff.inHours} h ago';
  if (diff.inDays < 7) return '${diff.inDays} d ago';
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';
}

Color scoreColor(int score) {
  if (score >= 80) return const Color(0xFF10A37F);
  if (score >= 60) return const Color(0xFF1677FF);
  if (score >= 40) return const Color(0xFFF59E0B);
  return const Color(0xFFE5484D);
}

Color levelColor(String level) => switch (level) {
  'Beginner' => const Color(0xFF10A37F),
  'Intermediate' => const Color(0xFFF59E0B),
  _ => const Color(0xFFE5484D),
};
