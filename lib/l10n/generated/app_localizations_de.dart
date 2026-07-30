// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Noor Quran';

  @override
  String get navQuran => 'Koran';

  @override
  String get navPrayer => 'Gebet';

  @override
  String get navQibla => 'Qibla';

  @override
  String get navMosques => 'Moscheen';

  @override
  String get menuTasbih => 'Tasbih';

  @override
  String get menuHijri => 'Hijri-Kalender';

  @override
  String get menuPrayerMode => 'Gebetsmodus';

  @override
  String get menuDuaa => 'Bittgebete';

  @override
  String get menuSettings => 'Einstellungen';

  @override
  String get quranTitle => 'Der Heilige Koran';

  @override
  String get prayerTitle => 'Gebetszeiten';

  @override
  String get qiblaTitle => 'Qibla-Richtung';

  @override
  String get mosquesTitle => 'Moscheen in der Nähe';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsTheme => 'Erscheinungsbild';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsDailyReminder => 'Tägliche Erinnerung';

  @override
  String get settingsDailyReminderSubtitle =>
      'Erhalte jeden Tag eine Benachrichtigung';

  @override
  String get settingsReminderTime => 'Erinnerungszeit';

  @override
  String get settingsAdhan => 'Adhan';

  @override
  String get settingsAdhanSubtitle =>
      'Erhalte eine Benachrichtigung zu jeder Gebetszeit';

  @override
  String get settingsAdhkar => 'Adhkar am Morgen und Abend';

  @override
  String get settingsAdhkarSubtitle => 'Erinnerung um 6:00 und 18:00 Uhr';

  @override
  String get tasbihTitle => 'Tasbih';

  @override
  String get tasbihReset => 'Zurücksetzen';

  @override
  String get tasbihTarget => 'Ziel';

  @override
  String get tasbihCount => 'Anzahl';

  @override
  String get hijriTitle => 'Hijri-Kalender';

  @override
  String get hijriToday => 'Heute';

  @override
  String get hijriUpcoming => 'Kommende wichtige Daten';

  @override
  String get prayerModeTitle => 'Gebetsmodus';

  @override
  String get prayerModeSubtitle => 'Stiller Bildschirm während deines Gebets';

  @override
  String get prayerModeExit => 'Gebet beenden';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get errorGeneric => 'Etwas ist schiefgelaufen';

  @override
  String get searchSurah => 'Sure suchen (z. B. Al-Fatiha, Al-Ikhlas)';

  @override
  String get searchNoResults => 'Keine Sure gefunden';

  @override
  String get tasbihTapToCount => 'Tippe auf den Kreis zum Zählen';

  @override
  String tasbihTotal(int count) {
    return 'Gesamtzahl: $count';
  }

  @override
  String get mosqueEmpty => 'Keine Moschee in der Nähe gefunden.';

  @override
  String get mosqueNoName => 'Moschee ohne Namen';

  @override
  String get toggleTranslationTooltip => 'Übersetzung anzeigen/ausblenden';

  @override
  String get qiblaCompassUnavailable =>
      'Der Kompasssensor ist auf diesem Gerät nicht verfügbar.';

  @override
  String get qiblaAligned => '✅ Auf die Qibla ausgerichtet';

  @override
  String get qiblaTurnTowards => 'Drehe dich zur Qibla';

  @override
  String qiblaDistance(String km) {
    return 'Entfernung zur Kaaba: $km km';
  }

  @override
  String get qiblaInstructions =>
      'Halte dein Telefon flach. Das 🕋-Symbol zeigt zur Kaaba.';

  @override
  String get hijriEventNewYear => 'Islamisches Neujahr (Muharram)';

  @override
  String get hijriEventAshura => 'Aschura';

  @override
  String get hijriEventMawlid => 'Mawlid (Geburt des Propheten ﷺ)';

  @override
  String get hijriEventRamadanStart => 'Beginn des Ramadan';

  @override
  String get hijriEventLaylatAlQadr => 'Laylat al-Qadr (Schätzung, 27. Nacht)';

  @override
  String get hijriEventEidAlFitr => 'Eid al-Fitr';

  @override
  String get hijriEventDayOfArafah => 'Tag von Arafat';

  @override
  String get hijriEventEidAlAdha => 'Eid al-Adha';
}
