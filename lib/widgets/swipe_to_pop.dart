import 'package:flutter/material.dart';

/// Enveloppe un écran poussé sur la pile de navigation (Navigator.push) pour
/// permettre de le fermer avec un glissement horizontal vers la droite,
/// en plus du bouton retour habituel.
///
/// Utilisation :
/// ```dart
/// return SwipeToPop(
///   child: Scaffold(...),
/// );
/// ```
///
/// La détection se base sur la vélocité du glissement (comme dans
/// [PrayerModeScreen]) plutôt que sur la distance, ce qui la rend fiable même
/// pour un glissement rapide et court.
class SwipeToPop extends StatelessWidget {
  final Widget child;

  /// Vélocité minimale (en pixels/seconde) pour considérer le geste comme un
  /// swipe volontaire plutôt qu'un simple défilement accidentel.
  final double velocityThreshold;

  const SwipeToPop({
    super.key,
    required this.child,
    this.velocityThreshold = 300,
  });

  void _handleHorizontalDragEnd(BuildContext context, DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    // Vélocité positive = glissement vers la droite.
    if (velocity > velocityThreshold) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (details) => _handleHorizontalDragEnd(context, details),
      child: child,
    );
  }
}
