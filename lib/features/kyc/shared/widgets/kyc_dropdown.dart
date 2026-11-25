import 'package:flutter/material.dart';
import '../theme/kyc_theme.dart';

/// Generic Reusable Outlined Dropdown Field.
/// Developer passes options, label, icon, selectedValue, and onChanged callback.
class KYCReusableDropdown<T> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T? selectedValue;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const KYCReusableDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<T>(
        initialValue: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 13,
            color: KYCDashboardTheme.textMuted,
          ),
          prefixIcon: Icon(icon, color: KYCDashboardTheme.primaryBlue),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: KYCDashboardTheme.borderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: KYCDashboardTheme.primaryBlue, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: KYCDashboardTheme.textDark,
        ),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
