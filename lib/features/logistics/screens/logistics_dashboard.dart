import 'package:flutter/material.dart';
import '../../kyc/shared/theme/kyc_theme.dart';
import '../../kyc/shared/widgets/kyc_account_info.dart';
import '../../kyc/shared/widgets/kyc_alert_banner.dart';
import '../../kyc/shared/widgets/kyc_button.dart';
import '../../kyc/shared/widgets/kyc_dialog.dart';
import '../../kyc/shared/widgets/kyc_header.dart';
import '../../kyc/shared/widgets/kyc_metrics.dart';
import '../models/logistics_session.dart';
import 'logistics_kyc_screen.dart';

/// Home dashboard for the logistics provider.
///
/// Shows a limited "temporary" dashboard before KYC (name / role / address
/// from signup only), with a red banner prompting the user to complete KYC.
/// After KYC it shows the full dashboard (earnings, trips, rating, ...).
class LogisticsDashboard extends StatefulWidget {
  const LogisticsDashboard({super.key});

  @override
  State<LogisticsDashboard> createState() => _LogisticsDashboardState();
}

class _LogisticsDashboardState extends State<LogisticsDashboard> {
  late KYCVerificationStatus _status;

  @override
  void initState() {
    super.initState();
    LogisticsSession.instance.addListener(_onChange);
    _status = _computeInitialStatus();
    // Show the "please fill KYC" popup once when the dashboard appears.
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybePromptKyc());
  }

  @override
  void dispose() {
    LogisticsSession.instance.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  KYCVerificationStatus _computeInitialStatus() {
    final session = LogisticsSession.instance;
    return session.kycStatus;
  }

  void _toggleTestStatus(KYCVerificationStatus newStatus) {
    setState(() {
      _status = newStatus;
      // Also update session for demo purposes
      if (LogisticsSession.instance.user != null) {
        LogisticsSession.instance.update(
          LogisticsSession.instance.user!.copyWith(kycStatus: newStatus),
        );
      }
    });
  }

  bool _prompted = false;
  void _maybePromptKyc() {
    if (_prompted) return;
    _prompted = true;
    final session = LogisticsSession.instance;
    if (session.isLoggedIn && !session.isKycFilled) {
      _showKycPromptDialog();
    }
  }

  void _showKycPromptDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return KYCVerificationDialog(
          onLater: () => Navigator.pop(context),
          onClickHere: () {
            Navigator.pop(context);
            _openKyc();
          },
        );
      },
    );
  }

  Future<void> _openKyc() async {
    final result = await Navigator.push<KYCVerificationStatus?>(
      context,
      MaterialPageRoute(builder: (_) => const LogisticsKycScreen()),
    );
    if (result != null && mounted) {
      setState(() {
        _status = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = LogisticsSession.instance;
    final user = session.user;
    final status = _status;
    final isVerified = status == KYCVerificationStatus.verified;
    final name = (user?.name.isNotEmpty ?? false) ? user!.name : 'Logistics Partner';
    final initial = _initials(name);

    return Scaffold(
      backgroundColor: KYCDashboardTheme.lightBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // KYC Status Bar (Unverified, Submitted, Verified)
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Text(
                    'Logistics KYC:',
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

            // 1. TOP HEADER BANNER (Logistics Specific Info)
            KYCHeaderBanner(
              name: name,
              role: user?.role ?? 'Logistics Partner',
              location: (user?.address.isNotEmpty ?? false) ? user!.address : 'Address not set',
              initial: initial,
              status: status,
              onStatusBadgeTap: () {
                if (status == KYCVerificationStatus.unverified) {
                  _showKycPromptDialog();
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
                      status: status,
                      onClickHere: _openKyc,
                    ),
                    const SizedBox(height: 16),

                    // Logistics Metrics Grid (Restricted when !verified)
                    KYCMetricsGrid(
                      status: status,
                      tiles: [
                        KYCMetricTileItem(
                          icon: Icons.star_rounded,
                          iconColor: Colors.amber,
                          label: 'Rating',
                          verifiedValue: '${user?.rating.toStringAsFixed(1) ?? '4.8'} / 5.0',
                          unverifiedValue: '—',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.workspace_premium,
                          iconColor: KYCDashboardTheme.primaryBlue,
                          label: 'Experience',
                          verifiedValue: '6+ वर्ष',
                          unverifiedValue: '—',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.local_shipping_outlined,
                          iconColor: const Color(0xFF0EA5E9),
                          label: 'Trips',
                          verifiedValue: '${user?.totalTrips ?? 0}',
                          unverifiedValue: '0',
                        ),
                        KYCMetricTileItem(
                          icon: Icons.payments_outlined,
                          iconColor: const Color(0xFF10B981),
                          label: 'Earnings',
                          verifiedValue: 'NPR ${user?.monthlyEarnings.toInt() ?? 0}',
                          unverifiedValue: '—',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Corporate Account Info Heading & Card
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
                      name: name,
                      role: user?.role ?? 'Logistics Partner',
                      address: (user?.address.isNotEmpty ?? false) ? user!.address : 'Not set',
                      phone: isVerified ? (user?.phone ?? '—') : 'Add during KYC',
                    ),
                    const SizedBox(height: 20),

                    if (isVerified) ...[
                      // Full vehicle + earnings details only after KYC.
                      const Text(
                        'Vehicle Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: KYCDashboardTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      KYCAccountInfoCard(
                        name: user?.vehicleType ?? '—',
                        role: user?.vehiclePlate ?? '—',
                        address: user?.baseLocation ?? '—',
                        phone: user?.licenseNumber ?? '—',
                      ),
                      const SizedBox(height: 20),

                      // Earnings Card (simplified using KYCAccountInfoCard pattern)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: KYCDashboardTheme.borderLight),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Earnings & Payments',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: KYCDashboardTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'NPR ${user?.monthlyEarnings.toInt() ?? 0}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: KYCDashboardTheme.primaryBlue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'This week\'s earnings auto-deposit on Monday',
                              style: TextStyle(
                                fontSize: 12,
                                color: KYCDashboardTheme.textMuted,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.account_balance, size: 16, color: KYCDashboardTheme.textMuted),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Global IME Bank •••• 3278 (Verified)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: KYCDashboardTheme.textMuted,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: KYCDashboardTheme.borderLight),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Trip Logs'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: KYCDashboardTheme.borderLight),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Receipts'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Locked placeholder before KYC.
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: KYCDashboardTheme.borderLight),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(children: [
                              Icon(Icons.lock_outline, color: Colors.grey, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Earnings, vehicle details, trip history and more are locked until you complete KYC.',
                                  style: TextStyle(color: Colors.black54, fontSize: 13),
                                ),
                              ),
                            ]),
                            const SizedBox(height: 12),
                            KYCPrimaryButton(
                              label: 'Complete KYC',
                              onPressed: _openKyc,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'LP';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
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