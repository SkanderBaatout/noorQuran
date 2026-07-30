import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/prayer_times.dart';

class PrayerService {
  static const _base = 'https://api.aladhan.com/v1';

  /// Demande la permission et retourne la position actuelle
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Le service de localisation est désactivé');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permission de localisation refusée');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Permission refusée définitivement. Active-la dans les paramètres.');
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
  }

  /// [method] méthode de calcul: 2 = Egyptian, 3 = Muslim World League,
  /// 4 = Umm al-Qura, 5 = Karachi ... (voir doc Aladhan)
  Future<PrayerTimes> getTodayTimings({
    required double lat,
    required double lon,
    int method = 3,
  }) async {
    final now = DateTime.now();
    final timestamp = (now.millisecondsSinceEpoch / 1000).round();
    final uri = Uri.parse(
      '$_base/timings/$timestamp?latitude=$lat&longitude=$lon&method=$method',
    );
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Erreur lors du chargement des horaires de salat');
    }
    final data = jsonDecode(res.body);
    return PrayerTimes.fromJson(data['data']);
  }
}
