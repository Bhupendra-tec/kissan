import 'package:flutter/material.dart';
import '../theme/kyc_theme.dart';
import 'kyc_status_badge.dart';

/// Top Blue Dashboard Header Container.
class KYCHeaderBanner extends StatelessWidget {
  final String name;
  final String role;
  final String location;
  final String initial;
  final KYCVerificationStatus status;
  final VoidCallback? onStatusBadgeTap;

  const KYCHeaderBanner({
    super.key,
    required this.name,
    required this.role,
    required this.location,
    required this.initial,
    required this.status,
    this.onStatusBadgeTap,
  });

  @override
  Widget build(BuildContext context) {
    final isVerified = status == KYCVerificationStatus.verified;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: KYCDashboardTheme.primaryBlue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                KYCStatusBadge(
                  status: status,
                  onTap: onStatusBadgeTap,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Profile Avatar with Initials & Verified Badge
            Stack(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDCEBFA),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      initial,
                      style: const TextStyle(
                        color: KYCDashboardTheme.primaryBlue,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (isVerified)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Color(0xFF10B981),
                        size: 24,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // User Name
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // Role
            Text(
              role,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),

            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
