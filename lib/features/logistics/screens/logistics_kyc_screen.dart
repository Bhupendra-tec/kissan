import 'package:flutter/material.dart';
import '../../kyc/shared/theme/kyc_theme.dart';
import '../../kyc/shared/widgets/kyc_button.dart';
import '../../kyc/shared/widgets/kyc_dropdown.dart';
import '../../kyc/shared/widgets/kyc_header.dart';
import '../../kyc/shared/widgets/kyc_text_field.dart';
import '../widgets/logistics_kyc_fields.dart';
import '../models/logistics_session.dart';

/// Logistics-specific KYC Verification Form Screen
class LogisticsKycScreen extends StatefulWidget {
  const LogisticsKycScreen({super.key});

  @override
  State<LogisticsKycScreen> createState() => _LogisticsKycScreenState();
}

class _LogisticsKycScreenState extends State<LogisticsKycScreen> {
  late TextEditingController _phoneCtrl;
  late TextEditingController _licenseCtrl;
  late TextEditingController _plateCtrl;
  late TextEditingController _baseCtrl;
  late TextEditingController _earningsCtrl;

  String? _selectedVehicleType;

  @override
  void initState() {
    super.initState();
    final user = LogisticsSession.instance.user;
    _phoneCtrl = TextEditingController(text: user?.phone ?? '');
    _licenseCtrl = TextEditingController(text: user?.licenseNumber ?? '');
    _plateCtrl = TextEditingController(text: user?.vehiclePlate ?? '');
    _baseCtrl = TextEditingController(text: user?.baseLocation ?? '');
    _earningsCtrl = TextEditingController(
      text: user?.monthlyEarnings.toInt().toString() ?? '',
    );
    _selectedVehicleType = user?.vehicleType.isNotEmpty == true
        ? user!.vehicleType
        : LogisticsKYCConstants.vehicleTypes[0];
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _licenseCtrl.dispose();
    _plateCtrl.dispose();
    _baseCtrl.dispose();
    _earningsCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final session = LogisticsSession.instance;
    final current = session.user;
    if (current == null) return;

    final earnings = double.tryParse(_earningsCtrl.text) ?? 0;
    final trips = 250 + (current.name.length * 7);

    session.submitKyc(
      current.copyWith(
        phone: _phoneCtrl.text.trim(),
        licenseNumber: _licenseCtrl.text.trim(),
        vehicleType: _selectedVehicleType ?? '',
        vehiclePlate: _plateCtrl.text.trim(),
        baseLocation: _baseCtrl.text.trim(),
        monthlyEarnings: earnings,
        totalTrips: trips,
        rating: 4.8,
      ),
    );

    Navigator.pop(context, KYCVerificationStatus.submitted);
  }

  @override
  Widget build(BuildContext context) {
    final user = LogisticsSession.instance.user;
    final name = user?.name ?? 'Logistics Partner';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'L';

    return Scaffold(
      backgroundColor: KYCDashboardTheme.lightBg,
      body: SafeArea(
        child: Column(
          children: [
            // Top Green Curved Header Banner (using KYCHeaderBanner)
            KYCHeaderBanner(
              name: name,
              role: user?.role ?? 'Logistics Partner',
              location: user?.address ?? 'Address not set',
              initial: initial,
              status: KYCVerificationStatus.unverified,
              onStatusBadgeTap: null,
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
                        'Verification Details',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: KYCDashboardTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Fill in your details to get verified and unlock the full dashboard.',
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
                        hintText: '98XXXXXXXX',
                        icon: Icons.phone_outlined,
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                      KYCOutlinedTextField(
                        label: 'Driving License Number',
                        hintText: 'e.g. 1234567890',
                        icon: Icons.badge_outlined,
                        controller: _licenseCtrl,
                      ),

                      // Reusable Dropdown for Vehicle Type
                      KYCReusableDropdown<String>(
                        label: 'Vehicle Type',
                        icon: Icons.local_shipping_outlined,
                        selectedValue: _selectedVehicleType,
                        items: LogisticsKYCConstants.vehicleTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedVehicleType = val);
                          }
                        },
                      ),

                      KYCOutlinedTextField(
                        label: 'Vehicle Number Plate',
                        hintText: 'e.g. Ba 2 Kha 4567',
                        icon: Icons.pin_outlined,
                        controller: _plateCtrl,
                      ),
                      KYCOutlinedTextField(
                        label: 'Base Location',
                        hintText: 'e.g. Bharatpur, Chitwan',
                        icon: Icons.location_on_outlined,
                        controller: _baseCtrl,
                      ),
                      KYCOutlinedTextField(
                        label: 'Expected Monthly Earnings (NPR)',
                        hintText: 'e.g. 35000',
                        icon: Icons.payments_outlined,
                        controller: _earningsCtrl,
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