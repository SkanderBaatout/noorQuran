import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;
import '../models/prayer_times.dart';

/// Gère l'initialisation, la permission et la planification de toutes les
/// notifications de l'app pour la version 1.1 :
///
///  - Adhan (rappel des 5 prières)
///  - Lecture quotidienne du Coran
///  - Adhkars du matin et du soir
///
/// Chaque famille de notification a son propre canal Android et ses propres
/// ID, ce qui permet de les activer / désactiver indépendamment depuis les
/// réglages de l'app.
class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  /// Active le son d'Adhan personnalisé (voix du muezzin) au lieu du son de
  /// notification par défaut du système.
  ///
  /// Pour l'activer, ajoutez vos fichiers audio au projet :
  ///  - Android : `android/app/src/main/res/raw/adhan.mp3` (nom de fichier
  ///    exactement `adhan`, en minuscules, sans espace ni tiret — c'est une
  ///    contrainte des ressources Android).
  ///  - iOS : ajoutez `adhan.caf` (ou `.aiff`/`.wav`) au projet Xcode, dans
  ///    la target Runner ("Copy Bundle Resources").
  /// Tant que ces fichiers ne sont pas présents, laissez cette valeur à
  /// `false` : sinon Android ne trouvera pas la ressource et la
  /// planification de l'Adhan échouera.
  static const useCustomAdhanSound = false;

  // ---------------------------------------------------------------------
  // IDs de notifications
  // ---------------------------------------------------------------------
  // Adhan : un ID par prière
  static const idAdhanFajr = 1;
  static const idAdhanDhuhr = 2;
  static const idAdhanAsr = 3;
  static const idAdhanMaghrib = 4;
  static const idAdhanIsha = 5;

  // Rappel de lecture quotidienne du Coran
  static const idQuranDaily = 10;

  // Adhkars
  static const idAdhkarMorning = 20;
  static const idAdhkarEvening = 21;

  static const _adhanIds = [
    idAdhanFajr,
    idAdhanDhuhr,
    idAdhanAsr,
    idAdhanMaghrib,
    idAdhanIsha,
  ];

  static const _prayerLabels = {
    idAdhanFajr: 'Fajr',
    idAdhanDhuhr: 'Dhuhr',
    idAdhanAsr: 'Asr',
    idAdhanMaghrib: 'Maghrib',
    idAdhanIsha: 'Isha',
  };

  static const _reminderTitles = [
    'Un moment pour ton dhikr 🌙',
    'Ton verset du jour t\'attend 📖',
    'Prends un instant pour te reconnecter',
  ];

  // ---------------------------------------------------------------------
  // Initialisation & permissions
  // ---------------------------------------------------------------------
  Future<void> init() async {
    if (_initialized) return;
    tzdata.initializeTimeZones();

    // Important : par défaut, le package `timezone` considère le fuseau
    // local comme UTC tant qu'on ne lui indique pas explicitement le
    // fuseau de l'appareil. Sans ça, toutes les notifications (Adhan,
    // Adhkars, rappel Coran) seraient programmées à l'heure UTC au lieu de
    // l'heure locale de l'utilisateur.
    try {
      final currentTimeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
    } catch (_) {
      // Si la détection échoue (plateforme non supportée, etc.), on reste
      // sur UTC plutôt que de planter l'initialisation des notifications.
    }

    // IMPORTANT : Android exige une icône de notification monochrome dédiée
    // (silhouette blanche sur fond transparent), pas l'icône de lancement en
    // couleur. Utiliser '@mipmap/ic_launcher' ici provoque un
    // PlatformException(invalid_icon, ...) sur certains appareils/versions
    // d'Android, car ce n'est pas une ressource "drawable" de notification
    // valide. Les fichiers corrects existent déjà dans
    // android/app/src/main/res/drawable-*dpi/ic_stat_notify.png.
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _plugin.initialize(settings);
    _initialized = true;
  }

  Future<bool> requestPermission() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final iosImpl = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    final androidGranted = await androidImpl?.requestNotificationsPermission();
    final iosGranted = await iosImpl?.requestPermissions(alert: true, badge: true, sound: true);
    return (androidGranted ?? true) && (iosGranted ?? true);
  }

  // ---------------------------------------------------------------------
  // Adhan
  // ---------------------------------------------------------------------
  /// Planifie l'Adhan pour les 5 prières du jour.
  ///
  /// [prayerTimes] doit contenir une entrée par ID de prière
  /// (idAdhanFajr, idAdhanDhuhr, idAdhanAsr, idAdhanMaghrib, idAdhanIsha)
  /// avec l'heure exacte de la prière (calculée par votre service
  /// d'horaires de prière). Comme ces horaires changent chaque jour,
  /// appelez cette méthode une fois par jour (par ex. au lancement de
  /// l'app, ou via un job planifié) pour reprogrammer le lendemain.
  Future<void> scheduleAdhanForToday(Map<int, tz.TZDateTime> prayerTimes) async {
    await init();
    final now = tz.TZDateTime.now(tz.local);

    for (final id in _adhanIds) {
      final time = prayerTimes[id];
      if (time == null) continue;

      // On ignore les horaires déjà passés aujourd'hui plutôt que de les
      // décaler au lendemain, car un décalage silencieux serait trompeur :
      // mieux vaut simplement ne pas notifier une prière déjà passée.
      if (time.isBefore(now)) continue;

      final label = _prayerLabels[id] ?? 'Prière';
      await _plugin.zonedSchedule(
        id,
        'Adhan — $label',
        "C'est l'heure de la prière du $label 🕌",
        time,
        NotificationDetails(
          android: AndroidNotificationDetails(
            // Un canal Android est figé après sa première création (Android
            // ne permet pas de changer son son a posteriori) : on utilise un
            // ID de canal différent selon le son choisi, pour que basculer
            // useCustomAdhanSound crée un nouveau canal plutôt que de garder
            // l'ancien son silencieusement.
            useCustomAdhanSound ? 'adhan_channel_custom' : 'adhan_channel',
            'Adhan',
            channelDescription: 'Rappel de l\'heure de prière',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            sound: useCustomAdhanSound
                ? const RawResourceAndroidNotificationSound('adhan')
                : null,
            audioAttributesUsage: AudioAttributesUsage.alarm,
          ),
          iOS: DarwinNotificationDetails(
            interruptionLevel: InterruptionLevel.timeSensitive,
            sound: useCustomAdhanSound ? 'adhan.caf' : null,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  /// Convertit les horaires renvoyés par [PrayerService] (chaînes "HH:mm")
  /// et planifie l'Adhan des 5 prières du jour. C'est le point d'entrée à
  /// utiliser depuis l'UI (écran des prières / réglages) : il évite de
  /// manipuler les tz.TZDateTime à la main.
  Future<void> scheduleAdhanFromPrayerTimes(PrayerTimes times) async {
    await init();
    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime parse(String hhmm) {
      final parts = hhmm.split(':');
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
      return tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    }

    await scheduleAdhanForToday({
      idAdhanFajr: parse(times.fajr),
      idAdhanDhuhr: parse(times.dhuhr),
      idAdhanAsr: parse(times.asr),
      idAdhanMaghrib: parse(times.maghrib),
      idAdhanIsha: parse(times.isha),
    });
  }

  Future<void> cancelAdhan() async {
    await init();
    for (final id in _adhanIds) {
      await _plugin.cancel(id);
    }
  }

  // ---------------------------------------------------------------------
  // Lecture quotidienne du Coran
  // ---------------------------------------------------------------------
  /// Planifie (ou reprogramme) le rappel quotidien de lecture du Coran
  /// à l'heure donnée. Le verset / la traduction du jour est affiché à
  /// l'intérieur de l'app (voir QuranService) ; la notification se
  /// contente d'inviter à l'ouvrir.
  Future<void> scheduleDailyQuranReminder(TimeOfDay time) async {
    await init();
    await _plugin.cancel(idQuranDaily);

    final scheduled = _nextInstanceOf(time);
    final title = _reminderTitles[Random().nextInt(_reminderTitles.length)];

    await _plugin.zonedSchedule(
      idQuranDaily,
      title,
      "Ouvre l'app pour ton rappel spirituel du jour.",
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'quran_channel',
          'Lecture du Coran',
          channelDescription: 'Rappel quotidien de lecture du Coran',
          importance: Importance.defaultImportance,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelDailyQuranReminder() async {
    await init();
    await _plugin.cancel(idQuranDaily);
  }

  // ---------------------------------------------------------------------
  // Adhkars du matin et du soir
  // ---------------------------------------------------------------------
  /// Planifie le rappel des adhkars du matin (par défaut 06:00).
  Future<void> scheduleAdhkarMorning({
    TimeOfDay time = const TimeOfDay(hour: 6, minute: 0),
  }) async {
    await _scheduleAdhkar(
      id: idAdhkarMorning,
      time: time,
      title: 'Adhkars du matin ☀️',
      body: 'Commence ta journée avec tes invocations du matin.',
    );
  }

  /// Planifie le rappel des adhkars du soir (par défaut 18:00).
  Future<void> scheduleAdhkarEvening({
    TimeOfDay time = const TimeOfDay(hour: 18, minute: 0),
  }) async {
    await _scheduleAdhkar(
      id: idAdhkarEvening,
      time: time,
      title: 'Adhkars du soir 🌙',
      body: 'Prends un instant pour tes invocations du soir.',
    );
  }

  Future<void> _scheduleAdhkar({
    required int id,
    required TimeOfDay time,
    required String title,
    required String body,
  }) async {
    await init();
    await _plugin.cancel(id);

    final scheduled = _nextInstanceOf(time);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'adhkar_channel',
          'Adhkars',
          channelDescription: 'Rappel des adhkars du matin et du soir',
          importance: Importance.defaultImportance,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAdhkarMorning() async {
    await init();
    await _plugin.cancel(idAdhkarMorning);
  }

  Future<void> cancelAdhkarEvening() async {
    await init();
    await _plugin.cancel(idAdhkarEvening);
  }

  // ---------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------
  tz.TZDateTime _nextInstanceOf(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  // ---------------------------------------------------------------------
  // Rétrocompatibilité (ancienne API v1.0)
  // ---------------------------------------------------------------------
  @Deprecated('Utilisez scheduleDailyQuranReminder à la place')
  Future<void> scheduleDaily(TimeOfDay time) => scheduleDailyQuranReminder(time);

  @Deprecated('Utilisez cancelDailyQuranReminder à la place')
  Future<void> cancelDaily() => cancelDailyQuranReminder();
}