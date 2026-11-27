import 'package:flutter/material.dart';
import '../theme/kyc_theme.dart';

/// Account Information Card Template.
class KYCAccountInfoCard extends StatelessWidget {
  final String name;
  final String role;
  final String address;
  final String phone;

  const KYCAccountInfoCard({
    super.key,
    required this.name,
    required this.role,
    required this.address,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: KYCDashboardTheme.borderLight),
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.person_outline, 'Name', name),
          const Divider(height: 20, color: KYCDashboardTheme.borderLight),
          _buildInfoRow(Icons.badge_outlined, 'Role', role),
          const Divider(height: 20, color: KYCDashboardTheme.borderLight),
          _buildInfoRow(Icons.location_on_outlined, 'Address', address),
          const Divider(height: 20, color: KYCDashboardTheme.borderLight),
          _buildInfoRow(Icons.phone_outlined, 'Phone', phone),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: KYCDashboardTheme.primaryBlue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: KYCDashboardTheme.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: KYCDashboardTheme.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
