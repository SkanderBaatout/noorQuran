import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../widgets/islamic_star_pattern.dart';
import '../theme/app_theme.dart';

class PrayerModeScreen extends StatefulWidget {
  const PrayerModeScreen({super.key});

  @override
  State<PrayerModeScreen> createState() => _PrayerModeScreenState();
}

class _PrayerModeScreenState extends State<PrayerModeScreen> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed += const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    WakelockPlus.disable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  String _format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.inMinutes)}:${two(d.inSeconds % 60)}';
  }

  void _handleHorizontalDragEnd(DragEndDetails details) {
    // Swipe right to go back: check velocity is positive (rightward) and fast enough
    final velocity = details.primaryVelocity ?? 0;
    if (velocity > 300) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: AppColors.night,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragEnd: _handleHorizontalDragEnd,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IslamicStarPattern(size: 300, color: AppColors.brassLight, opacity: 0.08),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.self_improvement, size: 56, color: AppColors.brassLight),
                    const SizedBox(height: 20),
                    const Text(
                      'Mode prière',
                      style: TextStyle(
                        color: AppColors.offWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Écran silencieux · téléphone posé',
                      style: TextStyle(color: AppColors.offWhite.withValues(alpha: 0.6)),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      _format(_elapsed),
                      style: const TextStyle(
                        color: AppColors.offWhite,
                        fontSize: 40,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 24,
                  child: TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.check, color: AppColors.emeraldLight),
                    label: const Text(
                      'Terminer la prière',
                      style: TextStyle(color: AppColors.emeraldLight),
                    ),
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