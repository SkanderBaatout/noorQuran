class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String dateReadable;
  final String hijriDate;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.dateReadable,
    required this.hijriDate,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    final timings = json['timings'];
    final date = json['date'];
    return PrayerTimes(
      fajr: timings['Fajr'].toString().split(' ')[0],
      sunrise: timings['Sunrise'].toString().split(' ')[0],
      dhuhr: timings['Dhuhr'].toString().split(' ')[0],
      asr: timings['Asr'].toString().split(' ')[0],
      maghrib: timings['Maghrib'].toString().split(' ')[0],
      isha: timings['Isha'].toString().split(' ')[0],
      dateReadable: date['readable'],
      hijriDate:
          '${date['hijri']['day']} ${date['hijri']['month']['en']} ${date['hijri']['year']}',
    );
  }

  List<MapEntry<String, String>> asList() => [
        MapEntry('Fajr', fajr),
        MapEntry('Lever du soleil', sunrise),
        MapEntry('Dhuhr', dhuhr),
        MapEntry('Asr', asr),
        MapEntry('Maghrib', maghrib),
        MapEntry('Isha', isha),
      ];
}
