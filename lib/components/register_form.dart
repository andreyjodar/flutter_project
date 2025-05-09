import 'package:flutter/material.dart';
import '../data/mock_users.dart';

class RegisterForm extends StatefulWidget{
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: ,
            decoration: ,
            validator: ,
          ),
          TextFormField(
            controller: ,
            decoration: ,
            validator: ,
          ),
          TextFormField(
            controller: ,
            decoration: ,
            validator: ,
          ),
          DropdownButtonFormField(
            items: const [
              DropdownMenuItem(value: 'Comprador', child: Text('Comprador')),
              DropdownMenuItem(value: 'Produtor', child: Text('Produtor'))
            ], 
            onChanged: (value) => {}
          )
        ],
      ),
    );
  }
}