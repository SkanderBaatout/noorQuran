import 'package:shared_preferences/shared_preferences.dart';

class TasbihService {
  static const _keyCount = 'tasbih_count';
  static const _keyPhraseIndex = 'tasbih_phrase_index';
  static const _keyTarget = 'tasbih_target';
  static const _keyTotalAllTime = 'tasbih_total_all_time';

  Future<Map<String, int>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'count': prefs.getInt(_keyCount) ?? 0,
      'phraseIndex': prefs.getInt(_keyPhraseIndex) ?? 0,
      'target': prefs.getInt(_keyTarget) ?? 33,
      'totalAllTime': prefs.getInt(_keyTotalAllTime) ?? 0,
    };
  }

  Future<void> save({
    required int count,
    required int phraseIndex,
    required int target,
    required int totalAllTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCount, count);
    await prefs.setInt(_keyPhraseIndex, phraseIndex);
    await prefs.setInt(_keyTarget, target);
    await prefs.setInt(_keyTotalAllTime, totalAllTime);
  }
}

class DhikrPhrase {
  final String arabic;
  final String transliteration;
  final String meaningFr;
  const DhikrPhrase(this.arabic, this.transliteration, this.meaningFr);
}

const dhikrPhrases = [
  DhikrPhrase('سُبْحَانَ اللَّهِ', 'SubhanAllah', 'Gloire à Dieu'),
  DhikrPhrase('الْحَمْدُ لِلَّهِ', 'Alhamdulillah', 'Louange à Dieu'),
  DhikrPhrase('اللَّهُ أَكْبَرُ', 'Allahu Akbar', 'Dieu est le plus grand'),
  DhikrPhrase('لَا إِلَٰهَ إِلَّا اللَّهُ', 'La ilaha illa Allah',
      "Il n'y a de divinité que Dieu"),
  DhikrPhrase('أَسْتَغْفِرُ اللَّهَ', 'Astaghfirullah', 'Je demande pardon à Dieu'),
  DhikrPhrase('لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ', 'La hawla wala quwwata illa billah',
      "Il n'y a de force ni de puissance qu'en Dieu"),
];
