import 'package:flutter/material.dart';
import '../../shared/theme/kyc_theme.dart';
import '../../shared/widgets/kyc_dropdown.dart';
import '../../shared/widgets/kyc_text_field.dart';

/// Constants for Buyer-specific KYC Form Dropdowns & Specifications
class BuyerKYCConstants {
  static const List<String> buyerTypes = [
    'Individual Household Buyer',
    'Retail Grocery Store Owner',
    'Restaurant / Hotel / Catering (HORECA)',
    'Supermarket Chain / Department Store',
    'Institutional Procurement Manager',
  ];

  static const List<String> idDocumentTypes = [
    'National Identity Card (NID)',
    'Citizenship Certificate',
    'Driving License',
    'Passport',
    'PAN / Business Registration',
  ];

  static const List<String> paymentMethods = [
    'eSewa / Khalti Digital Wallet',
    'Bank Direct Transfer (ConnectIPS)',
    'Cash on Delivery (COD)',
    'Escrow Direct Buyer Account',
  ];

  static const List<String> buyingRadiusOptions = [
    'Within 5 km',
    'Within 10 km',
    'Within 25 km',
    'Valley-wide / District-wide',
    'Nationwide Procurement',
  ];
}

/// Buyer-Specific Custom Widget: Buyer Preferences & Verification Card.
/// Used on the Buyer KYC Dashboard when verified or during profile inspection.
class BuyerPreferenceVerificationCard extends StatelessWidget {
  final String buyerType;
  final String idDocumentType;
  final String idNumber;
  final String preferredProducts;
  final String buyingRadius;
  final String preferredPayment;

  const BuyerPreferenceVerificationCard({
    super.key,
    required this.buyerType,
    required this.idDocumentType,
    required this.idNumber,
    required this.preferredProducts,
    required this.buyingRadius,
    required this.preferredPayment,
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
                Icons.shopping_bag,
                color: KYCDashboardTheme.primaryBlue,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Buyer Verification & Preferences',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: KYCDashboardTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildDetailRow(Icons.person_pin_outlined, 'Buyer Category', buyerType),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.badge_outlined, '$idDocumentType Number', idNumber),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.shopping_basket_outlined, 'Preferred Products', preferredProducts),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.my_location_outlined, 'Buying Radius', buyingRadius),
          const Divider(height: 18, color: KYCDashboardTheme.borderLight),
          _buildDetailRow(Icons.payment_outlined, 'Default Payment Method', preferredPayment),
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

/// Buyer-Specific Custom Form Fields Widget containing input fields dedicated to Buyers
class BuyerKYCFormFields extends StatelessWidget {
  final TextEditingController idNumberCtrl;
  final TextEditingController panNumberCtrl;
  final TextEditingController preferredProductsCtrl;
  final TextEditingController monthlyBudgetCtrl;
  final String selectedBuyerType;
  final String selectedIdType;
  final String selectedRadius;
  final String selectedPayment;
  final ValueChanged<String?> onBuyerTypeChanged;
  final ValueChanged<String?> onIdTypeChanged;
  final ValueChanged<String?> onRadiusChanged;
  final ValueChanged<String?> onPaymentChanged;

  const BuyerKYCFormFields({
    super.key,
    required this.idNumberCtrl,
    required this.panNumberCtrl,
    required this.preferredProductsCtrl,
    required this.monthlyBudgetCtrl,
    required this.selectedBuyerType,
    required this.selectedIdType,
    required this.selectedRadius,
    required this.selectedPayment,
    required this.onBuyerTypeChanged,
    required this.onIdTypeChanged,
    required this.onRadiusChanged,
    required this.onPaymentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KYCReusableDropdown<String>(
          label: 'Buyer Category',
          icon: Icons.person_pin_outlined,
          selectedValue: selectedBuyerType,
          items: BuyerKYCConstants.buyerTypes.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(
                type,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          onChanged: onBuyerTypeChanged,
        ),
        KYCReusableDropdown<String>(
          label: 'Identity Document Type',
          icon: Icons.credit_card_outlined,
          selectedValue: selectedIdType,
          items: BuyerKYCConstants.idDocumentTypes.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(
                type,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          onChanged: onIdTypeChanged,
        ),
        KYCOutlinedTextField(
          label: 'ID / Citizenship / NID Number',
          hintText: 'e.g. 12-01-79-08312',
          icon: Icons.badge_outlined,
          controller: idNumberCtrl,
        ),
        KYCOutlinedTextField(
          label: 'PAN / Firm Registration (Optional)',
          hintText: 'e.g. 609182374',
          icon: Icons.business_center_outlined,
          controller: panNumberCtrl,
          keyboardType: TextInputType.number,
        ),
        KYCOutlinedTextField(
          label: 'Preferred Products',
          hintText: 'e.g. Vegetables, Fruits, Dairy, Honey',
          icon: Icons.shopping_basket_outlined,
          controller: preferredProductsCtrl,
        ),
        KYCReusableDropdown<String>(
          label: 'Preferred Buying Radius',
          icon: Icons.my_location_outlined,
          selectedValue: selectedRadius,
          items: BuyerKYCConstants.buyingRadiusOptions.map((radius) {
            return DropdownMenuItem<String>(
              value: radius,
              child: Text(
                radius,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          onChanged: onRadiusChanged,
        ),
        KYCReusableDropdown<String>(
          label: 'Preferred Payment Method',
          icon: Icons.payment_outlined,
          selectedValue: selectedPayment,
          items: BuyerKYCConstants.paymentMethods.map((pm) {
            return DropdownMenuItem<String>(
              value: pm,
              child: Text(
                pm,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          onChanged: onPaymentChanged,
        ),
        KYCOutlinedTextField(
          label: 'Estimated Monthly Purchase Volume (NPR)',
          hintText: 'e.g. 250000',
          icon: Icons.account_balance_wallet_outlined,
          controller: monthlyBudgetCtrl,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
