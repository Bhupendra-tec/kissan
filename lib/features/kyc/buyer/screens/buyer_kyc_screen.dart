import 'package:flutter/material.dart';
import '../../shared/theme/kyc_theme.dart';
import '../../shared/widgets/kyc_button.dart';
import '../../shared/widgets/kyc_text_field.dart';
import '../widgets/buyer_kyc_fields.dart';

/// Buyer-Specific KYC Verification Form Screen
class BuyerKYCScreen extends StatefulWidget {
  final String? initialPhone;
  final String? initialLocation;
  final String? initialName;

  const BuyerKYCScreen({
    super.key,
    this.initialName = 'Srijana Karki',
    this.initialPhone = '9841234567',
    this.initialLocation = 'Budhanilkantha, Kathmandu',
  });

  @override
  State<BuyerKYCScreen> createState() => _BuyerKYCScreenState();
}

class _BuyerKYCScreenState extends State<BuyerKYCScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _locationCtrl;
  late TextEditingController _idNumberCtrl;
  late TextEditingController _panNumberCtrl;
  late TextEditingController _preferredProductsCtrl;
  late TextEditingController _monthlyBudgetCtrl;

  String _selectedBuyerType = BuyerKYCConstants.buyerTypes[0];
  String _selectedIdType = BuyerKYCConstants.idDocumentTypes[0];
  String _selectedRadius = BuyerKYCConstants.buyingRadiusOptions[1]; // Within 10 km
  String _selectedPayment = BuyerKYCConstants.paymentMethods[0]; // eSewa / Khalti

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _phoneCtrl = TextEditingController(text: widget.initialPhone);
    _locationCtrl = TextEditingController(text: widget.initialLocation);
    _idNumberCtrl = TextEditingController(text: '12-01-79-08312');
    _panNumberCtrl = TextEditingController(text: '609182374');
    _preferredProductsCtrl = TextEditingController(text: 'Vegetables, Fruits, Dairy');
    _monthlyBudgetCtrl = TextEditingController(text: '250000');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _locationCtrl.dispose();
    _idNumberCtrl.dispose();
    _panNumberCtrl.dispose();
    _preferredProductsCtrl.dispose();
    _monthlyBudgetCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Buyer KYC submitted successfully. Verification under review!'),
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
                          'Buyer KYC Verification',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Verify buyer identity & procurement limits',
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
                      Icons.shopping_bag,
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
                        'Buyer Verification Details',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: KYCDashboardTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Complete identity verification to unlock direct farm buying, escrow payment protection, and higher monthly order limits.',
                        style: TextStyle(
                          fontSize: 12,
                          color: KYCDashboardTheme.textMuted,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Basic Account Information
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
                        label: 'Delivery Address',
                        hintText: 'e.g. Budhanilkantha, Kathmandu',
                        icon: Icons.location_on_outlined,
                        controller: _locationCtrl,
                      ),

                      // Buyer Specific Form Fields Component
                      BuyerKYCFormFields(
                        idNumberCtrl: _idNumberCtrl,
                        panNumberCtrl: _panNumberCtrl,
                        preferredProductsCtrl: _preferredProductsCtrl,
                        monthlyBudgetCtrl: _monthlyBudgetCtrl,
                        selectedBuyerType: _selectedBuyerType,
                        selectedIdType: _selectedIdType,
                        selectedRadius: _selectedRadius,
                        selectedPayment: _selectedPayment,
                        onBuyerTypeChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedBuyerType = val);
                          }
                        },
                        onIdTypeChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedIdType = val);
                          }
                        },
                        onRadiusChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedRadius = val);
                          }
                        },
                        onPaymentChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedPayment = val);
                          }
                        },
                      ),

                      const SizedBox(height: 10),

                      // Reusable Primary Button
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
