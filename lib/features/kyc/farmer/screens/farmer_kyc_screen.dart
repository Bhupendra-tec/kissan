import 'package:flutter/material.dart';
import '../../shared/theme/kyc_theme.dart';
import '../../shared/widgets/kyc_button.dart';
import '../../shared/widgets/kyc_text_field.dart';
import '../widgets/farmer_kyc_fields.dart';

/// Farmer-Specific KYC Verification Form Screen
class FarmerKYCScreen extends StatefulWidget {
  final String? initialPhone;
  final String? initialLocation;
  final String? initialName;

  const FarmerKYCScreen({
    super.key,
    this.initialName = 'Ram Bahadur Thapa',
    this.initialPhone = '9841234567',
    this.initialLocation = 'Bhaktapur, Nepal',
  });

  @override
  State<FarmerKYCScreen> createState() => _FarmerKYCScreenState();
}

class _FarmerKYCScreenState extends State<FarmerKYCScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _locationCtrl;
  late TextEditingController _farmNameCtrl;
  late TextEditingController _citizenshipCtrl;
  late TextEditingController _lalpurjaCtrl;
  late TextEditingController _landAreaCtrl;
  late TextEditingController _cropsCtrl;
  late TextEditingController _soilCardCtrl;
  late TextEditingController _bankCtrl;

  String _selectedFarmType = FarmerKYCConstants.farmTypes[0];
  String _selectedOwnership = FarmerKYCConstants.landOwnershipTypes[0];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _phoneCtrl = TextEditingController(text: widget.initialPhone);
    _locationCtrl = TextEditingController(text: widget.initialLocation);
    _farmNameCtrl = TextEditingController(text: 'Thapa Krishi Farm');
    _citizenshipCtrl = TextEditingController(text: '27-01-78-04921');
    _lalpurjaCtrl = TextEditingController(text: 'KHM-49201-BKT');
    _landAreaCtrl = TextEditingController(text: '12 Ropani (0.61 Ha)');
    _cropsCtrl = TextEditingController(text: 'Paddy, Wheat, Fresh Veggies');
    _soilCardCtrl = TextEditingController(text: 'NP-BKT-8842');
    _bankCtrl = TextEditingController(text: '9841234567 (Nabil Bank)');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _locationCtrl.dispose();
    _farmNameCtrl.dispose();
    _citizenshipCtrl.dispose();
    _lalpurjaCtrl.dispose();
    _landAreaCtrl.dispose();
    _cropsCtrl.dispose();
    _soilCardCtrl.dispose();
    _bankCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Farmer KYC submitted successfully. Verification under review!'),
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
            // Top Green Header Banner
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
                          'Farmer KYC Verification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Verify your farm identity & Krishi credentials',
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
                      Icons.agriculture,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Form Container
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
                        'Farmer Identity Verification',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: KYCDashboardTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Fill in your farm registration details to access direct marketplace selling, expert consultations, and government subsidies.',
                        style: TextStyle(
                          fontSize: 12,
                          color: KYCDashboardTheme.textMuted,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Basic Account Details
                      KYCOutlinedTextField(
                        label: 'Full Name',
                        hintText: 'Enter full name',
                        icon: Icons.person_outline,
                        controller: _nameCtrl,
                      ),
                      KYCOutlinedTextField(
                        label: 'Phone Number',
                        hintText: 'Enter phone number',
                        icon: Icons.phone_outlined,
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                      KYCOutlinedTextField(
                        label: 'Farm Address / Location',
                        hintText: 'e.g. Bhaktapur, Nepal',
                        icon: Icons.location_on_outlined,
                        controller: _locationCtrl,
                      ),

                      // Farmer Specific Fields Component
                      FarmerKYCFormFields(
                        farmNameCtrl: _farmNameCtrl,
                        citizenshipCtrl: _citizenshipCtrl,
                        lalpurjaCtrl: _lalpurjaCtrl,
                        landAreaCtrl: _landAreaCtrl,
                        cropsCtrl: _cropsCtrl,
                        soilCardCtrl: _soilCardCtrl,
                        bankCtrl: _bankCtrl,
                        selectedFarmType: _selectedFarmType,
                        selectedLandOwnership: _selectedOwnership,
                        onFarmTypeChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedFarmType = val);
                          }
                        },
                        onLandOwnershipChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedOwnership = val);
                          }
                        },
                      ),

                      const SizedBox(height: 10),

                      // Reusable Primary Action Button
                      KYCPrimaryButton(
                        label: 'Submit KYC for Verification',
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
