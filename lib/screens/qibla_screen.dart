import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import '../l10n/generated/app_localizations.dart';
import '../services/prayer_service.dart'; // réutilise getCurrentPosition
import '../services/qibla_service.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  final _prayerService = PrayerService();
  final _qiblaService = QiblaService();

  double? _qiblaBearing;
  double? _distanceKm;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final pos = await _prayerService.getCurrentPosition();
      final bearing = _qiblaService.calculateQiblaBearing(
        userLat: pos.latitude,
        userLon: pos.longitude,
      );
      final distance = _qiblaService.distanceToKaabaKm(
        userLat: pos.latitude,
        userLon: pos.longitude,
      );
      setState(() {
        _qiblaBearing = bearing;
        _distanceKm = distance;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.qiblaTitle)),
      body: _buildBody(t),
    );
  }

  Widget _buildBody(AppLocalizations t) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return ListView(
        children: [
          const SizedBox(height: 100),
          Icon(Icons.explore_off, size: 48, color: Colors.grey[500]),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(_error!, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(onPressed: _init, child: Text(t.retry)),
          ),
        ],
      );
    }

    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data?.heading == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                t.qiblaCompassUnavailable,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final heading = snapshot.data!.heading!;
        // Angle à appliquer au repère Qibla par rapport au Nord de l'appareil
        final qiblaAngle = (_qiblaBearing! - heading + 360) % 360;
        final isAligned = qiblaAngle <= 5 || qiblaAngle >= 355;

        return Column(
          children: [
            const SizedBox(height: 24),
            Text(
              isAligned ? t.qiblaAligned : t.qiblaTurnTowards,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isAligned ? Colors.green : null,
              ),
            ),
            const SizedBox(height: 8),
            Text(t.qiblaDistance(_distanceKm!.toStringAsFixed(0)),
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Cadran fixe (nord en haut, orienté avec l'appareil)
                    Transform.rotate(
                      angle: -heading * math.pi / 180,
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300, width: 2),
                        ),
                        child: Stack(
                          children: [
                            _compassLabel('N', Alignment.topCenter),
                            _compassLabel('S', Alignment.bottomCenter),
                            _compassLabel('E', Alignment.centerRight),
                            _compassLabel('O', Alignment.centerLeft),
                          ],
                        ),
                      ),
                    ),
                    // Aiguille pointant vers la Qibla
                    Transform.rotate(
                      angle: qiblaAngle * math.pi / 180,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.mosque,
                            size: 40,
                            color: isAligned ? Colors.green : Colors.teal,
                          ),
                          Container(
                            width: 4,
                            height: 100,
                            color: isAligned ? Colors.green : Colors.teal,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                t.qiblaInstructions,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _compassLabel(String label, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
