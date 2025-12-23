import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';

/// AppBar réutilisable avec boutons d'action (Accueil et Déconnexion)
class AppBarWithActions extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? additionalActions;
  final bool showHomeButton;
  final bool showLogoutButton;

  const AppBarWithActions({
    super.key,
    required this.title,
    this.additionalActions,
    this.showHomeButton = true,
    this.showLogoutButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        if (showHomeButton)
          IconButton(
            icon: const Icon(Icons.home_outlined),
            tooltip: 'Accueil',
            onPressed: () {
              // Optionnel : retour au dashboard ou rafraîchissement
              // Pour l'instant, on reste sur la page courante
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Vous êtes déjà à l\'accueil'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        if (additionalActions != null) ...additionalActions!,
        if (showLogoutButton)
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'Déconnexion',
            onPressed: () async {
              // Afficher une boîte de dialogue de confirmation
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Déconnexion'),
                  content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Annuler'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: AppColors.textOnPrimary,
                      ),
                      child: const Text('Déconnexion'),
                    ),
                  ],
                ),
              );

              if (confirm == true && context.mounted) {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                await authProvider.logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                }
              }
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

