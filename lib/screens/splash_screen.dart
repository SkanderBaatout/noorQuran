import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../settings/app_settings.dart';
import '../widgets/islamic_star_pattern.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entrance;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;

  late final AnimationController _glow; // slow looping pulse behind the logo

  final ValueNotifier<double> _progress = ValueNotifier<double>(0.0);

  static const _minSplashDuration = Duration(milliseconds: 1200);

  @override
  void initState() {
    super.initState();

    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    // Logo: 0 -> 60% of the timeline
    _logoFade = CurvedAnimation(
      parent: _entrance,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _entrance,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    // Title: 35% -> 100% of the timeline (slight overlap for fluidity)
    _titleFade = CurvedAnimation(
      parent: _entrance,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _entrance,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic),
    ));

    _glow = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final stopwatch = Stopwatch()..start();
    _entrance.forward();

    try {
      // Step 1: precache the logo so it never "pops in" mid fade.
      await precacheImage(
        const AssetImage('assets/images/logo_noor_quran.png'),
        context,
      );
      _progress.value = 0.35;

      // Step 2: load app settings.
      final settings = context.read<AppSettings>();
      await settings.load();
      _progress.value = 0.8;

      _progress.value = 1.0;
    } catch (e, st) {
      // Don't let a failed step strand the user on splash forever.
      debugPrint('Splash bootstrap error: $e\n$st');
    }

    final elapsed = stopwatch.elapsed;
    if (elapsed < _minSplashDuration) {
      await Future.delayed(_minSplashDuration - elapsed);
    }

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, animation, __) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      );
    }
  }
  @override
  void dispose() {
    _entrance.dispose();
    _glow.dispose();
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.night : AppColors.ivory;
    final accent = isDark ? AppColors.brassLight : AppColors.emerald;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              IslamicStarPattern(size: 320, color: accent, opacity: 0.06),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: SizedBox(
                        width: 176,
                        height: 176,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Soft pulsing glow behind the logo.
                            AnimatedBuilder(
                              animation: _glow,
                              builder: (context, child) {
                                final t = _glow.value; // 0 -> 1 -> 0
                                return Container(
                                  width: 150 + (t * 14),
                                  height: 150 + (t * 14),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: accent.withValues(
                                          alpha: 0.18 + (t * 0.12),
                                        ),
                                        blurRadius: 24 + (t * 16),
                                        spreadRadius: 2 + (t * 4),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            // Progress ring tracking real bootstrap progress.
                            ValueListenableBuilder<double>(
                              valueListenable: _progress,
                              builder: (context, value, _) {
                                return SizedBox(
                                  width: 160,
                                  height: 160,
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0, end: value),
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeOut,
                                    builder: (context, animatedValue, _) {
                                      return CircularProgressIndicator(
                                        value: animatedValue,
                                        strokeWidth: 2.5,
                                        backgroundColor:
                                        accent.withValues(alpha: 0.12),
                                        valueColor: AlwaysStoppedAnimation(
                                          accent.withValues(alpha: 0.8),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            // Logo itself.
                            ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.asset(
                                'assets/images/logo_noor_quran.png',
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _titleFade,
                    child: SlideTransition(
                      position: _titleSlide,
                      child: Text(
                        'Noor Quran',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: accent,
                          fontSize: 34,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}