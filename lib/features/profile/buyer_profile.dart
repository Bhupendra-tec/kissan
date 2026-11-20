import 'package:flutter/material.dart';
import '../../shared/models/user_profile_model.dart';
import '../../shared/widgets/dark_profile_components.dart';

/// Buyer Profile Screen using reusable components from dark_profile_components.dart & user_profile_model.dart
/// Adds missing Buyer-specific components: Preferences Card & Activity Grid
class BuyerProfilePage extends StatefulWidget {
  final UserProfileData? initialProfile;

  const BuyerProfilePage({
    super.key,
    this.initialProfile,
  });

  @override
  State<BuyerProfilePage> createState() => _BuyerProfilePageState();
}

class _BuyerProfilePageState extends State<BuyerProfilePage> {
  late UserProfileData _profile;

  // Buyer Specific Preferences State
  String _preferredProducts = 'Vegetables, Fruits, Dairy';
  String _buyingRadius = 'Within 10 km';
  bool _productAlertsEnabled = true;

  // Buyer Specific Activity Metrics
  int _ordersCount = 24;
  int _savedItemsCount = 5;
  int _followedFarmersCount = 12;
  int _priceAlertsCount = 3;

  @override
  void initState() {
    super.initState();
    _profile = widget.initialProfile ??
        const UserProfileData(
          id: 'buyer_001',
          avatarUrl:
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&auto=format&fit=crop&q=80',
          firstName: 'Srijana',
          lastName: 'Karki',
          role: 'Buyer',
          email: 'srijana.karki@gmail.com',
          phone: '9841234567',
          gender: 'Female',
          dob: '12 Mar 2000',
          address: 'Budhanilkantha, Kathmandu',
          province: 'Bagmati',
          district: 'Kathmandu',
          municipality: 'Budhanilkantha',
          wardNumber: '5',
          accountCreated: '15 Jan 2025',
          isVerified: true,
          cropsCount: 24, // Orders
          followersCount: 5, // Favorites
          transactionsCount: 49, // Rating (4.9)
        );
  }

  /// Interactive ImagePicker callback handler
  void _onImagePicked(String newPath) {
    setState(() {
      _profile = _profile.copyWith(avatarPath: newPath);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Buyer profile picture updated!'),
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
    final dobCtrl = TextEditingController(text: _profile.dob);

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
                      'Edit Buyer Profile',
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
                _buildEditTextField('Email Address', emailCtrl, Icons.email_outlined),
                _buildEditTextField('Phone Number', phoneCtrl, Icons.phone_outlined),
                _buildEditTextField('Delivery Address', addressCtrl, Icons.location_on_outlined),
                _buildEditTextField('Date of Birth', dobCtrl, Icons.calendar_today_outlined),
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
                          dob: dobCtrl.text.trim(),
                        );
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Buyer profile details updated!'),
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

  /// Interactive Preferences Edit Sheet
  void _openEditPreferencesSheet() {
    final productsCtrl = TextEditingController(text: _preferredProducts);
    final radiusCtrl = TextEditingController(text: _buyingRadius);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Buyer Preferences',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: DarkProfileTheme.textWhite,
                ),
              ),
              const SizedBox(height: 16),
              _buildEditTextField('Preferred Products', productsCtrl, Icons.shopping_basket_outlined),
              _buildEditTextField('Buying Radius', radiusCtrl, Icons.near_me_outlined),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _preferredProducts = productsCtrl.text.trim();
                      _buyingRadius = radiusCtrl.text.trim();
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Buyer preferences updated!'),
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
                    'Save Preferences',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
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
    final locationString = '${_profile.province} / ${_profile.district} / ${_profile.municipality}';

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
                'Manage your account, orders and preferences',
                style: TextStyle(
                  fontSize: 14,
                  color: DarkProfileTheme.textMuted,
                ),
              ),
              const SizedBox(height: 16),

              // 2. REUSABLE BANNER CARD FOR BUYER
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
                    icon: Icons.shopping_bag_outlined,
                    value: '${_profile.cropsCount}',
                    label: 'Orders',
                  ),
                  StatItem(
                    icon: Icons.favorite_border,
                    value: '${_profile.followersCount}',
                    label: 'Favorites',
                  ),
                  StatItem(
                    icon: Icons.star,
                    value: (_profile.transactionsCount / 10).toStringAsFixed(1),
                    label: 'Rating',
                  ),
                ],
              ),

              // 3. VERIFICATION BANNER
              DarkVerificationBanner(
                title: 'Verified Buyer (KYC)',
                subtitle: 'Your identity has been verified.',
              ),
              const SizedBox(height: 16),

              // 4. PERSONAL INFORMATION CARD (REUSABLE COMPONENTS)
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

                    // Full Name
                    DarkInfoRow(
                      icon: Icons.person_outline,
                      label: 'Full Name',
                      value: _profile.fullName,
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

                    // Address
                    DarkInfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Address',
                      value: _profile.address,
                      onTap: _openEditProfileSheet,
                    ),

                    // Province / District / Municipality
                    DarkInfoRow(
                      icon: Icons.home_work_outlined,
                      label: 'Province / District / Municipality',
                      value: locationString,
                      onTap: _openEditProfileSheet,
                    ),

                    // Date of Birth
                    DarkInfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Date of Birth',
                      value: _profile.dob,
                      onTap: _openEditProfileSheet,
                    ),

                    // Gender
                    DarkInfoRow(
                      icon: Icons.wc_outlined,
                      label: 'Gender',
                      value: _profile.gender,
                      onTap: _openEditProfileSheet,
                      hasDivider: false,
                    ),
                  ],
                ),
              ),

              // 5. MISSING BUYER COMPONENT 1: MY PREFERENCES CARD
              _buildPreferencesCard(),
              const SizedBox(height: 16),

              // 6. MISSING BUYER COMPONENT 2: MY ACTIVITY CARD
              _buildActivityCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Buyer Component: My Preferences Card (3 Column Tiles: Preferred Products, Buying Radius, Product Alerts Switch)
  Widget _buildPreferencesCard() {
    return DarkProfileCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DarkSectionHeader(
                icon: Icons.tune,
                title: 'My Preferences',
              ),
              InkWell(
                onTap: _openEditPreferencesSheet,
                child: Row(
                  children: const [
                    Icon(Icons.edit, size: 14, color: DarkProfileTheme.textWhite),
                    SizedBox(width: 4),
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: DarkProfileTheme.textWhite,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Tile 1: Preferred Products
              Expanded(
                child: _buildPreferenceTile(
                  icon: Icons.shopping_basket,
                  title: 'Preferred Products',
                  subtitle: _preferredProducts,
                ),
              ),
              const SizedBox(width: 10),
              // Tile 2: Buying Radius
              Expanded(
                child: _buildPreferenceTile(
                  icon: Icons.location_on,
                  title: 'Buying Radius',
                  subtitle: _buyingRadius,
                ),
              ),
              const SizedBox(width: 10),
              // Tile 3: Product Alerts with Toggle Switch
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: DarkProfileTheme.bgDark,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: DarkProfileTheme.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: DarkProfileTheme.primaryGreen.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notifications_active,
                              color: DarkProfileTheme.primaryGreen,
                              size: 18,
                            ),
                          ),
                          Transform.scale(
                            scale: 0.75,
                            child: Switch(
                              value: _productAlertsEnabled,
                              activeColor: DarkProfileTheme.primaryGreen,
                              activeTrackColor: DarkProfileTheme.primaryGreen.withValues(alpha: 0.4),
                              inactiveThumbColor: DarkProfileTheme.textMuted,
                              inactiveTrackColor: DarkProfileTheme.cardBorder,
                              onChanged: (val) {
                                setState(() {
                                  _productAlertsEnabled = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Product Alerts',
                        style: TextStyle(
                          color: DarkProfileTheme.textWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Get notified about new harvests & offers',
                        style: TextStyle(
                          color: DarkProfileTheme.textMuted,
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DarkProfileTheme.bgDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DarkProfileTheme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: DarkProfileTheme.primaryGreen.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: DarkProfileTheme.primaryGreen, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: DarkProfileTheme.textWhite,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: DarkProfileTheme.textMuted,
              fontSize: 11,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Buyer Component: My Activity Card (4 Grid Tiles: My Orders, Saved Items, Followed Farmers, Price Alerts)
  Widget _buildActivityCard() {
    return DarkProfileCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DarkSectionHeader(
                icon: Icons.bar_chart,
                title: 'My Activity',
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navigating to full activity view...')),
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: DarkProfileTheme.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 14, color: DarkProfileTheme.textMuted),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Tile 1: My Orders
              Expanded(
                child: _buildActivityTile(
                  icon: Icons.shopping_cart,
                  iconColor: DarkProfileTheme.primaryGreen,
                  title: 'My Orders',
                  value: '$_ordersCount',
                ),
              ),
              const SizedBox(width: 10),
              // Tile 2: Saved Items
              Expanded(
                child: _buildActivityTile(
                  icon: Icons.favorite,
                  iconColor: Colors.redAccent,
                  title: 'Saved Items',
                  value: '$_savedItemsCount',
                ),
              ),
              const SizedBox(width: 10),
              // Tile 3: Followed Farmers
              Expanded(
                child: _buildActivityTile(
                  icon: Icons.storefront,
                  iconColor: DarkProfileTheme.primaryGreen,
                  title: 'Followed Farmers',
                  value: '$_followedFarmersCount',
                ),
              ),
              const SizedBox(width: 10),
              // Tile 4: Price Alerts
              Expanded(
                child: _buildActivityTile(
                  icon: Icons.notifications,
                  iconColor: Colors.amber,
                  title: 'Price Alerts',
                  value: '$_priceAlertsCount',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DarkProfileTheme.bgDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DarkProfileTheme.cardBorder),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: DarkProfileTheme.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: DarkProfileTheme.textWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
