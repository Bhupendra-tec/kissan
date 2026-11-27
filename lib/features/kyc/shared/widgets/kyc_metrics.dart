import 'package:flutter/material.dart';
import '../theme/kyc_theme.dart';

/// Generic Metric Tile Item Model for KYCMetricsGrid.
class KYCMetricTileItem {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String verifiedValue;
  final String unverifiedValue;

  const KYCMetricTileItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.verifiedValue,
    this.unverifiedValue = '—',
  });
}

/// Generic Dashboard Metrics Grid Template.
class KYCMetricsGrid extends StatelessWidget {
  final KYCVerificationStatus status;
  final List<KYCMetricTileItem> tiles;

  const KYCMetricsGrid({
    super.key,
    required this.status,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    final isVerified = status == KYCVerificationStatus.verified;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.1,
      children: tiles.map((tile) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: KYCDashboardTheme.borderLight),
          ),
          child: Row(
            children: [
              Icon(tile.icon, color: tile.iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isVerified ? tile.verifiedValue : tile.unverifiedValue,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: KYCDashboardTheme.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tile.label,
                      style: const TextStyle(
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
      }).toList(),
    );
  }
}
