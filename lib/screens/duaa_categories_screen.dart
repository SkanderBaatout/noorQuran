import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/duaa_data.dart';
import '../settings/app_settings.dart';
import '../widgets/pressable_scale.dart';
import '../widgets/swipe_to_pop.dart';
import 'duaa_list_screen.dart';

class DuaaCategoriesScreen extends StatelessWidget {
  const DuaaCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.watch<AppSettings>().locale.languageCode;
    final theme = Theme.of(context);

    return SwipeToPop(
      child: Scaffold(
      appBar: AppBar(
        title: Text(languageCode == 'en'
            ? 'Duas by category'
            : languageCode == 'de'
                ? 'Bittgebete nach Kategorie'
                : languageCode == 'ar'
                    ? 'أدعية حسب الفئة'
                    : 'Douas par catégorie'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.15,
        ),
        itemCount: duaaCategories.length,
        itemBuilder: (context, index) {
          final category = duaaCategories[index];
          return FadeSlideIn(
            index: index,
            child: PressableScale(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DuaaListScreen(category: category),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category.icon, size: 36, color: theme.colorScheme.primary),
                    const SizedBox(height: 10),
                    Text(
                      category.name(languageCode),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      ),
    );
  }
}
