import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/appbar.dart';
import 'package:flutter_project/data/repository/user_repository.dart';
import 'package:flutter_project/pages/auth/forms/user_form.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository userRepository;

  const RegisterPage({super.key, required this.userRepository});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cadastro', showAuthActions: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 100, color: Colors.green),
                const SizedBox(height: 24),
                UserForm(userRepository: userRepository),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
