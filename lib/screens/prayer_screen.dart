import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/generated/app_localizations.dart'; // Import unique nettoyé
import '../models/prayer_times.dart';
import '../services/prayer_service.dart';
import '../services/notification_service.dart';
import '../settings/app_settings.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final _service = PrayerService();
  PrayerTimes? _times;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final pos = await _service.getCurrentPosition();
      final times = await _service.getTodayTimings(
        lat: pos.latitude,
        lon: pos.longitude,
      );

      // On met à jour l'UI dès que les horaires sont récupérés avec succès
      if (mounted) {
        setState(() {
          _times = times;
          _loading = false;
        });
      }

      // Programmation des notifications isolée dans un try/catch séparé
      // afin d'éviter qu'une erreur de notification ne bloque l'affichage de la prière.
      if (mounted && context.read<AppSettings>().adhanEnabled) {
        try {
          await NotificationService().scheduleAdhanFromPrayerTimes(times);
        } catch (notifError) {
          debugPrint("Erreur lors de la programmation de l'Adhan: $notifError");
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).prayerTitle)),
      body: RefreshIndicator(
        onRefresh: _load,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return ListView(
        children: [
          const SizedBox(height: 100),
          Icon(Icons.location_off, size: 48, color: Colors.grey[500]),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(_error!, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: _load,
              child: Text(AppLocalizations.of(context).retry),
            ),
          ),
        ],
      );
    }

    final times = _times!;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Column(
            children: [
              Text(times.dateReadable, style: const TextStyle(fontSize: 16)),
              Text(times.hijriDate, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...times.asList().map(
              (e) => Card(
            child: ListTile(
              leading: const Icon(Icons.mosque),
              title: Text(e.key),
              trailing: Text(
                e.value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}