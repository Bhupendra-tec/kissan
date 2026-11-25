import 'package:flutter/material.dart';
import '../theme/kyc_theme.dart';

/// Popup Modal Alert Dialog Template.
class KYCVerificationDialog extends StatelessWidget {
  final VoidCallback onLater;
  final VoidCallback onClickHere;

  const KYCVerificationDialog({
    super.key,
    required this.onLater,
    required this.onClickHere,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFEAEFEA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 48,
            color: Color(0xFFEF4444),
          ),
          const SizedBox(height: 16),
          const Text(
            'Complete your KYC',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: KYCDashboardTheme.textDark,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Please fill the KYC to access advanced features such as corporate procurement, escrow limits and profile verification.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: KYCDashboardTheme.textMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: onLater,
                child: const Text(
                  'Later',
                  style: TextStyle(
                    color: Color(0xFF15803D),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: onClickHere,
                style: ElevatedButton.styleFrom(
                  backgroundColor: KYCDashboardTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Click Here',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
