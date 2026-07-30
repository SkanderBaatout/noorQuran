import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/surah.dart';
import '../services/quran_service.dart';
import '../settings/app_settings.dart';
import '../widgets/network_error_view.dart';

enum _AudioState { idle, loading, playing }

class SurahDetailScreen extends StatefulWidget {
  final Surah surah;
  const SurahDetailScreen({super.key, required this.surah});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen>
    with SingleTickerProviderStateMixin {
  final _service = QuranService();
  final _player = AudioPlayer();
  _AudioState _audioState = _AudioState.idle;

  late final AnimationController _fabBounce = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 160),
    lowerBound: 0.85,
    upperBound: 1.0,
    value: 1.0,
  );

  late Future<List<Ayah>> _arabic;
  late Future<List<Ayah>> _translation;
  bool _showTranslation = true;
  late String _languageCode;

  @override
  void initState() {
    super.initState();
    _languageCode = context.read<AppSettings>().locale.languageCode;
    _load();
  }

  void _load() {
    setState(() {
      _arabic = _service.getSurahText(widget.surah.number);
      _translation = _service.getSurahTranslation(
        widget.surah.number,
        edition: QuranService.editionForLanguage(_languageCode),
      );
    });
  }

  Future<void> _toggleAudio() async {
    // Petit effet "rebond" au clic, indépendant de la logique audio.
    _fabBounce.reverse().then((_) => _fabBounce.forward());

    if (_audioState == _AudioState.playing) {
      await _player.stop();
      if (mounted) setState(() => _audioState = _AudioState.idle);
    } else if (_audioState == _AudioState.idle) {
      setState(() => _audioState = _AudioState.loading);
      try {
        final url = _service.getSurahAudioUrl(widget.surah.number);
        await _player.play(UrlSource(url));
        if (mounted) setState(() => _audioState = _AudioState.playing);
        _player.onPlayerComplete.listen((_) {
          if (mounted) setState(() => _audioState = _AudioState.idle);
        });
      } catch (e) {
        if (mounted) {
          setState(() => _audioState = _AudioState.idle);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).errorGeneric)),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _fabBounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surah.englishName),
        actions: [
          IconButton(
            icon: Icon(_showTranslation
                ? Icons.translate
                : Icons.translate_outlined),
            tooltip: AppLocalizations.of(context).toggleTranslationTooltip,
            onPressed: () =>
                setState(() => _showTranslation = !_showTranslation),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabBounce,
        child: FloatingActionButton(
          onPressed: _audioState == _AudioState.loading ? null : _toggleAudio,
          child: switch (_audioState) {
            _AudioState.loading => const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
              ),
            _AudioState.playing => const Icon(Icons.stop),
            _AudioState.idle => const Icon(Icons.play_arrow),
          },
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([_arabic, _translation]),
        builder: (context, AsyncSnapshot<List<List<Ayah>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return NetworkErrorView(onRetry: _load);
          }
          final arabicAyahs = snapshot.data![0];
          final translatedAyahs = snapshot.data![1];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: arabicAyahs.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${arabicAyahs[i].text} ﴿${arabicAyahs[i].numberInSurah}﴾',
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 22, height: 1.8),
                    ),
                    if (_showTranslation) ...[
                      const SizedBox(height: 6),
                      Text(
                        translatedAyahs[i].text,
                        textAlign: _languageCode == 'ar' ? TextAlign.right : TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                    const Divider(height: 24),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
