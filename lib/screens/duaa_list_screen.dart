import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/duaa_data.dart';
import '../models/duaa.dart';
import '../settings/app_settings.dart';
import '../widgets/pressable_scale.dart';
import '../widgets/swipe_to_pop.dart';

class DuaaListScreen extends StatelessWidget {
  final DuaaCategory category;
  const DuaaListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.watch<AppSettings>().locale.languageCode;
    final duaas = duaasForCategory(category.id);

    return SwipeToPop(
      child: Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(category.icon, size: 22),
            const SizedBox(width: 10),
            Text(category.name(languageCode)),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: duaas.length,
        itemBuilder: (context, index) {
          return FadeSlideIn(
            index: index,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _DuaaCard(duaa: duaas[index], languageCode: languageCode),
            ),
          );
        },
      ),
      ),
    );
  }
}

class _DuaaCard extends StatefulWidget {
  final Duaa duaa;
  final String languageCode;
  const _DuaaCard({required this.duaa, required this.languageCode});

  @override
  State<_DuaaCard> createState() => _DuaaCardState();
}

class _DuaaCardState extends State<_DuaaCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final d = widget.duaa;

    return PressableScale(
      pressedScale: 0.98,
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    d.title(widget.languageCode),
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 17),
                  ),
                ),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.keyboard_arrow_down_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              d.arabic,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 22, height: 1.9),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              child: _expanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          d.transliteration,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          d.translation(widget.languageCode),
                          style: theme.textTheme.bodyMedium,
                        ),
                        if (d.source != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            d.source!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ],
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}
