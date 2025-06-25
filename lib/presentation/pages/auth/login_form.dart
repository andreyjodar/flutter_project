import 'package:flutter/material.dart';
import 'package:flutter_project/core/components/appbar.dart';
import 'package:flutter_project/core/components/submit_button.dart';
import 'package:flutter_project/data/repositories/user_repository.dart';
import 'package:flutter_project/presentation/validators/email_validator.dart';
import 'package:flutter_project/presentation/validators/password_validator.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  const LoginForm({super.key, required this.userRepository});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailValidator = EmailValidator();
  final _passwordController = TextEditingController();
  final _passwordValidator = PasswordValidator();

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final isValid = widget.userRepository.isValidUser(email, password);
      if (isValid == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso!')),
        );
        Navigator.pop(context);
      } else {
        final exists = widget.userRepository.getUserByEmail(email) != null;
        final message = exists ? 'Senha inválida' : 'Usuário não registrado';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email', border: OutlineInputBorder()),
                          validator: _emailValidator.validate),
                      const SizedBox(height: 16),
                      TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                              hintText: 'Senha', border: OutlineInputBorder()),
                          obscureText: true,
                          validator: _passwordValidator.validate),
                      const SizedBox(height: 24),
                      SubmitButton(onPressed: _submitLogin, text: 'Entrar')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
