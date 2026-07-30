import 'dart:math' as math;

class QiblaService {
  // Coordonnées de la Kaaba, La Mecque
  static const double _kaabaLat = 21.4225;
  static const double _kaabaLon = 39.8262;

  /// Calcule le cap (bearing) en degrés (0-360, 0 = Nord) entre la position
  /// de l'utilisateur et la Kaaba, en suivant le grand cercle (great-circle).
  double calculateQiblaBearing({
    required double userLat,
    required double userLon,
  }) {
    final lat1 = _toRadians(userLat);
    final lat2 = _toRadians(_kaabaLat);
    final deltaLon = _toRadians(_kaabaLon - userLon);

    final y = math.sin(deltaLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(deltaLon);

    final bearingRad = math.atan2(y, x);
    final bearingDeg = _toDegrees(bearingRad);

    // Normaliser entre 0 et 360
    return (bearingDeg + 360) % 360;
  }

  /// Distance approximative en kilomètres jusqu'à la Kaaba (formule haversine)
  double distanceToKaabaKm({
    required double userLat,
    required double userLon,
  }) {
    const earthRadiusKm = 6371.0;
    final dLat = _toRadians(_kaabaLat - userLat);
    final dLon = _toRadians(_kaabaLon - userLon);
    final lat1 = _toRadians(userLat);
    final lat2 = _toRadians(_kaabaLat);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.sin(dLon / 2) * math.sin(dLon / 2) * math.cos(lat1) * math.cos(lat2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadiusKm * c;
  }

  double _toRadians(double degrees) => degrees * math.pi / 180;
  double _toDegrees(double radians) => radians * 180 / math.pi;
}
