import 'package:flutter/foundation.dart';

/// In-memory (no-backend) state for the logistics user.
///
/// A single [LogisticsUser] instance lives in [LogisticsSession] and is shared
/// across the dashboard, the KYC form and the profile screen. Since there is
/// no backend, mutating [LogisticsSession.value] is what "saves" the data for
/// the current app run.
class LogisticsUser {
  final String name;
  final String role;
  final String address;
  final bool kycFilled;

  // Filled-in KYC details (meaningful only once kycFilled == true)
  final String phone;
  final String licenseNumber;
  final String vehicleType;
  final String vehiclePlate;
  final String baseLocation;
  final double monthlyEarnings;
  final int totalTrips;
  final double rating;

  const LogisticsUser({
    required this.name,
    required this.role,
    this.address = '',
    this.kycFilled = false,
    this.phone = '',
    this.licenseNumber = '',
    this.vehicleType = '',
    this.vehiclePlate = '',
    this.baseLocation = '',
    this.monthlyEarnings = 0,
    this.totalTrips = 0,
    this.rating = 0,
  });

  /// User right after signup, before KYC.
  factory LogisticsUser.initial({
    required String name,
    required String role,
    String address = '',
  }) {
    return LogisticsUser(name: name, role: role, address: address);
  }

  LogisticsUser copyWith({
    String? name,
    String? role,
    String? address,
    bool? kycFilled,
    String? phone,
    String? licenseNumber,
    String? vehicleType,
    String? vehiclePlate,
    String? baseLocation,
    double? monthlyEarnings,
    int? totalTrips,
    double? rating,
  }) {
    return LogisticsUser(
      name: name ?? this.name,
      role: role ?? this.role,
      address: address ?? this.address,
      kycFilled: kycFilled ?? this.kycFilled,
      phone: phone ?? this.phone,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      vehicleType: vehicleType ?? this.vehicleType,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      baseLocation: baseLocation ?? this.baseLocation,
      monthlyEarnings: monthlyEarnings ?? this.monthlyEarnings,
      totalTrips: totalTrips ?? this.totalTrips,
      rating: rating ?? this.rating,
    );
  }
}

/// Holds the current logistics user and notifies listeners on change.
class LogisticsSession extends ChangeNotifier {
  LogisticsSession._();

  static final LogisticsSession instance = LogisticsSession._();

  LogisticsUser? _user;
  LogisticsUser? get user => _user;

  bool get isLoggedIn => _user != null;
  bool get isKycFilled => _user?.kycFilled ?? false;

  /// Start (or restart) a session for a freshly signed-up/logged-in user.
  void start(LogisticsUser user) {
    _user = user;
    notifyListeners();
  }

  /// Save the KYC form result and mark the user as verified.
  void completeKyc(LogisticsUser user) {
    _user = user.copyWith(kycFilled: true);
    notifyListeners();
  }

  void update(LogisticsUser user) {
    _user = user;
    notifyListeners();
  }

  void signOut() {
    _user = null;
    notifyListeners();
  }
}