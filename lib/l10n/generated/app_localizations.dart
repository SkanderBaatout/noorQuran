import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appName.
  ///
  /// In fr, this message translates to:
  /// **'Noor Quran'**
  String get appName;

  /// No description provided for @navQuran.
  ///
  /// In fr, this message translates to:
  /// **'Coran'**
  String get navQuran;

  /// No description provided for @navPrayer.
  ///
  /// In fr, this message translates to:
  /// **'Salat'**
  String get navPrayer;

  /// No description provided for @navQibla.
  ///
  /// In fr, this message translates to:
  /// **'Qibla'**
  String get navQibla;

  /// No description provided for @navMosques.
  ///
  /// In fr, this message translates to:
  /// **'Mosquées'**
  String get navMosques;

  /// No description provided for @menuTasbih.
  ///
  /// In fr, this message translates to:
  /// **'Tasbih'**
  String get menuTasbih;

  /// No description provided for @menuHijri.
  ///
  /// In fr, this message translates to:
  /// **'Calendrier Hijri'**
  String get menuHijri;

  /// No description provided for @menuPrayerMode.
  ///
  /// In fr, this message translates to:
  /// **'Mode prière'**
  String get menuPrayerMode;

  /// No description provided for @menuDuaa.
  ///
  /// In fr, this message translates to:
  /// **'Douas'**
  String get menuDuaa;

  /// No description provided for @menuSettings.
  ///
  /// In fr, this message translates to:
  /// **'Réglages'**
  String get menuSettings;

  /// No description provided for @quranTitle.
  ///
  /// In fr, this message translates to:
  /// **'Le Saint Coran'**
  String get quranTitle;

  /// No description provided for @prayerTitle.
  ///
  /// In fr, this message translates to:
  /// **'Horaires de salat'**
  String get prayerTitle;

  /// No description provided for @qiblaTitle.
  ///
  /// In fr, this message translates to:
  /// **'Direction de la Qibla'**
  String get qiblaTitle;

  /// No description provided for @mosquesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mosquées à proximité'**
  String get mosquesTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Réglages'**
  String get settingsTitle;

  /// No description provided for @settingsTheme.
  ///
  /// In fr, this message translates to:
  /// **'Apparence'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get themeDark;

  /// No description provided for @settingsLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsLanguage;

  /// No description provided for @settingsDailyReminder.
  ///
  /// In fr, this message translates to:
  /// **'Rappel quotidien'**
  String get settingsDailyReminder;

  /// No description provided for @settingsDailyReminderSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Reçois une notification chaque jour'**
  String get settingsDailyReminderSubtitle;

  /// No description provided for @settingsReminderTime.
  ///
  /// In fr, this message translates to:
  /// **'Heure du rappel'**
  String get settingsReminderTime;

  /// No description provided for @settingsAdhan.
  ///
  /// In fr, this message translates to:
  /// **'Adhan'**
  String get settingsAdhan;

  /// No description provided for @settingsAdhanSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Reçois une notification à chaque heure de prière'**
  String get settingsAdhanSubtitle;

  /// No description provided for @settingsAdhkar.
  ///
  /// In fr, this message translates to:
  /// **'Adhkars du matin et du soir'**
  String get settingsAdhkar;

  /// No description provided for @settingsAdhkarSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Rappel à 6h00 et 18h00'**
  String get settingsAdhkarSubtitle;

  /// No description provided for @tasbihTitle.
  ///
  /// In fr, this message translates to:
  /// **'Tasbih'**
  String get tasbihTitle;

  /// No description provided for @tasbihReset.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser'**
  String get tasbihReset;

  /// No description provided for @tasbihTarget.
  ///
  /// In fr, this message translates to:
  /// **'Objectif'**
  String get tasbihTarget;

  /// No description provided for @tasbihCount.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get tasbihCount;

  /// No description provided for @hijriTitle.
  ///
  /// In fr, this message translates to:
  /// **'Calendrier Hijri'**
  String get hijriTitle;

  /// No description provided for @hijriToday.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui'**
  String get hijriToday;

  /// No description provided for @hijriUpcoming.
  ///
  /// In fr, this message translates to:
  /// **'Dates importantes à venir'**
  String get hijriUpcoming;

  /// No description provided for @prayerModeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mode prière'**
  String get prayerModeTitle;

  /// No description provided for @prayerModeSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Écran silencieux pendant ta prière'**
  String get prayerModeSubtitle;

  /// No description provided for @prayerModeExit.
  ///
  /// In fr, this message translates to:
  /// **'Terminer la prière'**
  String get prayerModeExit;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @errorGeneric.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue'**
  String get errorGeneric;

  /// No description provided for @searchSurah.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher une sourate (ex. Al-Fatiha, Al-Ikhlas)'**
  String get searchSurah;

  /// No description provided for @searchNoResults.
  ///
  /// In fr, this message translates to:
  /// **'Aucune sourate trouvée'**
  String get searchNoResults;

  /// No description provided for @tasbihTapToCount.
  ///
  /// In fr, this message translates to:
  /// **'Touche le cercle pour compter'**
  String get tasbihTapToCount;

  /// No description provided for @tasbihTotal.
  ///
  /// In fr, this message translates to:
  /// **'Total cumulé : {count}'**
  String tasbihTotal(int count);

  /// No description provided for @mosqueEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune mosquée trouvée à proximité.'**
  String get mosqueEmpty;

  /// No description provided for @mosqueNoName.
  ///
  /// In fr, this message translates to:
  /// **'Mosquée sans nom'**
  String get mosqueNoName;

  /// No description provided for @toggleTranslationTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Afficher/masquer la traduction'**
  String get toggleTranslationTooltip;

  /// No description provided for @qiblaCompassUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'Le capteur boussole n\'est pas disponible sur cet appareil.'**
  String get qiblaCompassUnavailable;

  /// No description provided for @qiblaAligned.
  ///
  /// In fr, this message translates to:
  /// **'✅ Aligné avec la Qibla'**
  String get qiblaAligned;

  /// No description provided for @qiblaTurnTowards.
  ///
  /// In fr, this message translates to:
  /// **'Tourne-toi vers la Qibla'**
  String get qiblaTurnTowards;

  /// No description provided for @qiblaDistance.
  ///
  /// In fr, this message translates to:
  /// **'Distance jusqu\'à la Kaaba : {km} km'**
  String qiblaDistance(String km);

  /// No description provided for @qiblaInstructions.
  ///
  /// In fr, this message translates to:
  /// **'Tiens ton téléphone à plat. L\'icône 🕋 pointe vers la Kaaba.'**
  String get qiblaInstructions;

  /// No description provided for @hijriEventNewYear.
  ///
  /// In fr, this message translates to:
  /// **'Nouvel An Hijri (Muharram)'**
  String get hijriEventNewYear;

  /// No description provided for @hijriEventAshura.
  ///
  /// In fr, this message translates to:
  /// **'Achoura'**
  String get hijriEventAshura;

  /// No description provided for @hijriEventMawlid.
  ///
  /// In fr, this message translates to:
  /// **'Mawlid (naissance du Prophète ﷺ)'**
  String get hijriEventMawlid;

  /// No description provided for @hijriEventRamadanStart.
  ///
  /// In fr, this message translates to:
  /// **'Début du Ramadan'**
  String get hijriEventRamadanStart;

  /// No description provided for @hijriEventLaylatAlQadr.
  ///
  /// In fr, this message translates to:
  /// **'Laylat al-Qadr (estimation, 27ᵉ nuit)'**
  String get hijriEventLaylatAlQadr;

  /// No description provided for @hijriEventEidAlFitr.
  ///
  /// In fr, this message translates to:
  /// **'Aïd al-Fitr'**
  String get hijriEventEidAlFitr;

  /// No description provided for @hijriEventDayOfArafah.
  ///
  /// In fr, this message translates to:
  /// **'Journée d\'Arafat'**
  String get hijriEventDayOfArafah;

  /// No description provided for @hijriEventEidAlAdha.
  ///
  /// In fr, this message translates to:
  /// **'Aïd al-Adha'**
  String get hijriEventEidAlAdha;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
