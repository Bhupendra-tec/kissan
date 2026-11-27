import 'package:flutter/material.dart';
import '../../shared/theme/kyc_theme.dart';
import '../../shared/widgets/kyc_account_info.dart';
import '../../shared/widgets/kyc_alert_banner.dart';
import '../../shared/widgets/kyc_dialog.dart';
import '../../shared/widgets/kyc_header.dart';
import '../../shared/widgets/kyc_metrics.dart';
import 'expert_kyc_screen.dart';

/// Temporary Expert Dashboard UI demonstrating KYC Verification Flow for Vet/Doctor.
class TemporaryExpertDashboard extends StatefulWidget {
  final KYCVerificationStatus initialStatus;

  const TemporaryExpertDashboard({
    super.key,
    this.initialStatus = KYCVerificationStatus.unverified,
  });

  @override
  State<TemporaryExpertDashboard> createState() =>
      _TemporaryExpertDashboardState();
}

class _TemporaryExpertDashboardState
    extends State<TemporaryExpertDashboard> {
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
            _openExpertKYCScreen();
          },
        );
      },
    );
  }

  Future<void> _openExpertKYCScreen() async {
    final result = await Navigator.push<KYCVerificationStatus?>(
      context,
      MaterialPageRoute(
        builder: (context) => const ExpertKYCScreen(),
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
          content: Text('Expert KYC Verified! Full consultation features unlocked.'),
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
                    'Expert KYC Demo:',
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

            // 1. TOP HEADER BANNER (Expert Specific Info)
            KYCHeaderBanner(
              name: 'Dr. Sameer Wagle',
              role: 'Senior Veterinary Surgeon',
              location: 'Bharatpur-10, Chitwan',
              initial: 'S',
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
                      onClickHere: _openExpertKYCScreen,
                    ),
                    const SizedBox(height: 16),

                    // Expert Metrics Grid
                    KYCMetricsGrid(
                      status: _status,
                      tiles: const [
                        KYCMetricTileItem(
                          icon: Icons.star,
                          iconColor: Colors.amber,
                          label: 'Rating',
                          verifiedValue: '4.96 / 5.0',
                          unverifiedValue: '—',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.workspace_premium,
                          iconColor: KYCDashboardTheme.primaryBlue,
                          label: 'Experience',
                          verifiedValue: '12+ Years',
                          unverifiedValue: '—',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.forum_outlined,
                          iconColor: Color(0xFF0EA5E9),
                          label: 'Consults',
                          verifiedValue: '1,840+',
                          unverifiedValue: '0',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.favorite_outline,
                          iconColor: Color(0xFFEF4444),
                          label: 'Cure Rate',
                          verifiedValue: '98.4%',
                          unverifiedValue: '—',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Professional Account Info Heading & Card
                    const Text(
                      'Professional Account Info',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: KYCDashboardTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const KYCAccountInfoCard(
                      name: 'Dr. Sameer Wagle',
                      role: 'Senior Veterinary Surgeon',
                      address: 'Bharatpur-10, Chitwan',
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
