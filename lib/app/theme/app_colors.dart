import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ============================================================
  // APP BACKGROUND
  // ============================================================

  static const Color background = Color(0xFF080D12);
  static const Color backgroundSecondary = Color(0xFF080D12);

  // ============================================================
  // SURFACE / CARDS / INPUTS
  // ============================================================

  static const Color surface = Color(0xFF0C3B2E);
  static const Color surfaceVariant = Color(0xFF0C3B2E);

  static const Color darkSurface = Color(0xFF0C3B2E);
  static const Color darkSurfaceVariant = Color(0xFF0C3B2E);

  // Card
  static const Color card = Color(0xFF0C3B2E);

  // Input
  static const Color input = Color(0xFF0C3B2E);

  // ============================================================
  // DARK BACKGROUNDS
  // ============================================================

  // Kept because existing UniServa screens use these names.
  static const Color darkBackground = Color(0xFF080D12);
  static const Color darkBackgroundSecondary = Color(0xFF080D12);

  // ============================================================
  // PRIMARY / BUTTONS
  // ============================================================

  static const Color primary = Color(0xFF145C46);
  static const Color primaryLight = Color(0xFF145C46);
  static const Color primaryDark = Color(0xFF145C46);

  // Bright primary
  static const Color primaryBright = Color(0xFF1B7358);

  // ============================================================
  // SECONDARY / GOLD ACCENT
  // ============================================================

  // Main gold accent used for icons/highlights.
  static const Color secondary = Color(0xFFFFBA00);

  static const Color secondaryLight = Color(0xFFFFC533);
  static const Color secondaryBright = Color(0xFFFFC533);
  static const Color secondaryDark = Color(0xFFD99D00);

  // Kept for existing UniServa code.
  static const Color primarySurface = Color(0xFFFFBA00);

  // ============================================================
  // TEXT
  // ============================================================

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFA7AFB7);
  static const Color textTertiary = Color(0xFF68727C);

  static const Color textOnPrimary = Colors.white;
  static const Color textDisabled = Color(0xFF68727C);

  // Dark theme text
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFFA7AFB7);
  static const Color darkTextTertiary = Color(0xFF68727C);
  static const Color darkTextDisabled = Color(0xFF68727C);

  // ============================================================
  // BORDERS / DIVIDERS
  // ============================================================

  static const Color border = Color(0xFF26313A);
  static const Color borderLight = Color(0xFF26313A);
  static const Color divider = Color(0xFF26313A);

  static const Color darkBorder = Color(0xFF26313A);
  static const Color darkDivider = Color(0xFF26313A);

  // ============================================================
  // GENERAL STATUS COLORS
  // ============================================================

  static const Color success = Color(0xFF1B7358);
  static const Color warning = Color(0xFFFFBA00);
  static const Color error = Color(0xFFD98986);
  static const Color info = Color(0xFFFFBA00);

  // ============================================================
  // COMPLAINT STATUS COLORS
  // ============================================================

  static const Color submitted = Color(0xFFFFBA00);
  static const Color underReview = Color(0xFFFFBA00);
  static const Color assigned = Color(0xFF145C46);
  static const Color inProgress = Color(0xFFFFBA00);
  static const Color resolved = Color(0xFF1B7358);
  static const Color closed = Color(0xFF68727C);
  static const Color reopened = Color(0xFFD98986);

  // ============================================================
  // PRIORITY COLORS
  // ============================================================

  static const Color lowPriority = Color(0xFF1B7358);
  static const Color mediumPriority = Color(0xFFFFBA00);
  static const Color highPriority = Color(0xFFFFC533);
  static const Color urgentPriority = Color(0xFFD98986);

  // ============================================================
  // COMMON COLORS
  // ============================================================

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // ============================================================
  // OVERLAYS
  // ============================================================

  static const Color overlay = Color(0x33000000);
  static const Color overlayDark = Color(0x66000000);
}