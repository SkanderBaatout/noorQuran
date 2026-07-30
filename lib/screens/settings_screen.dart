import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/generated/app_localizations.dart';
import '../settings/app_settings.dart';
import '../services/notification_service.dart';
import '../services/prayer_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.settingsTitle)),
      body: ListView(
        children: [
          _SectionLabel(t.settingsTheme),
          RadioListTile<ThemeMode>(
            title: Text(t.themeSystem),
            value: ThemeMode.system,
            groupValue: settings.themeMode,
            onChanged: (v) => settings.setThemeMode(v!),
          ),
          RadioListTile<ThemeMode>(
            title: Text(t.themeLight),
            value: ThemeMode.light,
            groupValue: settings.themeMode,
            onChanged: (v) => settings.setThemeMode(v!),
          ),
          RadioListTile<ThemeMode>(
            title: Text(t.themeDark),
            value: ThemeMode.dark,
            groupValue: settings.themeMode,
            onChanged: (v) => settings.setThemeMode(v!),
          ),
          const Divider(),
          _SectionLabel(t.settingsLanguage),
          RadioListTile<Locale>(
            title: const Text('Français'),
            value: const Locale('fr'),
            groupValue: settings.locale,
            onChanged: (v) => settings.setLocale(v!),
          ),
          RadioListTile<Locale>(
            title: const Text('English'),
            value: const Locale('en'),
            groupValue: settings.locale,
            onChanged: (v) => settings.setLocale(v!),
          ),
          RadioListTile<Locale>(
            title: const Text('Deutsch'),
            value: const Locale('de'),
            groupValue: settings.locale,
            onChanged: (v) => settings.setLocale(v!),
          ),
          RadioListTile<Locale>(
            title: const Text('العربية'),
            value: const Locale('ar'),
            groupValue: settings.locale,
            onChanged: (v) => settings.setLocale(v!),
          ),
          const Divider(),
          _SectionLabel(t.settingsDailyReminder),
          SwitchListTile(
            title: Text(t.settingsDailyReminder),
            subtitle: Text(t.settingsDailyReminderSubtitle),
            value: settings.reminderEnabled,
            onChanged: (enabled) async {
              settings.setReminderEnabled(enabled);
              final service = NotificationService();
              if (enabled) {
                final granted = await service.requestPermission();
                if (granted) {
                  await service.scheduleDailyQuranReminder(settings.reminderTime);
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.errorGeneric)),
                  );
                }
              } else {
                await service.cancelDailyQuranReminder();
              }
            },
          ),
          ListTile(
            enabled: settings.reminderEnabled,
            title: Text(t.settingsReminderTime),
            trailing: Text(settings.reminderTime.format(context)),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: settings.reminderTime,
              );
              if (time != null) {
                settings.setReminderTime(time);
                if (settings.reminderEnabled) {
                  await NotificationService().scheduleDailyQuranReminder(time);
                }
              }
            },
          ),
          const Divider(),
          _SectionLabel(t.settingsAdhan),
          SwitchListTile(
            title: Text(t.settingsAdhan),
            subtitle: Text(t.settingsAdhanSubtitle),
            value: settings.adhanEnabled,
            onChanged: (enabled) async {
              settings.setAdhanEnabled(enabled);
              final service = NotificationService();
              if (enabled) {
                final granted = await service.requestPermission();
                if (!granted) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(t.errorGeneric)),
                    );
                  }
                  return;
                }
                try {
                  final position = await PrayerService().getCurrentPosition();
                  final times = await PrayerService().getTodayTimings(
                    lat: position.latitude,
                    lon: position.longitude,
                  );
                  await service.scheduleAdhanFromPrayerTimes(times);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(t.errorGeneric)),
                    );
                  }
                }
              } else {
                await service.cancelAdhan();
              }
            },
          ),
          const Divider(),
          _SectionLabel(t.settingsAdhkar),
          SwitchListTile(
            title: Text(t.settingsAdhkar),
            subtitle: Text(t.settingsAdhkarSubtitle),
            value: settings.adhkarEnabled,
            onChanged: (enabled) async {
              settings.setAdhkarEnabled(enabled);
              final service = NotificationService();
              if (enabled) {
                final granted = await service.requestPermission();
                if (granted) {
                  await service.scheduleAdhkarMorning();
                  await service.scheduleAdhkarEvening();
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.errorGeneric)),
                  );
                }
              } else {
                await service.cancelAdhkarMorning();
                await service.cancelAdhkarEvening();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontSize: 15, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
