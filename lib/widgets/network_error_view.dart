import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';

/// Affichage propre en cas d'échec de chargement (pas d'Internet, API en
/// panne, timeout...), avec un bouton "Réessayer" plutôt qu'un message
/// d'erreur technique brut.
class NetworkErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  final String? message;

  const NetworkErrorView({super.key, required this.onRetry, this.message});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 56,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
            ),
            const SizedBox(height: 16),
            Text(
              message ?? t.errorGeneric,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(t.retry),
            ),
          ],
        ),
      ),
    );
  }
}
