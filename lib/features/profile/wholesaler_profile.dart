import 'package:flutter/material.dart';
import '../../shared/models/user_profile_model.dart';
import '../../shared/widgets/dark_profile_components.dart';

/// Wholesaler Profile Screen using reusable components from dark_profile_components.dart & user_profile_model.dart
class WholesalerProfilePage extends StatefulWidget {
  final UserProfileData? initialProfile;

  const WholesalerProfilePage({
    super.key,
    this.initialProfile,
  });

  @override
  State<WholesalerProfilePage> createState() => _WholesalerProfilePageState();
}

class _WholesalerProfilePageState extends State<WholesalerProfilePage> {
  late UserProfileData _profile;

  // Additional Wholesaler specific credentials
  String _companyName = 'Subedi Agro Commodities Pvt. Ltd.';
  String _registrationNo = 'KTM-89421';
  String _panNumber = '601928374';
  String _licenseNumber = 'KL-409 (Kalimati Mandi)';

  @override
  void initState() {
    super.initState();
    _profile = widget.initialProfile ??
        UserProfileData.initialSample().copyWith(
          role: 'Wholesaler',
          firstName: 'Jivanath',
          lastName: 'Subedi',
          address: 'Birgunj Inland Trade Hub, Parsa',
          district: 'Parsa',
          province: 'Madhesh',
          cropsCount: 1850, // Annual Intake MT
          followersCount: 142, // Total Deals
          transactionsCount: 98, // Trust score %
        );
  }

  /// Interactive ImagePicker callback handler
  void _onImagePicked(String newPath) {
    setState(() {
      _profile = _profile.copyWith(avatarPath: newPath);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Wholesaler profile picture updated!'),
        backgroundColor: DarkProfileTheme.primaryGreen,
      ),
    );
  }

  /// Interactive Edit Profile modal bottom sheet using reusable dark styling
  void _openEditProfileSheet() {
    final firstNameCtrl = TextEditingController(text: _profile.firstName);
    final lastNameCtrl = TextEditingController(text: _profile.lastName);
    final companyCtrl = TextEditingController(text: _companyName);
    final emailCtrl = TextEditingController(text: _profile.email);
    final phoneCtrl = TextEditingController(text: _profile.phone);
    final addressCtrl = TextEditingController(text: _profile.address);
    final regCtrl = TextEditingController(text: _registrationNo);
    final panCtrl = TextEditingController(text: _panNumber);
    final licenseCtrl = TextEditingController(text: _licenseNumber);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: DarkProfileTheme.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Edit Wholesaler Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: DarkProfileTheme.textWhite,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: DarkProfileTheme.textMuted),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildEditTextField('First Name', firstNameCtrl, Icons.person_outline),
                _buildEditTextField('Last Name', lastNameCtrl, Icons.person_outline),
                _buildEditTextField('Company / Firm Name', companyCtrl, Icons.business_outlined),
                _buildEditTextField('Email Address', emailCtrl, Icons.email_outlined),
                _buildEditTextField('Phone Number', phoneCtrl, Icons.phone_outlined),
                _buildEditTextField('Trade Hub Address', addressCtrl, Icons.location_on_outlined),
                _buildEditTextField('Registration #', regCtrl, Icons.shield_outlined),
                _buildEditTextField('PAN Number', panCtrl, Icons.badge_outlined),
                _buildEditTextField('Mandi License #', licenseCtrl, Icons.storefront_outlined),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _profile = _profile.copyWith(
                          firstName: firstNameCtrl.text.trim(),
                          lastName: lastNameCtrl.text.trim(),
                          email: emailCtrl.text.trim(),
                          phone: phoneCtrl.text.trim(),
                          address: addressCtrl.text.trim(),
                        );
                        _companyName = companyCtrl.text.trim();
                        _registrationNo = regCtrl.text.trim();
                        _panNumber = panCtrl.text.trim();
                        _licenseNumber = licenseCtrl.text.trim();
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Wholesaler profile updated reactively!'),
                          backgroundColor: DarkProfileTheme.primaryGreen,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DarkProfileTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditTextField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: DarkProfileTheme.textWhite),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: DarkProfileTheme.textMuted),
          prefixIcon: Icon(icon, color: DarkProfileTheme.primaryGreen),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: DarkProfileTheme.cardBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: DarkProfileTheme.primaryGreen),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkProfileTheme.bgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. TOP APP BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: DarkProfileTheme.primaryGreen.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.agriculture_outlined,
                          color: DarkProfileTheme.primaryGreen,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: const TextSpan(
                          text: 'Wholesale ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: DarkProfileTheme.textWhite,
                          ),
                          children: [
                            TextSpan(
                              text: 'Profile',
                              style: TextStyle(
                                color: DarkProfileTheme.primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_outlined,
                              color: DarkProfileTheme.textWhite,
                              size: 24,
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 12,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: DarkProfileTheme.textWhite,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // PAGE TITLE & SUBTITLE
              const Text(
                'Wholesaler Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: DarkProfileTheme.textWhite,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Manage Mandi credentials, procurement & business information',
                style: TextStyle(
                  fontSize: 14,
                  color: DarkProfileTheme.textMuted,
                ),
              ),
              const SizedBox(height: 16),

              // 2. REUSABLE BANNER CARD FOR WHOLESALER
              DarkBannerCard(
                avatarPath: _profile.avatarPath,
                avatarUrl: _profile.avatarUrl,
                name: _profile.fullName,
                role: _profile.role,
                location: _profile.address,
                isVerified: _profile.isVerified,
                onEditPressed: _openEditProfileSheet,
                onImagePicked: _onImagePicked,
                stats: [
                  StatItem(
                    icon: Icons.inventory_2_outlined,
                    value: '${_profile.cropsCount} MT',
                    label: 'Annual Intake',
                  ),
                  StatItem(
                    icon: Icons.handshake_outlined,
                    value: '${_profile.followersCount}',
                    label: 'Total Deals',
                  ),
                  StatItem(
                    icon: Icons.verified_user_outlined,
                    value: '${_profile.transactionsCount}%',
                    label: 'Trust Score',
                  ),
                ],
              ),

              // 3. WHOLESALER BUSINESS & PERSONAL INFORMATION (REUSABLE COMPONENTS)
              DarkProfileCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DarkSectionHeader(
                      icon: Icons.business_center,
                      title: 'Wholesaler Credentials & Details',
                    ),
                    const SizedBox(height: 10),

                    // Profile Photo row with ImagePicker
                    DarkInfoRow(
                      icon: Icons.camera_enhance_outlined,
                      label: 'Profile Photo',
                      trailingWidget: Row(
                        children: [
                          DarkProfileAvatar(
                            avatarPath: _profile.avatarPath,
                            avatarUrl: _profile.avatarUrl,
                            size: 34,
                            isEditable: true,
                            onImagePicked: _onImagePicked,
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.chevron_right,
                            color: DarkProfileTheme.textMuted,
                          ),
                        ],
                      ),
                      onTap: _openEditProfileSheet,
                    ),

                    // Wholesaler Owner Name
                    DarkInfoRow(
                      icon: Icons.person_outline,
                      label: 'Wholesaler Owner',
                      value: _profile.fullName,
                      onTap: _openEditProfileSheet,
                    ),

                    // Firm / Company Name
                    DarkInfoRow(
                      icon: Icons.business_outlined,
                      label: 'Firm / Company Name',
                      value: _companyName,
                      onTap: _openEditProfileSheet,
                    ),

                    // Registration Number
                    DarkInfoRow(
                      icon: Icons.shield_outlined,
                      label: 'Registration Number',
                      value: _registrationNo,
                      onTap: _openEditProfileSheet,
                    ),

                    // PAN Number
                    DarkInfoRow(
                      icon: Icons.badge_outlined,
                      label: 'PAN Number',
                      value: _panNumber,
                      onTap: _openEditProfileSheet,
                    ),

                    // Kalimati Mandi License Number
                    DarkInfoRow(
                      icon: Icons.storefront_outlined,
                      label: 'Mandi License',
                      value: _licenseNumber,
                      onTap: _openEditProfileSheet,
                    ),

                    // Email Address
                    DarkInfoRow(
                      icon: Icons.email_outlined,
                      label: 'Email Address',
                      value: _profile.email,
                      onTap: _openEditProfileSheet,
                    ),

                    // Phone Number
                    DarkInfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Phone Number',
                      value: _profile.phone,
                      onTap: _openEditProfileSheet,
                    ),

                    // Trade Hub Address
                    DarkInfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Trade Hub Location',
                      value: _profile.address,
                      onTap: _openEditProfileSheet,
                    ),

                    // Province
                    DarkInfoRow(
                      icon: Icons.map_outlined,
                      label: 'Province',
                      value: _profile.province,
                      onTap: _openEditProfileSheet,
                    ),

                    // District
                    DarkInfoRow(
                      icon: Icons.domain_outlined,
                      label: 'District',
                      value: _profile.district,
                      onTap: _openEditProfileSheet,
                    ),

                    // Account Created
                    DarkInfoRow(
                      icon: Icons.date_range_outlined,
                      label: 'Account Created',
                      value: _profile.accountCreated,
                      hasDivider: false,
                    ),
                  ],
                ),
              ),

              // 4. REUSABLE VERIFICATION BANNER
              DarkVerificationBanner(
                title: 'Corporate KYC & Mandi Validated',
                subtitle: 'Authenticated by Nepal Agri Trade Directorate',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('KYC Verification is 100% Complete'),
                      backgroundColor: DarkProfileTheme.primaryGreen,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
