import 'package:flutter/material.dart';

/// Une catégorie de douas (ex: Voyage, Maladie, Repas...).
/// Les noms sont fournis dans les 4 langues de l'app (fr, en, de, ar).
class DuaaCategory {
  final String id;
  final IconData icon;
  final Map<String, String> names;

  const DuaaCategory({
    required this.id,
    required this.icon,
    required this.names,
  });

  String name(String languageCode) =>
      names[languageCode] ?? names['fr'] ?? names.values.first;
}

/// Une invocation (douaa) : texte arabe, translittération, traductions,
/// et référence de la source (Coran ou Hadith).
class Duaa {
  final String id;
  final String categoryId;
  final String arabic;
  final String transliteration;
  final Map<String, String> titles;
  final Map<String, String> translations;
  final String? source;

  const Duaa({
    required this.id,
    required this.categoryId,
    required this.arabic,
    required this.transliteration,
    required this.titles,
    required this.translations,
    this.source,
  });

  String title(String languageCode) =>
      titles[languageCode] ?? titles['fr'] ?? titles.values.first;

  String translation(String languageCode) =>
      translations[languageCode] ?? translations['fr'] ?? translations.values.first;
}
