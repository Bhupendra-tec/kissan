import 'package:flutter/material.dart';
import '../../shared/theme/kyc_theme.dart';
import '../../shared/widgets/kyc_button.dart';
import '../../shared/widgets/kyc_dropdown.dart';
import '../../shared/widgets/kyc_text_field.dart';
import '../widgets/wholesaler_kyc_fields.dart';

/// Wholesaler-specific KYC Verification Form Screen
class WholesalerKYCScreen extends StatefulWidget {
  final String? initialPhone;
  final String? initialLocation;

  const WholesalerKYCScreen({
    super.key,
    this.initialPhone = '9841238910',
    this.initialLocation = 'Birgunj Inland Trade Hub, Parsa',
  });

  @override
  State<WholesalerKYCScreen> createState() => _WholesalerKYCScreenState();
}

class _WholesalerKYCScreenState extends State<WholesalerKYCScreen> {
  late TextEditingController _phoneCtrl;
  late TextEditingController _companyCtrl;
  late TextEditingController _regCtrl;
  late TextEditingController _panCtrl;
  late TextEditingController _licenseNoCtrl;
  late TextEditingController _locationCtrl;
  late TextEditingController _intakeCtrl;

  String _selectedLicenseCategory = WholesalerKYCConstants.mandiLicenseCategories[0];

  @override
  void initState() {
    super.initState();
    _phoneCtrl = TextEditingController(text: widget.initialPhone);
    _companyCtrl = TextEditingController(text: 'Subedi Agro Commodities Pvt. Ltd.');
    _regCtrl = TextEditingController(text: 'Reg #KTM-89421');
    _panCtrl = TextEditingController(text: '601928374');
    _licenseNoCtrl = TextEditingController(text: 'KL-409');
    _locationCtrl = TextEditingController(text: widget.initialLocation);
    _intakeCtrl = TextEditingController(text: '1850');
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _companyCtrl.dispose();
    _regCtrl.dispose();
    _panCtrl.dispose();
    _licenseNoCtrl.dispose();
    _locationCtrl.dispose();
    _intakeCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Wholesaler KYC submitted for verification. Under review.'),
        backgroundColor: Color(0xFFD97706),
        duration: Duration(seconds: 3),
      ),
    );
    Navigator.pop(context, KYCVerificationStatus.submitted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KYCDashboardTheme.lightBg,
      body: SafeArea(
        child: Column(
          children: [
            // Top Blue Curved Header Banner
            Container(
              padding: const EdgeInsets.only(left: 12, right: 16, top: 12, bottom: 20),
              decoration: const BoxDecoration(
                color: KYCDashboardTheme.primaryBlue,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context, null),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Wholesaler KYC Verification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Complete business profile & Mandi credentials',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.business_center,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Form Card Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: KYCDashboardTheme.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Business Verification Details',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: KYCDashboardTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Fill in your corporate details to unlock full procurement scorecard and escrow limits.',
                        style: TextStyle(
                          fontSize: 12,
                          color: KYCDashboardTheme.textMuted,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Reusable Outlined Input Fields
                      KYCOutlinedTextField(
                        label: 'Phone Number',
                        hintText: 'Enter phone number',
                        icon: Icons.phone_outlined,
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                      KYCOutlinedTextField(
                        label: 'Firm / Company Name',
                        hintText: 'Enter company name',
                        icon: Icons.business_outlined,
                        controller: _companyCtrl,
                      ),
                      KYCOutlinedTextField(
                        label: 'Company Registration Number',
                        hintText: 'e.g. Reg #KTM-89421',
                        icon: Icons.shield_outlined,
                        controller: _regCtrl,
                      ),
                      KYCOutlinedTextField(
                        label: 'PAN Number',
                        hintText: 'Enter PAN number',
                        icon: Icons.badge_outlined,
                        controller: _panCtrl,
                        keyboardType: TextInputType.number,
                      ),

                      // Reusable Dropdown for Mandi License Category
                      KYCReusableDropdown<String>(
                        label: 'Mandi License Category',
                        icon: Icons.storefront_outlined,
                        selectedValue: _selectedLicenseCategory,
                        items: WholesalerKYCConstants.mandiLicenseCategories.map((cat) {
                          return DropdownMenuItem<String>(
                            value: cat,
                            child: Text(cat),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedLicenseCategory = val);
                          }
                        },
                      ),

                      KYCOutlinedTextField(
                        label: 'Mandi License Number',
                        hintText: 'e.g. KL-409',
                        icon: Icons.payment_outlined,
                        controller: _licenseNoCtrl,
                      ),
                      KYCOutlinedTextField(
                        label: 'Trade Hub Location',
                        hintText: 'Enter trade hub location',
                        icon: Icons.location_on_outlined,
                        controller: _locationCtrl,
                      ),
                      KYCOutlinedTextField(
                        label: 'Expected Annual Intake (MT)',
                        hintText: 'e.g. 1850',
                        icon: Icons.inventory_2_outlined,
                        controller: _intakeCtrl,
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 10),

                      // Reusable Primary Button
                      KYCPrimaryButton(
                        label: 'Submit for Verification',
                        onPressed: _handleSubmit,
                      ),

                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          'Demo only — no data is sent to a server.',
                          style: TextStyle(
                            fontSize: 11,
                            color: KYCDashboardTheme.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
