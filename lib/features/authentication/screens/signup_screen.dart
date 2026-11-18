
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'google_signin_screen.dart';
import '../../home/screens/main_navigation_screen.dart';
import '../widgets/auth_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? selectedRole;

  final List<String> roles = [
    'Farmer',
    'Buyer',
    'Wholesaler',
    'Vet or Agriculture Expert',
    'Logistic Provider',
  ];

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 38,
              color: Color(0xFF333333),
            ),
          ),

          const SizedBox(height: 28),

          const AuthTextField(hint: 'Name'),

          const SizedBox(height: 16),

          const AuthTextField(
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 16),

          const AuthTextField(
            hint: 'Password',
            obscureText: true,
          ),

          const SizedBox(height: 16),

          // User role dropdown
          DropdownButtonFormField<String>(
            value: selectedRole,
            isExpanded: true,
            decoration: InputDecoration(
              hintText: 'Select Your Role',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFD0D7E2),
                  width: 1.4,
                ),
              ),
            ),
            items: roles.map((role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(
                  role,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedRole = value;
              });
            },
          ),

          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (selectedRole == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select your role.'),
                    ),
                  );
                  return;
                }

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
                'Sign up',
                style: TextStyle(fontSize: 19),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const _SignupOrDivider(),

          const SizedBox(height: 26),

          GoogleAuthButton(
            text: 'Sign Up with Google',
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
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
            child: const Text('Already have an account? Login'),
          ),
        ],
      ),
    );
  }
}

class _SignupOrDivider extends StatelessWidget {
  const _SignupOrDivider();

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
