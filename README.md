# Quran App — Coran, Salat & Mosquées

## Installation

```bash
flutter pub get       # génère aussi les traductions (AppLocalizations) grâce à generate: true
flutter run
```

Pour régénérer le splash screen natif (icônes de démarrage Android/iOS) :
```bash
dart run flutter_native_splash:create
```
(Ajoute d'abord ton propre logo, voir section Splash screen ci-dessous.)

## ⚠️ Permissions à ajouter

### Android — `android/app/src/main/AndroidManifest.xml`
Ajoute ces lignes juste avant la balise `<application>` :

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
```

### iOS — `ios/Runner/Info.plist`
Ajoute ces clés :

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Nous avons besoin de votre position pour calculer les horaires de salat et trouver les mosquées proches.</string>
```

## 🌗 Thème clair / sombre

Réglable dans **Réglages → Apparence** (Système / Clair / Sombre), persisté automatiquement.
Palette et typographie définies dans `lib/theme/app_theme.dart` (voir palette ci-dessous). L'élément
signature — une étoile géométrique à 8 branches (`lib/widgets/islamic_star_pattern.dart`) — est réutilisé
en filigrane sur le splash, le calendrier Hijri et le mode prière pour donner une identité cohérente.

| Rôle | Clair | Sombre |
|---|---|---|
| Fond | `#FAF6EE` (ivoire) | `#0B1615` (nuit) |
| Marque | `#0F5C51` (émeraude) | `#3FA88D` |
| Accent | `#C89B3C` (laiton) | `#D4AF61` |
| Texte | `#1C2321` | `#EDEDE7` |

## 🌍 Langues (FR / EN / AR)

- Gérée via `flutter gen-l10n` : les chaînes sont dans `lib/l10n/app_fr.arb` (modèle), `app_en.arb`, `app_ar.arb`.
- `flutter pub get` génère automatiquement `lib/l10n/generated/app_localizations.dart`.
- Le passage en arabe active aussi le RTL automatiquement (géré nativement par Flutter selon la locale).
- Seuls les écrans principaux et la navigation utilisent déjà `AppLocalizations.of(context)` dans ce scaffold ;
  pour traduire le reste (ex. textes des sourates, mosquées), suis le même pattern : ajoute la clé dans les 3
  fichiers `.arb`, puis remplace le texte en dur par `AppLocalizations.of(context).taClé`.

## ✨ Splash screen

`lib/screens/splash_screen.dart` affiche une animation (fondu + zoom léger) du nom de l'app avec le motif
signature, pendant que les réglages se chargent. Le splash **natif** (icône affichée par l'OS avant même que
Flutter démarre) est configuré via `flutter_native_splash` dans `pubspec.yaml` — ajoute un logo dans
`assets/splash_icon.png`, décommente les lignes `image:` correspondantes, puis relance la commande `create`.

## 📿 Tasbih (compteur de dhikr)

`lib/screens/tasbih_screen.dart` : sélection de 6 formules classiques, objectif configurable (33/99/100),
retour haptique à chaque tape et à l'atteinte de l'objectif, compte total cumulé, tout persisté localement.

## 🌙 Calendrier Hijri

`lib/services/hijri_service.dart` calcule la date Hijri du jour et les prochaines dates importantes
(Ramadan, les deux Aïds, Achoura, Mawlid, Laylat al-Qadr estimée...) via le package `hijri`.
⚠️ Ce sont des dates calculées arithmétiquement : le début réel de Ramadan et des Aïds peut varier de ±1 jour
selon l'observation locale de la lune — pense à l'indiquer aux utilisateurs si tu affines cette fonctionnalité.

## 🔔 Rappel quotidien

`lib/services/notification_service.dart` programme une notification locale quotidienne (heure réglable dans
Réglages) via `flutter_local_notifications` + `timezone`. Le contenu invite à ouvrir l'app plutôt que
d'embarquer un long texte religieux dans la notification elle-même — le "verset du jour" est à afficher
*dans* l'app en piochant une sourate via `QuranService` (par ex. déterministe selon le jour de l'année).

## 🕌 Mode prière

`lib/screens/prayer_mode_screen.dart` : écran plein écran immersif (barre de statut masquée), garde l'écran
allumé via `wakelock_plus`, affiche un minuteur discret et se termine d'un tap sur "Terminer la prière".
Note : ceci ne coupe pas les appels/notifications système (aucune API publique ne le permet de façon fiable) —
c'est avant tout un écran "ne pas déranger visuellement", pense à activer le mode Ne pas déranger du téléphone
en complément si besoin.

## Structure du projet

```
lib/
  models/         # Surah, Ayah, PrayerTimes, Mosque
  services/       # Appels API (Quran, Prayer, Mosque) + géolocalisation
  screens/        # Écrans : accueil, coran, détail sourate, salat, mosquées
  main.dart
```

## APIs utilisées

| Fonctionnalité | API | Doc |
|---|---|---|
| Texte + traductions du Coran | alquran.cloud | https://alquran.cloud/api |
| Audio récitations | cdn.islamic.network | (utilisé par alquran.cloud) |
| Horaires de salat | Aladhan | https://aladhan.com/prayer-times-api |
| Mosquées proches | Overpass API (OpenStreetMap) | https://wiki.openstreetmap.org/wiki/Overpass_API |
| Boussole Qibla | Calcul local (great-circle bearing) + capteur magnétomètre via `flutter_compass` | — |

## Boussole Qibla

- `qibla_service.dart` calcule le cap (bearing) vers la Kaaba avec la formule du grand cercle, à partir de la position GPS de l'utilisateur.
- `qibla_screen.dart` combine ce cap avec le flux `FlutterCompass.events` (capteur magnétomètre du téléphone) pour faire tourner une aiguille en temps réel vers la Qibla.
- ⚠️ Certains appareils (surtout certains modèles Android bas de gamme ou émulateurs) n'ont pas de magnétomètre : l'écran affiche un message si `FlutterCompass.events` ne renvoie pas de `heading`.
- Pense à calibrer la boussole du téléphone (mouvement en "8") si la direction semble imprécise — c'est une limite classique des capteurs magnétiques, pas du code.

## Notes

- La méthode de calcul des horaires (`method`) est réglée sur 3 (Muslim World League) par défaut dans `prayer_service.dart` — change-la selon ton pays si besoin (liste complète dans la doc Aladhan).
- Overpass API peut parfois être lent ou limité en usage intensif ; pour une app en production, prévois un serveur miroir Overpass ou une base de données de mosquées.
- Le récitateur audio par défaut est Alafasy (`ar.alafasy`), modifiable dans `quran_service.dart`.
