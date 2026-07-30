import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Centralise les préférences de l'utilisateur : thème, langue, rappel
/// quotidien. Persistées via SharedPreferences et exposées à toute
/// l'application via Provider.
class AppSettings extends ChangeNotifier {
  static const _keyThemeMode = 'theme_mode';
  static const _keyLocale = 'locale';
  static const _keyReminderEnabled = 'reminder_enabled';
  static const _keyReminderHour = 'reminder_hour';
  static const _keyReminderMinute = 'reminder_minute';
  static const _keyAdhanEnabled = 'adhan_enabled';
  static const _keyAdhkarEnabled = 'adhkar_enabled';

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('fr');
  bool _reminderEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 7, minute: 0);
  bool _adhanEnabled = false;
  bool _adhkarEnabled = false;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get reminderEnabled => _reminderEnabled;
  TimeOfDay get reminderTime => _reminderTime;
  bool get adhanEnabled => _adhanEnabled;
  bool get adhkarEnabled => _adhkarEnabled;

  bool get isRtl => _locale.languageCode == 'ar';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final themeStr = prefs.getString(_keyThemeMode);
    _themeMode = switch (themeStr) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    final localeStr = prefs.getString(_keyLocale);
    if (localeStr != null) _locale = Locale(localeStr);

    _reminderEnabled = prefs.getBool(_keyReminderEnabled) ?? false;
    _reminderTime = TimeOfDay(
      hour: prefs.getInt(_keyReminderHour) ?? 7,
      minute: prefs.getInt(_keyReminderMinute) ?? 0,
    );
    _adhanEnabled = prefs.getBool(_keyAdhanEnabled) ?? false;
    _adhkarEnabled = prefs.getBool(_keyAdhkarEnabled) ?? false;

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, mode.name);
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, locale.languageCode);
  }

  Future<void> setReminderEnabled(bool enabled) async {
    _reminderEnabled = enabled;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyReminderEnabled, enabled);
  }

  Future<void> setReminderTime(TimeOfDay time) async {
    _reminderTime = time;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyReminderHour, time.hour);
    await prefs.setInt(_keyReminderMinute, time.minute);
  }

  Future<void> setAdhanEnabled(bool enabled) async {
    _adhanEnabled = enabled;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAdhanEnabled, enabled);
  }

  Future<void> setAdhkarEnabled(bool enabled) async {
    _adhkarEnabled = enabled;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAdhkarEnabled, enabled);
  }
}
