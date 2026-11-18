
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'google_signin_screen.dart';
import '../../home/screens/main_navigation_screen.dart';
import '../widgets/auth_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 38,
              color: Color(0xFF333333),
            ),
          ),

          const SizedBox(height: 30),

          const AuthTextField(
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 18),

          const AuthTextField(
            hint: 'Password',
            obscureText: true,
          ),

          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            height: 60,
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0798F5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 19),
              ),
            ),
          ),

          const SizedBox(height: 18),

          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Password recovery will be added later.',
                  ),
                ),
              );
            },
            child: const Text(
              'Forgot password?',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 17,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const _OrDivider(),

          const SizedBox(height: 28),

          GoogleAuthButton(
            text: 'Continue with Google',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GoogleSignInScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 18),

          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignupScreen(),
                ),
              );
            },
            child: const Text('New to Kissan? Create an account'),
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Colors.black, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'or',
            style: TextStyle(fontSize: 19),
          ),
        ),
        Expanded(child: Divider(color: Colors.black, thickness: 1)),
      ],
    );
  }
}
