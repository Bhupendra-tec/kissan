
import 'package:flutter/material.dart';

// Path: lib/features/home/screens/main_navigation_screen.dart
import '../../experts/screens/vet_profile.dart' show VetProfilePage;
import '../../logistics/screens/driver_profile.dart' show DriverProfilePage;
import '../../profile/buyer_profile.dart';
import '../../profile/wholesaler_profile.dart';

/// Roles a user can pick on the signup screen.
enum UserRole { farmer, buyer, wholesaler, vet, logisticProvider }

extension UserRoleLabel on UserRole {
  String get label {
    switch (this) {
      case UserRole.farmer:
        return 'Farmer';
      case UserRole.buyer:
        return 'Buyer';
      case UserRole.wholesaler:
        return 'Wholesaler';
      case UserRole.vet:
        return 'Vet or Agriculture Expert';
      case UserRole.logisticProvider:
        return 'Logistic Provider';
    }
  }
}

class MainNavigationScreen extends StatefulWidget {
  /// Optional, so existing calls like `const MainNavigationScreen()`
  /// (e.g. from the Google sign-in screen) still compile.
  final UserRole? userRole;

  const MainNavigationScreen({super.key, this.userRole});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  static const int _profileIndex = 4;

  int selectedIndex = 0;

  /// True when this role has its own full profile screen.
  bool get _hasCustomProfile =>
      widget.userRole == UserRole.vet ||
      widget.userRole == UserRole.logisticProvider ||
      widget.userRole == UserRole.wholesaler ||
      widget.userRole == UserRole.buyer;

  Widget _buildProfilePage() {
    switch (widget.userRole) {
      case UserRole.vet:
        return const VetProfilePage();
      case UserRole.logisticProvider:
        return const DriverProfilePage();
      case UserRole.wholesaler:
        return const WholesalerProfilePage();
      case UserRole.buyer:
        return const BuyerProfilePage();
      case UserRole.farmer:
      default:
        return const _SimplePage(
          title: 'Profile',
          icon: Icons.person_outline,
          description: 'Your profile',
        );
    }
  }

  Widget _buildBody() {
    // Vet and driver profiles have their own header and SafeArea,
    // so they are shown without the outer SafeArea.
    if (selectedIndex == _profileIndex) {
      final profile = _buildProfilePage();
      return _hasCustomProfile ? profile : SafeArea(child: profile);
    }

    const pages = <Widget>[
      _SimplePage(
        title: 'Home',
        icon: Icons.home_outlined,
        description: 'Welcome to Kissan',
      ),
      _SimplePage(
        title: 'Market',
        icon: Icons.storefront_outlined,
        description: 'Explore agricultural products',
      ),
      _SimplePage(
        title: 'Create',
        icon: Icons.add_circle_outline,
        description: 'Create a new post or listing',
      ),
      _SimplePage(
        title: 'Community',
        icon: Icons.people_outline,
        description: 'Connect with the Kissan community',
      ),
    ];

    return SafeArea(child: pages[selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDDF3E3),
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Create',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Community',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const _SimplePage({
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 75,
            color: const Color(0xFF15963F),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
