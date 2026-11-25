import 'package:flutter/material.dart';
import '../theme/kyc_theme.dart';

/// Status Alert Banner Template (Unverified Red vs Submitted Amber vs Verified Green).
class KYCStatusAlertBanner extends StatelessWidget {
  final KYCVerificationStatus status;
  final VoidCallback? onClickHere;

  const KYCStatusAlertBanner({
    super.key,
    required this.status,
    this.onClickHere,
  });

  @override
  Widget build(BuildContext context) {
    if (status == KYCVerificationStatus.verified) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: KYCDashboardTheme.alertGreenBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: KYCDashboardTheme.alertGreenBorder.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'KYC Verified',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: KYCDashboardTheme.alertGreenText,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'You now have access to all advanced features.',
                    style: TextStyle(
                      fontSize: 12,
                      color: KYCDashboardTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (status == KYCVerificationStatus.submitted) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: KYCDashboardTheme.alertAmberBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: KYCDashboardTheme.alertAmberBorder.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFD97706),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.hourglass_top_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'KYC Submitted & Under Review',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: KYCDashboardTheme.alertAmberText,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Your verification request is pending administrator approval.',
                    style: TextStyle(
                      fontSize: 12,
                      color: KYCDashboardTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: KYCDashboardTheme.alertRedBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: KYCDashboardTheme.alertRedBorder.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: KYCDashboardTheme.alertRedText,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.priority_high,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'KYC Required',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: KYCDashboardTheme.alertRedText,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Please fill the KYC to access advanced features.',
                  style: TextStyle(
                    fontSize: 12,
                    color: KYCDashboardTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onClickHere,
                  child: const Text(
                    'Click Here',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: KYCDashboardTheme.primaryBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
