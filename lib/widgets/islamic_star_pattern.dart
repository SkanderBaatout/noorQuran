import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Élément signature de l'app : une étoile géométrique à 8 branches
/// (motif classique de l'art islamique, proche du symbole Rub el Hizb
/// utilisé dans les marges du Coran) redessinée en filigrane discret.
/// Utilisée comme fond décoratif (splash, écrans vides, en-têtes).
class IslamicStarPattern extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const IslamicStarPattern({
    super.key,
    this.size = 200,
    required this.color,
    this.opacity = 0.08,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: CustomPaint(
        size: Size(size, size),
        painter: _EightPointStarPainter(color: color),
      ),
    );
  }
}

class _EightPointStarPainter extends CustomPainter {
  final Color color;
  _EightPointStarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.012;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Deux carrés superposés tournés de 45° = étoile à 8 branches
    _drawRotatedSquare(canvas, paint, center, radius, 0);
    _drawRotatedSquare(canvas, paint, center, radius, math.pi / 4);

    // Cercle central
    canvas.drawCircle(center, radius * 0.55, paint);
  }

  void _drawRotatedSquare(
      Canvas canvas, Paint paint, Offset center, double radius, double rotation) {
    final path = Path();
    for (int i = 0; i < 4; i++) {
      final angle = rotation + (i * math.pi / 2) - math.pi / 4;
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _EightPointStarPainter oldDelegate) =>
      oldDelegate.color != color;
}
