import 'package:flutter/material.dart';
import '../theme/kyc_theme.dart';

/// Reusable KYC Status Pill Badge Widget
class KYCStatusBadge extends StatelessWidget {
  final KYCVerificationStatus status;
  final VoidCallback? onTap;

  const KYCStatusBadge({
    super.key,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String label;
    Color color;
    IconData icon;

    switch (status) {
      case KYCVerificationStatus.verified:
        label = 'Verified';
        color = KYCDashboardTheme.verifiedPillBg;
        icon = Icons.check_circle;
        break;
      case KYCVerificationStatus.submitted:
        label = 'Under Review';
        color = const Color(0xFFD97706);
        icon = Icons.hourglass_top_rounded;
        break;
      case KYCVerificationStatus.unverified:
      default:
        label = 'Pending KYC';
        color = KYCDashboardTheme.primaryBlue.withValues(alpha: 0.8);
        icon = Icons.access_time_filled;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white24,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 14),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
