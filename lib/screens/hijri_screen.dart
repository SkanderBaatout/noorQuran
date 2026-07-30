import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import '../l10n/generated/app_localizations.dart';
import '../services/hijri_service.dart';
import '../widgets/islamic_star_pattern.dart';
import '../widgets/swipe_to_pop.dart';

class HijriScreen extends StatelessWidget {
  const HijriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final service = HijriService();
    final today = service.today();
    final upcoming = service.upcomingImportantDates();
    final theme = Theme.of(context);

    return SwipeToPop(
      child: Scaffold(
        appBar: AppBar(title: Text(t.hijriTitle)),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _TodayCard(today: today),
            const SizedBox(height: 28),
            Text(t.hijriUpcoming,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18)),
            const SizedBox(height: 12),
            ...upcoming.map((d) => _UpcomingTile(date: d)),
          ],
        ),
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  final HijriCalendar today;
  const _TodayCard({required this.today});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // On utilise la langue actuellement sélectionnée dans l'app (et non plus
    // 'fr_FR' en dur) pour que la date grégorienne s'affiche bien en arabe,
    // allemand ou anglais quand l'utilisateur change de langue.
    final localeName = Localizations.localeOf(context).languageCode;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: IslamicStarPattern(
              size: 140,
              color: Colors.white,
              opacity: isDark ? 0.10 : 0.14,
            ),
          ),
          Column(
            children: [
              Text(t.hijriToday,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.white.withValues(alpha: 0.85))),
              const SizedBox(height: 8),
              Text(
                '${today.hDay} ${today.getLongMonthName()} ${today.hYear}',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                DateFormat('EEEE d MMMM y', localeName).format(DateTime.now()),
                style: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpcomingTile extends StatelessWidget {
  final IslamicDate date;
  const _UpcomingTile({required this.date});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).languageCode;
    final daysLeft = date.gregorian.difference(DateTime.now()).inDays;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.star_border_purple500_rounded),
        title: Text(_eventName(t, date.eventKey)),
        subtitle: Text(
          '${date.hijri.hDay} ${date.hijri.getLongMonthName()} ${date.hijri.hYear} • '
          '${DateFormat('d MMM y', localeName).format(date.gregorian)}',
        ),
        trailing: Text(
          daysLeft == 0 ? t.hijriToday : 'J-$daysLeft',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String _eventName(AppLocalizations t, IslamicEventKey key) {
    return switch (key) {
      IslamicEventKey.hijriNewYear => t.hijriEventNewYear,
      IslamicEventKey.ashura => t.hijriEventAshura,
      IslamicEventKey.mawlid => t.hijriEventMawlid,
      IslamicEventKey.ramadanStart => t.hijriEventRamadanStart,
      IslamicEventKey.laylatAlQadr => t.hijriEventLaylatAlQadr,
      IslamicEventKey.eidAlFitr => t.hijriEventEidAlFitr,
      IslamicEventKey.dayOfArafah => t.hijriEventDayOfArafah,
      IslamicEventKey.eidAlAdha => t.hijriEventEidAlAdha,
    };
  }
}
