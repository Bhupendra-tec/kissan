/// Flexible User Profile Model supporting Wholesaler, Buyer, Farmer, etc.
class UserProfileData {
  final String id;
  final String? avatarPath; // Local file path from ImagePicker
  final String? avatarUrl;  // Remote URL fallback
  final String firstName;
  final String lastName;
  final String role;        // e.g. "Farmer", "Wholesaler", "Buyer"
  final String email;
  final String phone;
  final String gender;
  final String dob;
  final String address;
  final String province;
  final String district;
  final String municipality;
  final String wardNumber;
  final String accountCreated;
  final bool isVerified;

  // Stats
  final int cropsCount;
  final int followersCount;
  final int transactionsCount;

  const UserProfileData({
    required this.id,
    this.avatarPath,
    this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.address,
    required this.province,
    required this.district,
    required this.municipality,
    required this.wardNumber,
    required this.accountCreated,
    this.isVerified = true,
    this.cropsCount = 12,
    this.followersCount = 248,
    this.transactionsCount = 36,
  });

  String get fullName => '$firstName $lastName'.trim();

  /// Initial sample profile matching the exact UI design in the screenshot
  factory UserProfileData.initialSample() {
    return const UserProfileData(
      id: 'usr_001',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&auto=format&fit=crop&q=80',
      firstName: 'Ram Bahadur',
      lastName: 'Thapa',
      role: 'Farmer',
      email: 'ramthapa@gmail.com',
      phone: '9841234567',
      gender: 'Male',
      dob: '15 Jan 1998',
      address: 'Bhaktapur, Nepal',
      province: 'Bagmati',
      district: 'Bhaktapur',
      municipality: 'Bhaktapur Municipality',
      wardNumber: '7',
      accountCreated: '12 Nov 2025',
      isVerified: true,
      cropsCount: 12,
      followersCount: 248,
      transactionsCount: 36,
    );
  }

  UserProfileData copyWith({
    String? id,
    String? avatarPath,
    String? avatarUrl,
    String? firstName,
    String? lastName,
    String? role,
    String? email,
    String? phone,
    String? gender,
    String? dob,
    String? address,
    String? province,
    String? district,
    String? municipality,
    String? wardNumber,
    String? accountCreated,
    bool? isVerified,
    int? cropsCount,
    int? followersCount,
    int? transactionsCount,
  }) {
    return UserProfileData(
      id: id ?? this.id,
      avatarPath: avatarPath ?? this.avatarPath,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      province: province ?? this.province,
      district: district ?? this.district,
      municipality: municipality ?? this.municipality,
      wardNumber: wardNumber ?? this.wardNumber,
      accountCreated: accountCreated ?? this.accountCreated,
      isVerified: isVerified ?? this.isVerified,
      cropsCount: cropsCount ?? this.cropsCount,
      followersCount: followersCount ?? this.followersCount,
      transactionsCount: transactionsCount ?? this.transactionsCount,
    );
  }
}
