import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/surah.dart';

class QuranService {
  static const String _base = "https://api.alquran.cloud/v1";

  static const Duration _timeout = Duration(seconds: 15);

  /// ==========================
  /// Liste des sourates
  /// ==========================
  Future<List<Surah>> getSurahs() async {
    final response = await http
        .get(Uri.parse("$_base/surah"))
        .timeout(_timeout);

    if (response.statusCode != 200) {
      throw Exception("Impossible de charger les sourates.");
    }

    final json = jsonDecode(response.body);

    final List list = json["data"];

    return list.map((e) => Surah.fromJson(e)).toList();
  }

  /// ==========================
  /// Texte arabe
  /// ==========================
  Future<List<Ayah>> getSurahText(
      int number, {
        String edition = "quran-uthmani",
      }) async {
    final response = await http
        .get(
      Uri.parse(
        "$_base/surah/$number/$edition",
      ),
    )
        .timeout(_timeout);

    if (response.statusCode != 200) {
      throw Exception("Impossible de charger cette sourate.");
    }

    final json = jsonDecode(response.body);

    final List ayahs = json["data"]["ayahs"];

    return ayahs.map((e) => Ayah.fromJson(e)).toList();
  }

  /// ==========================
  /// Traductions
  /// ==========================

  static const Map<String, String> translationEditionByLanguage = {
    "fr": "fr.hamidullah",
    "en": "en.asad",
    "de": "de.aburida",
    "ar": "quran-uthmani",
  };

  Future<List<Ayah>> getSurahTranslation(
      int number, {
        String edition = "fr.hamidullah",
      }) {
    return getSurahText(
      number,
      edition: edition,
    );
  }

  static String editionForLanguage(String languageCode) {
    return translationEditionByLanguage[languageCode] ??
        "fr.hamidullah";
  }

  /// ===========================================================
  /// AUDIO
  ///
  /// NOTE : everyayah.com n'héberge que des fichiers par verset
  /// (ex. 001001.mp3 = sourate 1, verset 1), jamais un fichier par
  /// sourate entière. L'ancienne URL "001.mp3" renvoyait donc
  /// systématiquement une 404, provoquant l'erreur de lecture.
  /// On utilise le CDN "islamic.network" (même écosystème que
  /// api.alquran.cloud) qui sert bien un fichier MP3 par sourate
  /// complète, récité par Mishary Alafasy, en 128 kbps.
  /// ===========================================================

  String getSurahAudioUrl(
      int number,
      ) {
    return "https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/$number.mp3";
  }

  /// ===========================================================
  /// Vérifie si l'audio existe avant de lancer le lecteur
  /// ===========================================================

  Future<bool> audioExists(int number) async {
    try {
      final response = await http
          .head(
        Uri.parse(
          getSurahAudioUrl(number),
        ),
      )
          .timeout(_timeout);

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}