import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/generated/app_localizations.dart';
import '../services/tasbih_service.dart';
import '../theme/app_theme.dart';
import '../widgets/swipe_to_pop.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen>
    with SingleTickerProviderStateMixin {
  final _service = TasbihService();
  int _count = 0;
  int _phraseIndex = 0;
  int _target = 33;
  int _totalAllTime = 0;
  late AnimationController _bumpController;

  @override
  void initState() {
    super.initState();
    _bumpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0,
      upperBound: 0.06,
    );
    _load();
  }

  Future<void> _load() async {
    final data = await _service.load();
    setState(() {
      _count = data['count']!;
      _phraseIndex = data['phraseIndex']!;
      _target = data['target']!;
      _totalAllTime = data['totalAllTime']!;
    });
  }

  void _persist() {
    _service.save(
      count: _count,
      phraseIndex: _phraseIndex,
      target: _target,
      totalAllTime: _totalAllTime,
    );
  }

  void _increment() {
    HapticFeedback.lightImpact();
    _bumpController.forward().then((_) => _bumpController.reverse());
    setState(() {
      _count++;
      _totalAllTime++;
      if (_count == _target) {
        HapticFeedback.mediumImpact();
      }
    });
    _persist();
  }

  void _reset() {
    HapticFeedback.selectionClick();
    setState(() => _count = 0);
    _persist();
  }

  @override
  void dispose() {
    _bumpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Couleur militaire vert foncé, cohérente avec le reste de l'app,
    // utilisée à la place de l'accent doré/jaune (colorScheme.secondary)
    // qui n'a pas sa place sur cet écran.
    final militaryGreen = isDark ? AppColors.emeraldLight : AppColors.emerald;
    final phrase = dhikrPhrases[_phraseIndex];
    final progress = (_count % _target) / _target;

    return SwipeToPop(
      child: Scaffold(
      appBar: AppBar(
        title: Text(t.tasbihTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
            tooltip: t.tasbihReset,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          // Sélecteur de dhikr
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dhikrPhrases.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final selected = i == _phraseIndex;
                return ChoiceChip(
                  label: Text(dhikrPhrases[i].transliteration),
                  selected: selected,
                  // Couleurs explicites : sans cela, Material 3 utilise
                  // colorScheme.secondaryContainer (dérivé du doré) pour le
                  // fond de la puce sélectionnée, d'où le jaune indésirable.
                  selectedColor: militaryGreen,
                  labelStyle: TextStyle(
                    color: selected
                        ? Colors.white
                        : theme.textTheme.bodyMedium?.color,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  onSelected: (_) {
                    setState(() => _phraseIndex = i);
                    _persist();
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(phrase.arabic,
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: 32)),
          const SizedBox(height: 4),
          Text(phrase.meaningFr, style: TextStyle(color: Colors.grey[600])),
          const Spacer(),
          // Bague de progression + compteur
          GestureDetector(
            onTap: _increment,
            child: AnimatedBuilder(
              animation: _bumpController,
              builder: (context, child) => Transform.scale(
                scale: 1 - _bumpController.value,
                child: child,
              ),
              child: SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: progress == 0 ? 1 : progress,
                        strokeWidth: 10,
                        backgroundColor: militaryGreen.withValues(alpha: 0.15),
                        valueColor: AlwaysStoppedAnimation(militaryGreen),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$_count',
                            style: theme.textTheme.headlineLarge
                                ?.copyWith(fontSize: 56)),
                        Text('/ $_target', style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(t.tasbihTapToCount,
              style: TextStyle(color: Colors.grey[500], fontSize: 13)),
          const Spacer(),
          // Choix de l'objectif
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Wrap(
              spacing: 8,
              children: [33, 99, 100].map((target) {
                final selected = _target == target;
                return ChoiceChip(
                  label: Text('$target'),
                  selected: selected,
                  selectedColor: militaryGreen,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : theme.textTheme.bodyMedium?.color,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  onSelected: (_) {
                    setState(() => _target = target);
                    _persist();
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(t.tasbihTotal(_totalAllTime),
                style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ),
        ],
      ),
      ),
    );
  }
}
