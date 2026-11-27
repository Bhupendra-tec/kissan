import 'package:flutter/material.dart';
import '../../shared/theme/kyc_theme.dart';
import '../../shared/widgets/kyc_button.dart';
import '../../shared/widgets/kyc_text_field.dart';

/// Expert/Vet-specific KYC Verification Form Screen
class ExpertKYCScreen extends StatefulWidget {
  final String? initialPhone;
  final String? initialLocation;

  const ExpertKYCScreen({
    super.key,
    this.initialPhone = '9841238910',
    this.initialLocation = 'Bharatpur-10, Chitwan',
  });

  @override
  State<ExpertKYCScreen> createState() => _ExpertKYCScreenState();
}

class _ExpertKYCScreenState extends State<ExpertKYCScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _currentAddressCtrl;
  late TextEditingController _permanentAddressCtrl;
  late TextEditingController _clinicNameCtrl;
  late TextEditingController _clinicAddressCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: 'Dr. Sameer Wagle');
    _phoneCtrl = TextEditingController(text: widget.initialPhone);
    _emailCtrl = TextEditingController(text: 'sameer.wagle@example.com');
    _currentAddressCtrl = TextEditingController(text: widget.initialLocation);
    _permanentAddressCtrl = TextEditingController(text: 'Pokhara-8, Kaski');
    _clinicNameCtrl = TextEditingController(text: 'Kissan Agro-Vet Clinic');
    _clinicAddressCtrl = TextEditingController(text: 'Bharatpur-10, Chitwan');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _currentAddressCtrl.dispose();
    _permanentAddressCtrl.dispose();
    _clinicNameCtrl.dispose();
    _clinicAddressCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vet/Doctor KYC submitted for verification. Under review.'),
        backgroundColor: Color(0xFFD97706),
        duration: Duration(seconds: 3),
      ),
    );
    Navigator.pop(context, KYCVerificationStatus.submitted);
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: KYCDashboardTheme.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: KYCDashboardTheme.textMuted,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDocumentUploadTile(String label, {bool isOptional = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: KYCDashboardTheme.borderLight),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: KYCDashboardTheme.lightBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.upload_file, color: KYCDashboardTheme.primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: KYCDashboardTheme.textDark,
                  ),
                ),
                if (isOptional)
                  const Text(
                    'Optional',
                    style: TextStyle(
                      fontSize: 12,
                      color: KYCDashboardTheme.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              side: const BorderSide(color: KYCDashboardTheme.borderLight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Upload', style: TextStyle(fontSize: 12, color: KYCDashboardTheme.textDark)),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: KYCDashboardTheme.lightBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: KYCDashboardTheme.borderLight),
                ),
                child: const Icon(Icons.person, size: 50, color: KYCDashboardTheme.textMuted),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: KYCDashboardTheme.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Upload Profile Photo',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: KYCDashboardTheme.primaryBlue),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KYCDashboardTheme.lightBg,
      body: SafeArea(
        child: Column(
          children: [
            // Top Green Curved Header Banner
            Container(
              padding: const EdgeInsets.only(left: 12, right: 16, top: 12, bottom: 20),
              decoration: const BoxDecoration(
                color: KYCDashboardTheme.primaryBlue, // Mapped to Kissan Green in theme
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
                          'Vet/Doctor KYC Verification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Complete your professional profile',
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
                      Icons.medical_services_outlined,
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
                      _buildSectionTitle(
                        'Personal Details',
                        'Provide your basic information and profile photo.',
                      ),

                      _buildPhotoUpload(),

                      KYCOutlinedTextField(
                        label: 'Full Name',
                        hintText: 'e.g. Dr. Sameer Wagle',
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
                        label: 'Email',
                        hintText: 'Enter email address',
                        icon: Icons.email_outlined,
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      KYCOutlinedTextField(
                        label: 'Current Address',
                        hintText: 'Enter current address',
                        icon: Icons.location_on_outlined,
                        controller: _currentAddressCtrl,
                      ),
                      KYCOutlinedTextField(
                        label: 'Permanent Address',
                        hintText: 'Enter permanent address',
                        icon: Icons.home_outlined,
                        controller: _permanentAddressCtrl,
                      ),

                      const Divider(height: 40),
                      _buildSectionTitle(
                        'Required Documents',
                        'Upload these documents to verify your identity and credentials.',
                      ),

                      _buildDocumentUploadTile('Citizenship / National ID (Front & Back)'),
                      _buildDocumentUploadTile('NVC Registration Certificate'),
                      _buildDocumentUploadTile('Academic Qualification Certificate'),

                      const Divider(height: 40),
                      _buildSectionTitle(
                        'Optional Details',
                        'Add clinical experience details if available.',
                      ),

                      KYCOutlinedTextField(
                        label: 'Clinic / Hospital Name',
                        hintText: 'Enter clinic or hospital name',
                        icon: Icons.local_hospital_outlined,
                        controller: _clinicNameCtrl,
                      ),
                      KYCOutlinedTextField(
                        label: 'Clinic Address',
                        hintText: 'Enter clinic address',
                        icon: Icons.map_outlined,
                        controller: _clinicAddressCtrl,
                      ),
                      _buildDocumentUploadTile('Work / Experience Letter', isOptional: true),

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
