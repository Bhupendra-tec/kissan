import 'package:flutter/material.dart';
import '../../shared/theme/kyc_theme.dart';
import '../../shared/widgets/kyc_account_info.dart';
import '../../shared/widgets/kyc_alert_banner.dart';
import '../../shared/widgets/kyc_dialog.dart';
import '../../shared/widgets/kyc_header.dart';
import '../../shared/widgets/kyc_metrics.dart';
import 'wholesaler_kyc_screen.dart';

/// Temporary Wholesaler Dashboard UI demonstrating KYC Verification Flow for Wholesalers.
/// Independent and easy to remove later without affecting shared widgets or other actor features.
class TemporaryWholesalerDashboard extends StatefulWidget {
  final KYCVerificationStatus initialStatus;

  const TemporaryWholesalerDashboard({
    super.key,
    this.initialStatus = KYCVerificationStatus.unverified,
  });

  @override
  State<TemporaryWholesalerDashboard> createState() =>
      _TemporaryWholesalerDashboardState();
}

class _TemporaryWholesalerDashboardState
    extends State<TemporaryWholesalerDashboard> {
  late KYCVerificationStatus _status;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;

    // Automatically show KYC verification popup modal on load if unverified
    if (_status == KYCVerificationStatus.unverified) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showKYCPopupDialog();
      });
    }
  }

  void _showKYCPopupDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return KYCVerificationDialog(
          onLater: () => Navigator.pop(context),
          onClickHere: () {
            Navigator.pop(context);
            _openWholesalerKYCScreen();
          },
        );
      },
    );
  }

  Future<void> _openWholesalerKYCScreen() async {
    final result = await Navigator.push<KYCVerificationStatus?>(
      context,
      MaterialPageRoute(
        builder: (context) => const WholesalerKYCScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        _status = result;
      });
    }
  }

  void _toggleTestStatus(KYCVerificationStatus newStatus) {
    setState(() {
      _status = newStatus;
    });

    if (newStatus == KYCVerificationStatus.verified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wholesaler KYC Verified! Full procurement & escrow unlocked.'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KYCDashboardTheme.lightBg,
      body: SafeArea(
        child: Column(
          children: [
            // State Switcher Toolbar (For UI Testing & Review)
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Text(
                    'Wholesaler KYC Demo:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildStateChoiceChip('Unverified', KYCVerificationStatus.unverified),
                  const SizedBox(width: 6),
                  _buildStateChoiceChip('Submitted', KYCVerificationStatus.submitted),
                  const SizedBox(width: 6),
                  _buildStateChoiceChip('Verified', KYCVerificationStatus.verified),
                ],
              ),
            ),

            // 1. TOP HEADER BANNER (Wholesaler Specific Info)
            KYCHeaderBanner(
              name: 'Jivanath Subedi',
              role: 'Tier-1 Mandi Wholesaler',
              location: 'Birgunj Inland Trade Hub, Parsa',
              initial: 'J',
              status: _status,
              onStatusBadgeTap: () {
                if (_status == KYCVerificationStatus.unverified) {
                  _showKYCPopupDialog();
                } else if (_status == KYCVerificationStatus.submitted) {
                  _toggleTestStatus(KYCVerificationStatus.verified);
                }
              },
            ),

            // 2. DASHBOARD BODY
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Alert Banner
                    KYCStatusAlertBanner(
                      status: _status,
                      onClickHere: _openWholesalerKYCScreen,
                    ),
                    const SizedBox(height: 16),

                    // Wholesaler Procurement Scorecard Metrics Grid (Restricted when !verified)
                    KYCMetricsGrid(
                      status: _status,
                      tiles: const [
                        KYCMetricTileItem(
                          icon: Icons.star,
                          iconColor: Colors.amber,
                          label: 'Trust Score',
                          verifiedValue: '98.4 / 100',
                          unverifiedValue: '—',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.verified_user,
                          iconColor: KYCDashboardTheme.primaryBlue,
                          label: 'Settlement Rate',
                          verifiedValue: '100%',
                          unverifiedValue: '—',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.inventory_2_outlined,
                          iconColor: Color(0xFF0EA5E9),
                          label: 'Annual Intake',
                          verifiedValue: '1,850 MT',
                          unverifiedValue: '0 MT',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.account_balance_wallet_outlined,
                          iconColor: Color(0xFF10B981),
                          label: 'Escrow Limit',
                          verifiedValue: '50.0L NPR',
                          unverifiedValue: '—',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Corporate Account Info Heading & Card
                    const Text(
                      'Corporate Account Info',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: KYCDashboardTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const KYCAccountInfoCard(
                      name: 'Jivanath Subedi',
                      role: 'Tier-1 Mandi Wholesaler',
                      address: 'Birgunj Inland Trade Hub, Parsa',
                      phone: '9841238910',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateChoiceChip(String label, KYCVerificationStatus targetStatus) {
    final isSelected = _status == targetStatus;
    return GestureDetector(
      onTap: () => _toggleTestStatus(targetStatus),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? KYCDashboardTheme.primaryBlue : Colors.white12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
