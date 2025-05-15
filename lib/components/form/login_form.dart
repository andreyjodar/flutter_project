import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/submit_button.dart';
import 'package:flutter_project/settings/routes.dart';
import 'package:flutter_project/util/email.dart';
import 'package:flutter_project/util/password.dart';
import '../../data/mock_users.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _validateUser(String email, String password) {
    var user = getUserByEmail(email);
    if(user == null) {
      return 'Usuário não registrado';
    }
    if(user['password'] != password) {
      return 'Senha inválida';
    }
    return null;
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final error = _validateUser(email, password);
      if(error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso!')),
        );
        Navigator.pushReplacementNamed(context, Routes.profile);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
            validator: Email.validate
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Senha', border: OutlineInputBorder()),
            obscureText: true,
            validator: Password.validate
          ),
          const SizedBox(height: 24),
          SubmitButton(
            onPressed: _submitLogin, 
            text: 'Entrar'
          )
        ],
      )
    );
  }
}