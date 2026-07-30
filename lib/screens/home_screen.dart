import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';
import 'quran_screen.dart';
import 'prayer_screen.dart';
import 'mosque_screen.dart';
import 'qibla_screen.dart';
import 'tasbih_screen.dart';
import 'hijri_screen.dart';
import 'prayer_mode_screen.dart';
import 'settings_screen.dart';
import 'duaa_categories_screen.dart';
import '../widgets/pressable_scale.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final _screens = const [
    QuranScreen(),
    PrayerScreen(),
    QiblaScreen(),
    MosqueScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.appName)),
      drawer: _AppDrawer(appName: t.appName),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.97, end: 1).animate(animation),
            child: child,
          ),
        ),
        child: KeyedSubtree(
          key: ValueKey(_index),
          child: _screens[_index],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.menu_book), label: t.navQuran),
          NavigationDestination(icon: const Icon(Icons.access_time), label: t.navPrayer),
          NavigationDestination(icon: const Icon(Icons.explore), label: t.navQibla),
          NavigationDestination(icon: const Icon(Icons.mosque), label: t.navMosques),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final String appName;
  const _AppDrawer({required this.appName});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Icon(Icons.nights_stay_rounded, color: theme.colorScheme.primary, size: 32),
                  const SizedBox(width: 12),
                  Text(appName, style: theme.textTheme.titleLarge?.copyWith(fontSize: 20)),
                ],
              ),
            ),
            const Divider(height: 1),
            PressableScale(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TasbihScreen()));
              },
              child: ListTile(
                leading: const Icon(Icons.fingerprint),
                title: Text(t.menuTasbih),
              ),
            ),
            PressableScale(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HijriScreen()));
              },
              child: ListTile(
                leading: const Icon(Icons.calendar_month),
                title: Text(t.menuHijri),
              ),
            ),
            PressableScale(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerModeScreen()));
              },
              child: ListTile(
                leading: const Icon(Icons.self_improvement),
                title: Text(t.menuPrayerMode),
              ),
            ),
            PressableScale(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DuaaCategoriesScreen()));
              },
              child: ListTile(
                leading: const Icon(Icons.volunteer_activism),
                title: Text(t.menuDuaa),
              ),
            ),
            const Divider(height: 1),
            PressableScale(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
              },
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: Text(t.menuSettings),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
