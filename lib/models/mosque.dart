class Mosque {
  final String name;
  final double lat;
  final double lon;
  final double distanceMeters;

  Mosque({
    required this.name,
    required this.lat,
    required this.lon,
    required this.distanceMeters,
  });

  String get distanceLabel {
    if (distanceMeters < 1000) {
      return '${distanceMeters.toStringAsFixed(0)} m';
    }
    return '${(distanceMeters / 1000).toStringAsFixed(1)} km';
  }
}
