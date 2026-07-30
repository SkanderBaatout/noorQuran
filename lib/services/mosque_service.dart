import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/mosque.dart';

class MosqueService {
  static const _overpassUrl = 'https://overpass-api.de/api/interpreter';

  /// Cherche les mosquées dans un rayon donné (mètres) autour du point
  Future<List<Mosque>> getNearbyMosques({
    required double lat,
    required double lon,
    int radiusMeters = 5000,
  }) async {
    // Requête Overpass QL : lieux de culte musulmans (nœuds + voies)
    final query = '''
      [out:json][timeout:25];
      (
        node["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lon);
        way["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lon);
      );
      out center;
    ''';

    final res = await http.post(
      Uri.parse(_overpassUrl),
      // L'API Overpass (comme la plupart des services OpenStreetMap) rejette
      // les requêtes sans en-tête User-Agent explicite avec une erreur 429
      // "Please include a meaningful User-Agent string...". Le client HTTP
      // Dart n'envoie pas de User-Agent utile par défaut, d'où l'erreur.
      headers: const {
        'User-Agent': 'NoorQuranApp/1.0 (contact: support@noorquran.app)',
      },
      body: {'data': query},
    );

    if (res.statusCode == 429) {
      throw Exception(
          'Trop de requêtes vers le service de cartes. Réessaie dans quelques instants.');
    }
    if (res.statusCode != 200) {
      throw Exception('Erreur lors de la recherche des mosquées');
    }

    final data = jsonDecode(res.body);
    final List elements = data['elements'];

    final mosques = <Mosque>[];
    for (final el in elements) {
      final double mlat = el['lat'] ?? el['center']?['lat'];
      final double mlon = el['lon'] ?? el['center']?['lon'];
      if (mlat == null || mlon == null) continue;

      final name = el['tags']?['name'] ?? '';
      final distance = Geolocator.distanceBetween(lat, lon, mlat, mlon);

      mosques.add(Mosque(
        name: name,
        lat: mlat,
        lon: mlon,
        distanceMeters: distance,
      ));
    }

    mosques.sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));
    return mosques;
  }
}