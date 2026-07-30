class Surah {
  final int number;
  final String name; // nom arabe
  final String englishName;
  final String englishNameTranslation;
  final String revelationType; // Meccan / Medinan
  final int numberOfAyahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      revelationType: json['revelationType'],
      numberOfAyahs: json['numberOfAyahs'],
    );
  }
}

class Ayah {
  final int numberInSurah;
  final String text;
  final String? audioUrl;

  Ayah({required this.numberInSurah, required this.text, this.audioUrl});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      numberInSurah: json['numberInSurah'],
      text: json['text'],
      audioUrl: json['audio'],
    );
  }
}
