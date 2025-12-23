import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../providers/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUser();

    if (!mounted) return;

    final user = authProvider.user;
    if (user != null) {
      // Rediriger selon le rôle
      if (user.isStudent) {
        Navigator.pushReplacementNamed(context, AppRoutes.studentHome);
      } else if (user.isTeacher) {
        Navigator.pushReplacementNamed(context, AppRoutes.teacherHome);
      } else if (user.isAdmin) {
        Navigator.pushReplacementNamed(context, AppRoutes.adminHome);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.surfaceVariant,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.school_outlined,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'CampusConnect',
                style: AppTextStyles.displayMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Plateforme académique',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
