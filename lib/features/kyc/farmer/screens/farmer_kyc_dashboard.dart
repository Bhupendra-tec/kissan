import 'package:flutter/material.dart';
import '../../shared/theme/kyc_theme.dart';
import '../../shared/widgets/kyc_account_info.dart';
import '../../shared/widgets/kyc_alert_banner.dart';
import '../../shared/widgets/kyc_dialog.dart';
import '../../shared/widgets/kyc_header.dart';
import '../../shared/widgets/kyc_metrics.dart';
import '../widgets/farmer_kyc_fields.dart';
import 'farmer_kyc_screen.dart';

/// Farmer KYC Dashboard Screen demonstrating all 3 verification states
/// (Unverified, Submitted & Verified) using shared components & farmer specific widgets.
class FarmerKYCDashboard extends StatefulWidget {
  final KYCVerificationStatus initialStatus;

  const FarmerKYCDashboard({
    super.key,
    this.initialStatus = KYCVerificationStatus.unverified,
  });

  @override
  State<FarmerKYCDashboard> createState() => _FarmerKYCDashboardState();
}

class _FarmerKYCDashboardState extends State<FarmerKYCDashboard> {
  late KYCVerificationStatus _status;

  // Farmer Details
  final String _farmerName = 'Ram Bahadur Thapa';
  final String _farmerRole = 'Farmer';
  final String _farmerAddress = 'Bhaktapur, Nepal';
  final String _farmerPhone = '9841234567';
  final String _farmerInitial = 'R';

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;

    // Automatically trigger KYC popup modal on initial load if unverified
    if (_status == KYCVerificationStatus.unverified) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showKYCPopupDialog();
      });
    }
  }

  /// Displays the KYC Verification Modal Alert Dialog
  void _showKYCPopupDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return KYCVerificationDialog(
          onLater: () => Navigator.pop(context),
          onClickHere: () {
            Navigator.pop(context);
            _openFarmerKYCScreen();
          },
        );
      },
    );
  }

  /// Opens the Farmer KYC Verification Form Screen
  Future<void> _openFarmerKYCScreen() async {
    final result = await Navigator.push<KYCVerificationStatus?>(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerKYCScreen(
          initialName: _farmerName,
          initialPhone: _farmerPhone,
          initialLocation: _farmerAddress,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _status = result;
      });
    }
  }

  /// Quick Test Toolbar State Switcher for UI Verification
  void _toggleTestStatus(KYCVerificationStatus newStatus) {
    setState(() {
      _status = newStatus;
    });

    if (newStatus == KYCVerificationStatus.verified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('KYC filled successfully. Your account is now verified!'),
          backgroundColor: Color(0xFF10B981),
          duration: Duration(seconds: 4),
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
            // Testing State Switcher Bar (Allows easy switching between Unverified, Submitted, Verified)
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Text(
                    'Farmer KYC Demo:',
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

            // 1. REUSABLE TOP GREEN HEADER BANNER
            KYCHeaderBanner(
              name: _farmerName,
              role: _farmerRole,
              location: _farmerAddress,
              initial: _farmerInitial,
              status: _status,
              onStatusBadgeTap: () {
                if (_status == KYCVerificationStatus.unverified) {
                  _showKYCPopupDialog();
                } else if (_status == KYCVerificationStatus.submitted) {
                  _toggleTestStatus(KYCVerificationStatus.verified);
                }
              },
            ),

            // 2. MAIN DASHBOARD CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Alert Banner (Red Unverified vs Amber Submitted vs Green Verified)
                    KYCStatusAlertBanner(
                      status: _status,
                      onClickHere: _openFarmerKYCScreen,
                    ),
                    const SizedBox(height: 16),

                    // Metrics Grid (Values hidden/dash when unverified, unlocked when verified)
                    KYCMetricsGrid(
                      status: _status,
                      tiles: const [
                        KYCMetricTileItem(
                          icon: Icons.star,
                          iconColor: Colors.amber,
                          label: 'Rating',
                          verifiedValue: '4.9 / 5.0',
                          unverifiedValue: '—',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.eco,
                          iconColor: KYCDashboardTheme.primaryBlue,
                          label: 'Active Crops',
                          verifiedValue: '12 Crops',
                          unverifiedValue: '—',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.people,
                          iconColor: Color(0xFF0EA5E9),
                          label: 'Farmer Network',
                          verifiedValue: '248',
                          unverifiedValue: '0',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.account_balance_wallet,
                          iconColor: Color(0xFF10B981),
                          label: 'Total Earnings',
                          verifiedValue: 'NPR 4,50,000',
                          unverifiedValue: '—',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Account Info Heading & Card
                    const Text(
                      'Account Info',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: KYCDashboardTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    KYCAccountInfoCard(
                      name: _farmerName,
                      role: _farmerRole,
                      address: _farmerAddress,
                      phone: _farmerPhone,
                    ),
                    const SizedBox(height: 20),

                    // Farmer-Specific Component: Agricultural & Farm Details Card (Shown when verified/submitted)
                    if (_status != KYCVerificationStatus.unverified) ...[
                      const FarmerAgriculturalCard(
                        farmName: 'Thapa Krishi Farm',
                        landArea: '12 Ropani (0.61 Ha)',
                        farmType: 'Organic Crop Farming',
                        krishiCardId: 'NP-BKT-8842',
                        soilCardStatus: 'Verified & Valid',
                        primaryCrops: 'Paddy, Wheat, Fresh Veggies',
                        experience: '14+ Years',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),

            // Verified Green Banner Bar (Matching Screenshot 2)
            if (_status == KYCVerificationStatus.verified)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                color: const Color(0xFF4CAF50),
                child: const Text(
                  'KYC filled successfully. Your account is now verified!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
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
