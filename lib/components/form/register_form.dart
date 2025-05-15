import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/submit_button.dart';
import 'package:flutter_project/settings/routes.dart';
import 'package:flutter_project/util/email.dart';
import 'package:flutter_project/util/password.dart';
import '../../data/mock_users.dart';

class RegisterForm extends StatefulWidget{
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _userType;

  String? _validateRegister(String email) {
    var user = getUserByEmail(email);
    if(user != null) {
      return 'Existe um usuário com esse email';
    }
    else {
      return null;
    }
  }

  void _submitRegister() {
    if(_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final error = _validateRegister(email);
      if(error == null) {
        final name = _nameController.text;
        final password = _passwordController.text;
        addUser(email, password, name, _userType!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário registrado com sucesso!')),
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
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Nome', border: OutlineInputBorder()),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Preencha com um nome';
              }
              return null;
            }
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
            validator: Email.validate,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Senha', border: OutlineInputBorder()),
            obscureText: true,
            validator: Password.validate,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            value: _userType,
            decoration: const InputDecoration(hintText: 'Tipo de Usuário', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'Comprador', child: Text('Comprador')),
              DropdownMenuItem(value: 'Produtor', child: Text('Produtor'))
            ],
            onChanged: (value) => {
              setState(() {
                _userType = value;
              }) 
            },
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Selecione um Tipo';
              }
              return null;
            }
          ),
          const SizedBox(height: 24),
          SubmitButton(
            onPressed: _submitRegister, 
            text: 'Registrar'
          )
        ],
      ),
    );
  }
}