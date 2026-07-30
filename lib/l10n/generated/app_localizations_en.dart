// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Noor Quran';

  @override
  String get navQuran => 'Quran';

  @override
  String get navPrayer => 'Prayer';

  @override
  String get navQibla => 'Qibla';

  @override
  String get navMosques => 'Mosques';

  @override
  String get menuTasbih => 'Tasbih';

  @override
  String get menuHijri => 'Hijri Calendar';

  @override
  String get menuPrayerMode => 'Prayer Mode';

  @override
  String get menuDuaa => 'Duas';

  @override
  String get menuSettings => 'Settings';

  @override
  String get quranTitle => 'The Holy Quran';

  @override
  String get prayerTitle => 'Prayer Times';

  @override
  String get qiblaTitle => 'Qibla Direction';

  @override
  String get mosquesTitle => 'Nearby Mosques';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTheme => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsDailyReminder => 'Daily reminder';

  @override
  String get settingsDailyReminderSubtitle => 'Get a notification every day';

  @override
  String get settingsReminderTime => 'Reminder time';

  @override
  String get settingsAdhan => 'Adhan';

  @override
  String get settingsAdhanSubtitle => 'Get notified at every prayer time';

  @override
  String get settingsAdhkar => 'Morning and evening Adhkars';

  @override
  String get settingsAdhkarSubtitle => 'Reminder at 6:00 AM and 6:00 PM';

  @override
  String get tasbihTitle => 'Tasbih';

  @override
  String get tasbihReset => 'Reset';

  @override
  String get tasbihTarget => 'Target';

  @override
  String get tasbihCount => 'Count';

  @override
  String get hijriTitle => 'Hijri Calendar';

  @override
  String get hijriToday => 'Today';

  @override
  String get hijriUpcoming => 'Upcoming important dates';

  @override
  String get prayerModeTitle => 'Prayer Mode';

  @override
  String get prayerModeSubtitle => 'Silent screen during your prayer';

  @override
  String get prayerModeExit => 'End prayer';

  @override
  String get retry => 'Retry';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get searchSurah => 'Search a surah (e.g. Al-Fatiha, Al-Ikhlas)';

  @override
  String get searchNoResults => 'No surah found';

  @override
  String get tasbihTapToCount => 'Tap the circle to count';

  @override
  String tasbihTotal(int count) {
    return 'Total count: $count';
  }

  @override
  String get mosqueEmpty => 'No mosque found nearby.';

  @override
  String get mosqueNoName => 'Unnamed mosque';

  @override
  String get toggleTranslationTooltip => 'Show/hide translation';

  @override
  String get qiblaCompassUnavailable =>
      'The compass sensor is not available on this device.';

  @override
  String get qiblaAligned => '✅ Aligned with the Qibla';

  @override
  String get qiblaTurnTowards => 'Turn towards the Qibla';

  @override
  String qiblaDistance(String km) {
    return 'Distance to the Kaaba: $km km';
  }

  @override
  String get qiblaInstructions =>
      'Hold your phone flat. The 🕋 icon points to the Kaaba.';

  @override
  String get hijriEventNewYear => 'Islamic New Year (Muharram)';

  @override
  String get hijriEventAshura => 'Ashura';

  @override
  String get hijriEventMawlid => 'Mawlid (birth of the Prophet ﷺ)';

  @override
  String get hijriEventRamadanStart => 'Start of Ramadan';

  @override
  String get hijriEventLaylatAlQadr => 'Laylat al-Qadr (estimate, 27th night)';

  @override
  String get hijriEventEidAlFitr => 'Eid al-Fitr';

  @override
  String get hijriEventDayOfArafah => 'Day of Arafah';

  @override
  String get hijriEventEidAlAdha => 'Eid al-Adha';
}
