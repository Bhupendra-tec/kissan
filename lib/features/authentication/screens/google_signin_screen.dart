
import 'package:flutter/material.dart';
import '../../home/screens/main_navigation_screen.dart';
import '../widgets/auth_widgets.dart';

class GoogleSignInScreen extends StatelessWidget {
  const GoogleSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const GoogleLetter(),

          const SizedBox(height: 18),

          const Text(
            'Sign in with Google',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 29,
              color: Color(0xFF333333),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Continue to Kissan using your Google account.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 30),

          const AuthTextField(
            hint: 'Google email address',
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainNavigationScreen(),
                  ),
                      (route) => false,
                );
              },
              child: const Text('Continue'),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Demo screen only. Google authentication is not connected.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
