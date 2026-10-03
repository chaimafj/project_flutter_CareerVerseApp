import 'package:flutter/material.dart';

import '../widgets/career_ui.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF041332), Color(0xFF082B69), Color(0xFF070F30)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                Positioned(
                  left: -100,
                  right: -100,
                  bottom: 90,
                  height: constraints.maxHeight * .43,
                  child: const _FutureCity(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(26, 36, 26, 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      const CareerLogo(dark: true),
                      const SizedBox(height: 18),
                      const Text(
                        'Explore  ·  Learn  ·  Build\nYour Future',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFDCEAFF),
                          height: 1.6,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 245,
                        child: Stack(
                          alignment: Alignment.center,
                          children: const [
                            _SkillTile(
                              icon: Icons.cloud_queue_rounded,
                              title: 'Cloud',
                              color: Color(0xFF1ABEFF),
                              alignment: Alignment(-.63, -.85),
                            ),
                            _SkillTile(
                              icon: Icons.verified_user_outlined,
                              title: 'Cybersecurity',
                              color: Color(0xFF18D2B4),
                              alignment: Alignment(.65, -.8),
                            ),
                            _SkillTile(
                              icon: Icons.settings_outlined,
                              title: 'DevOps',
                              color: Color(0xFF974BFF),
                              alignment: Alignment(-.84, .35),
                            ),
                            _SkillTile(
                              icon: Icons.code_rounded,
                              title: 'Backend',
                              color: Color(0xFFE63DCE),
                              alignment: Alignment(.84, .32),
                            ),
                            Positioned(
                              bottom: 8,
                              child: Icon(
                                Icons.person,
                                size: 114,
                                color: Color(0xFF06142C),
                                shadows: [
                                  Shadow(
                                    color: Color(0xFF51BEFF),
                                    blurRadius: 26,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GradientActionButton(
                        label: 'Get Started',
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/register'),
                      ),
                      const SizedBox(height: 14),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/login'),
                        child: const Text.rich(
                          TextSpan(
                            style: TextStyle(color: Color(0xFFB7C9E8)),
                            children: [
                              TextSpan(text: 'Already have an account?   '),
                              TextSpan(
                                text: 'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillTile extends StatelessWidget {
  const _SkillTile({
    required this.icon,
    required this.title,
    required this.color,
    required this.alignment,
  });

  final IconData icon;
  final String title;
  final Color color;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          color: color.withValues(alpha: .16),
          border: Border.all(color: color.withValues(alpha: .85), width: 1.5),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: .28), blurRadius: 20),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 7),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _FutureCity extends StatelessWidget {
  const _FutureCity();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _CityPainter(), child: const SizedBox.expand());
  }
}

class _CityPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final skyline = [
      Rect.fromLTWH(size.width * .05, size.height * .52, 46, size.height * .48),
      Rect.fromLTWH(size.width * .16, size.height * .37, 54, size.height * .63),
      Rect.fromLTWH(size.width * .29, size.height * .49, 43, size.height * .51),
      Rect.fromLTWH(size.width * .39, size.height * .25, 52, size.height * .75),
      Rect.fromLTWH(size.width * .52, size.height * .43, 54, size.height * .57),
      Rect.fromLTWH(size.width * .65, size.height * .32, 48, size.height * .68),
      Rect.fromLTWH(size.width * .77, size.height * .48, 54, size.height * .52),
      Rect.fromLTWH(size.width * .9, size.height * .35, 48, size.height * .65),
    ];
    for (var i = 0; i < skyline.length; i++) {
      paint.color = i.isEven
          ? const Color(0xFF1454B4).withValues(alpha: .58)
          : const Color(0xFF22225F).withValues(alpha: .78);
      canvas.drawRRect(
        RRect.fromRectAndRadius(skyline[i], const Radius.circular(8)),
        paint,
      );
      paint.color = const Color(0xFF60D8FF).withValues(alpha: .56);
      for (var row = 0; row < 4; row++) {
        for (var col = 0; col < 2; col++) {
          final x = skyline[i].left + 12 + col * 18;
          final y = skyline[i].top + 18 + row * 22;
          canvas.drawRect(Rect.fromLTWH(x, y, 4, 6), paint);
        }
      }
    }
    paint.shader = const LinearGradient(
      colors: [Color(0x007C4DFF), Color(0xCC20AFFF), Color(0x007C4DFF)],
    ).createShader(Rect.fromLTWH(0, size.height * .85, size.width, 20));
    canvas.drawRect(Rect.fromLTWH(0, size.height * .85, size.width, 20), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
