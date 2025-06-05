import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/appbar.dart';
import 'package:flutter_project/components/form/login_form.dart';
import 'package:flutter_project/data/repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Login', showAuthActions: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 100, color: Colors.green),
                const SizedBox(height: 24),
                LoginForm(userRepository: userRepository),
              ],
            ),
          ),
        ),
      ),
    );
  }
}