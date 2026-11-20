import 'package:flutter/material.dart';
import '../../shared/models/user_profile_model.dart';
import '../../shared/widgets/dark_profile_components.dart';

/// Farmer Profile Screen using reusable components from dark_profile_components.dart & user_profile_model.dart
/// Adds Farmer-specific components: Farm & Agricultural Details Card
class FarmerProfilePage extends StatefulWidget {
  final UserProfileData? initialProfile;

  const FarmerProfilePage({
    super.key,
    this.initialProfile,
  });

  @override
  State<FarmerProfilePage> createState() => _FarmerProfilePageState();
}

class _FarmerProfilePageState extends State<FarmerProfilePage> {
  late UserProfileData _profile;

  // Additional Farmer-specific state variables
  String _farmName = 'Thapa Krishi Farm';
  String _totalLandArea = '12 Ropani (0.61 Ha)';
  String _farmingExperience = '14+ Years';
  String _soilHealthCardStatus = 'Verified & Valid';
  String _primaryCropsGrown = 'Paddy, Wheat, Fresh Veggies';

  @override
  void initState() {
    super.initState();
    _profile = widget.initialProfile ?? UserProfileData.initialSample();
  }

  /// Interactive ImagePicker callback handler
  void _onImagePicked(String newPath) {
    setState(() {
      _profile = _profile.copyWith(avatarPath: newPath);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Farmer profile picture updated!'),
        backgroundColor: DarkProfileTheme.primaryGreen,
      ),
    );
  }

  /// Interactive Edit Profile modal bottom sheet
  void _openEditProfileSheet() {
    final firstNameCtrl = TextEditingController(text: _profile.firstName);
    final lastNameCtrl = TextEditingController(text: _profile.lastName);
    final emailCtrl = TextEditingController(text: _profile.email);
    final phoneCtrl = TextEditingController(text: _profile.phone);
    final addressCtrl = TextEditingController(text: _profile.address);
    final provinceCtrl = TextEditingController(text: _profile.province);
    final districtCtrl = TextEditingController(text: _profile.district);
    final municipalityCtrl = TextEditingController(text: _profile.municipality);
    final wardCtrl = TextEditingController(text: _profile.wardNumber);
    final farmNameCtrl = TextEditingController(text: _farmName);
    final landAreaCtrl = TextEditingController(text: _totalLandArea);
    final experienceCtrl = TextEditingController(text: _farmingExperience);
    final cropsCtrl = TextEditingController(text: _primaryCropsGrown);

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
                      'Edit Farmer Account',
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
                _buildEditTextField('Farm Name', farmNameCtrl, Icons.agriculture_outlined),
                _buildEditTextField('Total Land Area', landAreaCtrl, Icons.square_foot_outlined),
                _buildEditTextField('Farming Experience', experienceCtrl, Icons.history_edu_outlined),
                _buildEditTextField('Primary Crops Grown', cropsCtrl, Icons.eco_outlined),
                _buildEditTextField('Email Address', emailCtrl, Icons.email_outlined),
                _buildEditTextField('Phone Number', phoneCtrl, Icons.phone_outlined),
                _buildEditTextField('Address', addressCtrl, Icons.location_on_outlined),
                _buildEditTextField('Province', provinceCtrl, Icons.map_outlined),
                _buildEditTextField('District', districtCtrl, Icons.business_outlined),
                _buildEditTextField('Municipality', municipalityCtrl, Icons.account_balance_outlined),
                _buildEditTextField('Ward Number', wardCtrl, Icons.home_outlined),
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
                          province: provinceCtrl.text.trim(),
                          district: districtCtrl.text.trim(),
                          municipality: municipalityCtrl.text.trim(),
                          wardNumber: wardCtrl.text.trim(),
                        );
                        _farmName = farmNameCtrl.text.trim();
                        _totalLandArea = landAreaCtrl.text.trim();
                        _farmingExperience = experienceCtrl.text.trim();
                        _primaryCropsGrown = cropsCtrl.text.trim();
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Farmer profile updated reactively!'),
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
                          Icons.eco,
                          color: DarkProfileTheme.primaryGreen,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      RichText(
                        text: const TextSpan(
                          text: 'Kissan ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: DarkProfileTheme.textWhite,
                          ),
                          children: [
                            TextSpan(
                              text: 'Aap',
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
                'Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: DarkProfileTheme.textWhite,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Manage your account and information',
                style: TextStyle(
                  fontSize: 14,
                  color: DarkProfileTheme.textMuted,
                ),
              ),
              const SizedBox(height: 16),

              // 2. REUSABLE BANNER CARD FOR FARMER (Matching exact image)
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
                    icon: Icons.eco_outlined,
                    value: '${_profile.cropsCount}',
                    label: 'Crops',
                  ),
                  StatItem(
                    icon: Icons.people_outline,
                    value: '${_profile.followersCount}',
                    label: 'Followers',
                  ),
                  StatItem(
                    icon: Icons.handshake_outlined,
                    value: '${_profile.transactionsCount}',
                    label: 'Transactions',
                  ),
                ],
              ),

              // 3. PERSONAL INFORMATION CARD (Matching exact image)
              DarkProfileCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DarkSectionHeader(
                      icon: Icons.person,
                      title: 'Personal Information',
                    ),
                    const SizedBox(height: 10),

                    // Profile Photo row
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

                    // First Name
                    DarkInfoRow(
                      icon: Icons.person_outline,
                      label: 'First Name',
                      value: _profile.firstName,
                      onTap: _openEditProfileSheet,
                    ),

                    // Last Name
                    DarkInfoRow(
                      icon: Icons.person_outline,
                      label: 'Last Name',
                      value: _profile.lastName,
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

                    // Gender
                    DarkInfoRow(
                      icon: Icons.wc_outlined,
                      label: 'Gender',
                      trailingWidget: Row(
                        children: [
                          const Icon(Icons.male, size: 16, color: DarkProfileTheme.textWhite),
                          const SizedBox(width: 4),
                          Text(
                            _profile.gender,
                            style: const TextStyle(
                              color: DarkProfileTheme.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onTap: _openEditProfileSheet,
                    ),

                    // Date of Birth
                    DarkInfoRow(
                      icon: Icons.calendar_month_outlined,
                      label: 'Date of Birth',
                      trailingWidget: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: DarkProfileTheme.textMuted),
                          const SizedBox(width: 6),
                          Text(
                            _profile.dob,
                            style: const TextStyle(
                              color: DarkProfileTheme.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onTap: _openEditProfileSheet,
                    ),

                    // Address
                    DarkInfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Address',
                      trailingWidget: Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: DarkProfileTheme.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            _profile.address,
                            style: const TextStyle(
                              color: DarkProfileTheme.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onTap: _openEditProfileSheet,
                    ),

                    // Province
                    DarkInfoRow(
                      icon: Icons.map_outlined,
                      label: 'Province',
                      trailingWidget: Row(
                        children: [
                          const Icon(Icons.map, size: 14, color: DarkProfileTheme.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            _profile.province,
                            style: const TextStyle(
                              color: DarkProfileTheme.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onTap: _openEditProfileSheet,
                    ),

                    // District
                    DarkInfoRow(
                      icon: Icons.business_outlined,
                      label: 'District',
                      trailingWidget: Row(
                        children: [
                          const Icon(Icons.domain, size: 14, color: DarkProfileTheme.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            _profile.district,
                            style: const TextStyle(
                              color: DarkProfileTheme.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onTap: _openEditProfileSheet,
                    ),

                    // Municipality
                    DarkInfoRow(
                      icon: Icons.account_balance_outlined,
                      label: 'Municipality',
                      trailingWidget: Row(
                        children: [
                          const Icon(Icons.account_balance, size: 14, color: DarkProfileTheme.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            _profile.municipality,
                            style: const TextStyle(
                              color: DarkProfileTheme.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onTap: _openEditProfileSheet,
                    ),

                    // Ward Number
                    DarkInfoRow(
                      icon: Icons.home_work_outlined,
                      label: 'Ward Number',
                      value: _profile.wardNumber,
                      onTap: _openEditProfileSheet,
                    ),

                    // Account Created
                    DarkInfoRow(
                      icon: Icons.date_range_outlined,
                      label: 'Account Created',
                      trailingWidget: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: DarkProfileTheme.textMuted),
                          const SizedBox(width: 6),
                          Text(
                            _profile.accountCreated,
                            style: const TextStyle(
                              color: DarkProfileTheme.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      hasDivider: false,
                    ),
                  ],
                ),
              ),

              // 4. FARMER-SPECIFIC COMPONENT: FARM & AGRICULTURAL INFORMATION CARD
              _buildFarmerAgriculturalCard(),
              const SizedBox(height: 16),

              // 5. VERIFICATION STATUS BANNER
              DarkVerificationBanner(
                title: 'Your account is verified',
                subtitle: 'You can now access all features of Kissan Aap',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account Verification details'),
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

  /// Farmer-Specific Component: Farm & Agricultural Info Card
  Widget _buildFarmerAgriculturalCard() {
    return DarkProfileCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DarkSectionHeader(
            icon: Icons.agriculture,
            title: 'Farm & Agricultural Info',
          ),
          const SizedBox(height: 10),
          DarkInfoRow(
            icon: Icons.business_center_outlined,
            label: 'Farm Name',
            value: _farmName,
            onTap: _openEditProfileSheet,
          ),
          DarkInfoRow(
            icon: Icons.square_foot_outlined,
            label: 'Total Land Area',
            value: _totalLandArea,
            onTap: _openEditProfileSheet,
          ),
          DarkInfoRow(
            icon: Icons.history_edu_outlined,
            label: 'Farming Experience',
            value: _farmingExperience,
            onTap: _openEditProfileSheet,
          ),
          DarkInfoRow(
            icon: Icons.grass_outlined,
            label: 'Primary Crops Grown',
            value: _primaryCropsGrown,
            onTap: _openEditProfileSheet,
          ),
          DarkInfoRow(
            icon: Icons.card_membership_outlined,
            label: 'Soil Health Card Status',
            value: _soilHealthCardStatus,
            onTap: _openEditProfileSheet,
            hasDivider: false,
          ),
        ],
      ),
    );
  }
}
