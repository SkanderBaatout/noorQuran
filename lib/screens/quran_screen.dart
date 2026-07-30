import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/surah.dart';
import '../services/quran_service.dart';
import '../widgets/pressable_scale.dart';
import '../widgets/network_error_view.dart';
import 'surah_detail_screen.dart';

/// Petits alias/surnoms fréquemment utilisés pour chercher une sourate,
/// en plus de son nom anglais et arabe (ex: "ahad" -> Al-Ikhlas).
const Map<int, List<String>> _surahAliases = {
  1: ['fatiha', 'fatihah', 'alfatiha'],
  2: ['baqara', 'baqarah', 'albaqara'],
  18: ['kahf', 'alkahf'],
  36: ['yasin', 'yaseen'],
  55: ['rahman', 'arrahman'],
  56: ['waqiah', 'waqia'],
  67: ['mulk', 'almulk', 'tabarak'],
  112: ['ikhlas', 'ikhlaas', 'ahad', 'tawhid'],
  113: ['falaq', 'alfalaq'],
  114: ['nas', 'annas'],
};

String _normalize(String input) {
  return input
      .toLowerCase()
      .replaceAll('-', '')
      .replaceAll("'", '')
      .replaceAll(' ', '');
}

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final _service = QuranService();
  final _searchController = TextEditingController();
  late Future<List<Surah>> _futureSurahs;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    setState(() {
      _futureSurahs = _service.getSurahs();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Surah> _filter(List<Surah> surahs) {
    if (_query.isEmpty) return surahs;
    final q = _normalize(_query);
    return surahs.where((s) {
      final aliases = _surahAliases[s.number] ?? const [];
      return _normalize(s.englishName).contains(q) ||
          _normalize(s.englishNameTranslation).contains(q) ||
          s.name.contains(_query) ||
          s.number.toString() == _query ||
          aliases.any((a) => a.contains(q));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.quranTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: t.searchSurah,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      ),
                isDense: true,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Surah>>(
        future: _futureSurahs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return NetworkErrorView(onRetry: _reload);
          }
          final surahs = _filter(snapshot.data!);
          if (surahs.isEmpty) {
            return Center(child: Text(t.searchNoResults));
          }
          return ListView.separated(
            itemCount: surahs.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final s = surahs[index];
              return FadeSlideIn(
                index: index,
                child: PressableScale(
                  pressedScale: 0.97,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SurahDetailScreen(surah: s),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${s.number}')),
                    title: Text('${s.englishName}  (${s.name})'),
                    subtitle: Text(
                      '${s.englishNameTranslation} • ${s.numberOfAyahs} versets • ${s.revelationType}',
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
