import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ============================================================
  // PRIMARY PALETTE
  // Inspired by the provided purple + warm peach reference UI.
  // ============================================================

  static const Color primary = Color(0xFF4B456F);
  static const Color primaryDark = Color(0xFF383354);
  static const Color primaryLight = Color(0xFF6A638C);

  static const Color primarySurface = Color(0xFFE9C093);
  static const Color secondary = Color(0xFFDFAF83);
  static const Color secondaryLight = Color(0xFFF0CAA0);

  // ============================================================
  // LIGHT SURFACES
  // ============================================================

  static const Color background = Color(0xFFE8E4DC);
  static const Color backgroundSecondary = Color(0xFFDCD8D0);

  static const Color surface = Color(0xFF504A73);
  static const Color surfaceVariant = Color(0xFF433D63);

  // ============================================================
  // DARK SURFACES
  // ============================================================

  static const Color darkBackground = Color(0xFF332F50);
  static const Color darkBackgroundSecondary = Color(0xFF292643);

  static const Color darkSurface = Color(0xFF403A61);
  static const Color darkSurfaceVariant = Color(0xFF49436A);

  // ============================================================
  // TEXT
  // ============================================================

  static const Color textPrimary = Color(0xFF393354);
  static const Color textSecondary = Color(0xFF68627A);
  static const Color textTertiary = Color(0xFF8D879A);

  static const Color textOnPrimary = Color(0xFFFFF8F2);
  static const Color textDisabled = Color(0xFFAAA5B0);

  static const Color darkTextPrimary = Color(0xFFFFF8F2);
  static const Color darkTextSecondary = Color(0xFFD8D1D8);
  static const Color darkTextTertiary = Color(0xFFAAA5B0);
  static const Color darkTextDisabled = Color(0xFF777285);

  // ============================================================
  // BORDERS / DIVIDERS
  // ============================================================

  static const Color border = Color(0xFFD1CBC3);
  static const Color borderLight = Color(0xFFE2DDD6);
  static const Color divider = Color(0xFFD1CBC3);

  static const Color darkBorder = Color(0xFF5A5475);
  static const Color darkDivider = Color(0xFF514B6C);

  // ============================================================
  // STATUS COLORS
  // ============================================================

  static const Color success = Color(0xFF82B89A);
  static const Color warning = Color(0xFFE3B26E);
  static const Color error = Color(0xFFD98986);
  static const Color info = Color(0xFF8BAAC8);

  // Complaint status
  static const Color submitted = Color(0xFFB995D1);
  static const Color underReview = Color(0xFF8BAAC8);
  static const Color assigned = Color(0xFF9B91C9);
  static const Color inProgress = Color(0xFFE3B26E);
  static const Color resolved = Color(0xFF82B89A);
  static const Color closed = Color(0xFF858092);
  static const Color reopened = Color(0xFFD98986);

  // Priority
  static const Color lowPriority = Color(0xFF82B89A);
  static const Color mediumPriority = Color(0xFFE3B26E);
  static const Color highPriority = Color(0xFFD99A73);
  static const Color urgentPriority = Color(0xFFD98986);

  // ============================================================
  // COMMON COLORS
  // ============================================================

  static const Color white = Color(0xFFFFFCF8);
  static const Color black = Color(0xFF26223A);
  static const Color transparent = Colors.transparent;

  static const Color overlay = Color(0x33000000);
  static const Color overlayDark = Color(0x66000000);
}