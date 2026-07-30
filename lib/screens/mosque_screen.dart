import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/mosque.dart';
import '../services/prayer_service.dart'; // réutilise getCurrentPosition
import '../services/mosque_service.dart';

class MosqueScreen extends StatefulWidget {
  const MosqueScreen({super.key});

  @override
  State<MosqueScreen> createState() => _MosqueScreenState();
}

class _MosqueScreenState extends State<MosqueScreen> {
  final _prayerService = PrayerService();
  final _mosqueService = MosqueService();

  List<Mosque> _mosques = [];
  bool _loading = true;
  String? _error;

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
      final pos = await _prayerService.getCurrentPosition();
      final mosques = await _mosqueService.getNearbyMosques(
        lat: pos.latitude,
        lon: pos.longitude,
      );
      setState(() {
        _mosques = mosques;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _openInMaps(Mosque m) async {
    final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${m.lat},${m.lon}');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.mosquesTitle)),
      body: RefreshIndicator(onRefresh: _load, child: _buildBody(t)),
    );
  }

  Widget _buildBody(AppLocalizations t) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return ListView(
        children: [
          const SizedBox(height: 100),
          Center(child: Text(_error!, textAlign: TextAlign.center)),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(onPressed: _load, child: Text(t.retry)),
          ),
        ],
      );
    }
    if (_mosques.isEmpty) {
      return Center(child: Text(t.mosqueEmpty));
    }
    return ListView.separated(
      itemCount: _mosques.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final m = _mosques[i];
        return ListTile(
          leading: const Icon(Icons.mosque, color: Colors.teal),
          title: Text(m.name.isEmpty ? t.mosqueNoName : m.name),
          trailing: Text(m.distanceLabel),
          onTap: () => _openInMaps(m),
        );
      },
    );
  }
}
