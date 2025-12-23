import 'package:flutter/material.dart';

/// Palette de couleurs moderne et luxueuse pour CampusConnect
class AppColors {
  // Couleur principale - Bleu élégant et professionnel
  static const Color primary = Color(0xFF1E3A8A); // Bleu indigo profond
  static const Color primaryLight = Color(0xFF3B82F6); // Bleu vif
  static const Color primaryDark = Color(0xFF1E40AF); // Bleu foncé
  static const Color primaryGradientStart = Color(0xFF3B82F6);
  static const Color primaryGradientEnd = Color(0xFF1E3A8A);

  // Couleurs d'accentuation
  static const Color accent = Color(0xFF06B6D4); // Cyan élégant
  static const Color accentLight = Color(0xFF67E8F9);
  static const Color accentDark = Color(0xFF0891B2);

  // Couleurs de succès, erreur, warning
  static const Color success = Color(0xFF10B981); // Vert émeraude
  static const Color error = Color(0xFFEF4444); // Rouge moderne
  static const Color warning = Color(0xFFF59E0B); // Orange ambre
  static const Color info = Color(0xFF3B82F6); // Bleu info

  // Couleurs neutres - Gris modernes
  static const Color background = Color(0xFFF8FAFC); // Gris très clair
  static const Color surface = Color(0xFFFFFFFF); // Blanc pur
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Gris clair
  static const Color divider = Color(0xFFE2E8F0); // Gris séparateur

  // Texte
  static const Color textPrimary = Color(0xFF0F172A); // Presque noir
  static const Color textSecondary = Color(0xFF475569); // Gris foncé
  static const Color textTertiary = Color(0xFF94A3B8); // Gris moyen
  static const Color textOnPrimary = Color(0xFFFFFFFF); // Blanc sur fond coloré

  // Ombres et élévations
  static const Color shadow = Color(0x1A000000); // Ombre douce

  // Dégradés
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGradientStart, primaryGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Couleurs pour les cartes et surfaces
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E8F0);

  // Couleurs pour les notes
  static const Color gradeExcellent = Color(0xFF10B981); // 16-20
  static const Color gradeGood = Color(0xFF3B82F6); // 14-15.99
  static const Color gradeAverage = Color(0xFFF59E0B); // 12-13.99
  static const Color gradePoor = Color(0xFFEF4444); // <12

  // Couleurs pour les priorités d'annonces
  static const Color priorityUrgent = Color(0xFFDC2626);
  static const Color priorityHigh = Color(0xFFF59E0B);
  static const Color priorityNormal = Color(0xFF3B82F6);
  static const Color priorityLow = Color(0xFF94A3B8);
}

