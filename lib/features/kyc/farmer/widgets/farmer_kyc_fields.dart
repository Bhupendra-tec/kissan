import 'package:flutter/material.dart';
import '../../shared/theme/kyc_theme.dart';
import '../../shared/widgets/kyc_dropdown.dart';
import '../../shared/widgets/kyc_text_field.dart';

/// Constants for Farmer-specific KYC Form Dropdowns & Specifications
class FarmerKYCConstants {
  static const List<String> farmTypes = [
    'Organic Crop Farming',
    'Conventional Crop Farming',
    'Livestock & Dairy',
    'Horticulture & Fruits',
    'Poultry & Fish Farming',
    'Mixed Agriculture',
  ];

  static const List<String> landOwnershipTypes = [
    'Landowner (Lalpurja Verified)',
    'Tenant / Lease Farmer',
    'Shared / Contract Farming',
  ];

  static const List<String> landUnits = [
    'Ropani',
    'Bigha',
    'Hectare',
    'Kattha',
    'Aana',
  ];
}

/// Farmer-Specific Custom Widget: Agricultural & Farm Details Card.
/// Used on the Farmer KYC Dashboard when verified or during profile inspection.
class FarmerAgriculturalCard extends StatelessWidget {
  final String farmName;
  final String landArea;
  final String farmType;
  final String krishiCardId;
  final String soilCardStatus;
  final String primaryCrops;
  final String experience;

  const FarmerAgriculturalCard({
    super.key,
    required this.farmName,
    required this.landArea,
    required this.farmType,
    required this.krishiCardId,
    required this.soilCardStatus,
    required this.primaryCrops,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: KYCDashboardTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.agriculture,
                color: KYCDashboardTheme.primaryBlue,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Farm & Krishi Verification Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: KYCDashboardTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildDetailRow(Icons.business_outlined, 'Farm Name', farmName),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.square_foot_outlined, 'Total Land Area', landArea),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.category_outlined, 'Category / Farm Type', farmType),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.badge_outlined, 'Krishi Identity Card #', krishiCardId),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.verified_outlined, 'Soil Health Card', soilCardStatus),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.eco_outlined, 'Primary Crops', primaryCrops),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.history_edu_outlined, 'Farming Experience', experience),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: KYCDashboardTheme.textMuted),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: KYCDashboardTheme.textMuted,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: KYCDashboardTheme.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Farmer-Specific Custom Form Widget containing input fields dedicated to Farmers
class FarmerKYCFormFields extends StatelessWidget {
  final TextEditingController farmNameCtrl;
  final TextEditingController citizenshipCtrl;
  final TextEditingController lalpurjaCtrl;
  final TextEditingController landAreaCtrl;
  final TextEditingController cropsCtrl;
  final TextEditingController soilCardCtrl;
  final TextEditingController bankCtrl;
  final String selectedFarmType;
  final String selectedLandOwnership;
  final ValueChanged<String?> onFarmTypeChanged;
  final ValueChanged<String?> onLandOwnershipChanged;

  const FarmerKYCFormFields({
    super.key,
    required this.farmNameCtrl,
    required this.citizenshipCtrl,
    required this.lalpurjaCtrl,
    required this.landAreaCtrl,
    required this.cropsCtrl,
    required this.soilCardCtrl,
    required this.bankCtrl,
    required this.selectedFarmType,
    required this.selectedLandOwnership,
    required this.onFarmTypeChanged,
    required this.onLandOwnershipChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KYCOutlinedTextField(
          label: 'Farm Name',
          hintText: 'e.g. Thapa Krishi Farm',
          icon: Icons.agriculture_outlined,
          controller: farmNameCtrl,
        ),
        KYCOutlinedTextField(
          label: 'Citizenship Number',
          hintText: 'e.g. 27-01-78-04921',
          icon: Icons.badge_outlined,
          controller: citizenshipCtrl,
        ),
        KYCOutlinedTextField(
          label: 'Land Registration / Lalpurja Number',
          hintText: 'e.g. KHM-49201-BKT',
          icon: Icons.description_outlined,
          controller: lalpurjaCtrl,
        ),
        KYCReusableDropdown<String>(
          label: 'Farm Type & Category',
          icon: Icons.category_outlined,
          selectedValue: selectedFarmType,
          items: FarmerKYCConstants.farmTypes.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: onFarmTypeChanged,
        ),
        KYCReusableDropdown<String>(
          label: 'Land Ownership Status',
          icon: Icons.verified_user_outlined,
          selectedValue: selectedLandOwnership,
          items: FarmerKYCConstants.landOwnershipTypes.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: onLandOwnershipChanged,
        ),
        KYCOutlinedTextField(
          label: 'Total Land Area (Ropani / Bigha)',
          hintText: 'e.g. 12 Ropani (0.61 Ha)',
          icon: Icons.square_foot_outlined,
          controller: landAreaCtrl,
        ),
        KYCOutlinedTextField(
          label: 'Primary Crops Grown',
          hintText: 'e.g. Paddy, Wheat, Fresh Vegetables',
          icon: Icons.eco_outlined,
          controller: cropsCtrl,
        ),
        KYCOutlinedTextField(
          label: 'Soil Health / Krishi Card ID',
          hintText: 'e.g. NP-BKT-8842',
          icon: Icons.card_membership_outlined,
          controller: soilCardCtrl,
        ),
        KYCOutlinedTextField(
          label: 'Bank Account / eSewa (For Direct Payments)',
          hintText: 'e.g. 9841234567 (Nabil Bank)',
          icon: Icons.account_balance_wallet_outlined,
          controller: bankCtrl,
        ),
      ],
    );
  }
}
