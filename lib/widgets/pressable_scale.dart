import 'package:flutter/material.dart';

/// Enveloppe n'importe quel widget (bouton, carte, item de liste, icône de
/// navigation...) pour lui donner un retour tactile vivant : le widget
/// rétrécit légèrement pendant l'appui, puis reprend sa taille normale
/// au relâchement, avec un léger rebond.
///
/// Usage :
/// ```dart
/// PressableScale(
///   onTap: () => print('tap'),
///   child: MyButton(),
/// )
/// ```
class PressableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double pressedScale;
  final Duration duration;

  const PressableScale({
    super.key,
    required this.child,
    this.onTap,
    this.pressedScale = 0.93,
    this.duration = const Duration(milliseconds: 110),
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value && mounted) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapCancel: () => _setPressed(false),
      onTapUp: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? widget.pressedScale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

/// Fait apparaître son enfant avec un léger fondu + glissement vers le haut.
/// Pratique pour animer l'arrivée des éléments d'une liste (cartes de
/// sourates, de douas, etc.) sans dépendance externe.
class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final int index;
  final Duration baseDelay;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.index = 0,
    this.baseDelay = const Duration(milliseconds: 40),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 350 + (index * 25).clamp(0, 300)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 16),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
