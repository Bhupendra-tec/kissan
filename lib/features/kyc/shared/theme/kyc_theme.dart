import 'package:flutter/material.dart';

/// Design System Theme Tokens for KYC & Dashboard UI (Green Theme)
class KYCDashboardTheme {
  static const Color primaryBlue = Color(0xFF0F7D3A); // Updated to Kissan Green
  static const Color headerBlueEnd = Color(0xFF15963F);
  static const Color lightBg = Color(0xFFF4F7FA);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF64748B);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Status & Alert colors
  static const Color alertRedBg = Color(0xFFFDF0ED);
  static const Color alertRedBorder = Color(0xFFF87171);
  static const Color alertRedText = Color(0xFFDC2626);

  static const Color alertAmberBg = Color(0xFFFFFBEB);
  static const Color alertAmberBorder = Color(0xFFFCD34D);
  static const Color alertAmberText = Color(0xFFB45309);

  static const Color alertGreenBg = Color(0xFFE8F5E9);
  static const Color alertGreenBorder = Color(0xFFA5D6A7);
  static const Color alertGreenText = Color(0xFF2E7D32);

  static const Color verifiedPillBg = Color(0xFF10B981);
  static const Color pendingPillBg = Color(0xFF334155);
}

/// Enum representing the 3 distinct states of KYC verification
enum KYCVerificationStatus {
  unverified,
  submitted,
  verified,
}
