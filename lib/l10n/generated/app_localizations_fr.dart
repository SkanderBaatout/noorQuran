// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Noor Quran';

  @override
  String get navQuran => 'Coran';

  @override
  String get navPrayer => 'Salat';

  @override
  String get navQibla => 'Qibla';

  @override
  String get navMosques => 'Mosquées';

  @override
  String get menuTasbih => 'Tasbih';

  @override
  String get menuHijri => 'Calendrier Hijri';

  @override
  String get menuPrayerMode => 'Mode prière';

  @override
  String get menuDuaa => 'Douas';

  @override
  String get menuSettings => 'Réglages';

  @override
  String get quranTitle => 'Le Saint Coran';

  @override
  String get prayerTitle => 'Horaires de salat';

  @override
  String get qiblaTitle => 'Direction de la Qibla';

  @override
  String get mosquesTitle => 'Mosquées à proximité';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsTheme => 'Apparence';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsDailyReminder => 'Rappel quotidien';

  @override
  String get settingsDailyReminderSubtitle =>
      'Reçois une notification chaque jour';

  @override
  String get settingsReminderTime => 'Heure du rappel';

  @override
  String get settingsAdhan => 'Adhan';

  @override
  String get settingsAdhanSubtitle =>
      'Reçois une notification à chaque heure de prière';

  @override
  String get settingsAdhkar => 'Adhkars du matin et du soir';

  @override
  String get settingsAdhkarSubtitle => 'Rappel à 6h00 et 18h00';

  @override
  String get tasbihTitle => 'Tasbih';

  @override
  String get tasbihReset => 'Réinitialiser';

  @override
  String get tasbihTarget => 'Objectif';

  @override
  String get tasbihCount => 'Compte';

  @override
  String get hijriTitle => 'Calendrier Hijri';

  @override
  String get hijriToday => 'Aujourd\'hui';

  @override
  String get hijriUpcoming => 'Dates importantes à venir';

  @override
  String get prayerModeTitle => 'Mode prière';

  @override
  String get prayerModeSubtitle => 'Écran silencieux pendant ta prière';

  @override
  String get prayerModeExit => 'Terminer la prière';

  @override
  String get retry => 'Réessayer';

  @override
  String get errorGeneric => 'Une erreur est survenue';

  @override
  String get searchSurah => 'Rechercher une sourate (ex. Al-Fatiha, Al-Ikhlas)';

  @override
  String get searchNoResults => 'Aucune sourate trouvée';

  @override
  String get tasbihTapToCount => 'Touche le cercle pour compter';

  @override
  String tasbihTotal(int count) {
    return 'Total cumulé : $count';
  }

  @override
  String get mosqueEmpty => 'Aucune mosquée trouvée à proximité.';

  @override
  String get mosqueNoName => 'Mosquée sans nom';

  @override
  String get toggleTranslationTooltip => 'Afficher/masquer la traduction';

  @override
  String get qiblaCompassUnavailable =>
      'Le capteur boussole n\'est pas disponible sur cet appareil.';

  @override
  String get qiblaAligned => '✅ Aligné avec la Qibla';

  @override
  String get qiblaTurnTowards => 'Tourne-toi vers la Qibla';

  @override
  String qiblaDistance(String km) {
    return 'Distance jusqu\'à la Kaaba : $km km';
  }

  @override
  String get qiblaInstructions =>
      'Tiens ton téléphone à plat. L\'icône 🕋 pointe vers la Kaaba.';

  @override
  String get hijriEventNewYear => 'Nouvel An Hijri (Muharram)';

  @override
  String get hijriEventAshura => 'Achoura';

  @override
  String get hijriEventMawlid => 'Mawlid (naissance du Prophète ﷺ)';

  @override
  String get hijriEventRamadanStart => 'Début du Ramadan';

  @override
  String get hijriEventLaylatAlQadr => 'Laylat al-Qadr (estimation, 27ᵉ nuit)';

  @override
  String get hijriEventEidAlFitr => 'Aïd al-Fitr';

  @override
  String get hijriEventDayOfArafah => 'Journée d\'Arafat';

  @override
  String get hijriEventEidAlAdha => 'Aïd al-Adha';
}
