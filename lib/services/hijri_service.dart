import 'package:hijri/hijri_calendar.dart';

/// Identifie une date islamique importante. On stocke une clé stable plutôt
/// qu'un nom déjà traduit : le nom affiché ne dépend ainsi plus d'une langue
/// figée (auparavant toujours en français, même en changeant la langue de
/// l'app) et se résout via AppLocalizations dans l'UI.
enum IslamicEventKey {
  hijriNewYear,
  ashura,
  mawlid,
  ramadanStart,
  laylatAlQadr,
  eidAlFitr,
  dayOfArafah,
  eidAlAdha,
}

class IslamicDate {
  final IslamicEventKey eventKey;
  final HijriCalendar hijri;
  IslamicDate(this.eventKey, this.hijri);

  DateTime get gregorian => hijri.hijriToGregorian(hijri.hYear, hijri.hMonth, hijri.hDay);
}

class HijriService {
  /// Date Hijri du jour
  HijriCalendar today() => HijriCalendar.now();

  /// Retourne les dates islamiques importantes pour l'année Hijri en cours,
  /// triées par ordre chronologique à partir d'aujourd'hui.
  /// Note : ce sont des dates calculées (méthode arithmétique), le début
  /// réel de chaque mois lunaire peut varier de +/-1 jour selon l'observation
  /// locale de la lune, notamment pour Ramadan et les deux Aïds.
  List<IslamicDate> upcomingImportantDates() {
    final now = HijriCalendar.now();
    final year = now.hYear;

    final candidates = <IslamicDate>[
      _dateFor(IslamicEventKey.hijriNewYear, year, 1, 1),
      _dateFor(IslamicEventKey.ashura, year, 1, 10),
      _dateFor(IslamicEventKey.mawlid, year, 3, 12),
      _dateFor(IslamicEventKey.ramadanStart, year, 9, 1),
      _dateFor(IslamicEventKey.laylatAlQadr, year, 9, 27),
      _dateFor(IslamicEventKey.eidAlFitr, year, 10, 1),
      _dateFor(IslamicEventKey.dayOfArafah, year, 12, 9),
      _dateFor(IslamicEventKey.eidAlAdha, year, 12, 10),
    ];

    // Filtrer celles déjà passées cette année, en ajoutant l'année suivante
    // si nécessaire pour garder une liste toujours "à venir".
    final nowGreg = DateTime.now();
    final result = <IslamicDate>[];
    for (final c in candidates) {
      if (c.gregorian.isBefore(DateTime(nowGreg.year, nowGreg.month, nowGreg.day))) {
        result.add(_dateFor(c.eventKey, year + 1, c.hijri.hMonth, c.hijri.hDay));
      } else {
        result.add(c);
      }
    }

    result.sort((a, b) => a.gregorian.compareTo(b.gregorian));
    return result;
  }

  IslamicDate _dateFor(IslamicEventKey eventKey, int year, int month, int day) {
    final cal = HijriCalendar()
      ..hYear = year
      ..hMonth = month
      ..hDay = day;
    return IslamicDate(eventKey, cal);
  }
}
