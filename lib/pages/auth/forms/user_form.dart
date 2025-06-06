import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/submit_button.dart';
import 'package:flutter_project/data/entity/user.dart';
import 'package:flutter_project/data/repository/user_repository.dart';
import 'package:flutter_project/settings/routes.dart';
import 'package:flutter_project/util/email.dart';
import 'package:flutter_project/util/password.dart';

class UserForm extends StatefulWidget {
  final UserRepository userRepository;
  final User? user;
  const UserForm({super.key, required this.userRepository, this.user});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailValidator = EmailValidator();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordValidator = PasswordValidator();
  String? _userType;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      _passwordController.text = widget.user!.password;
      _userType = widget.user!.type;
    }
  }

  String? _validateDuplicateEmail(String email) {
    final existingUser = widget.userRepository.getUserByEmail(email);
    if (existingUser != null && existingUser.id != widget.user?.id) {
      return 'Já existe um usuário com esse e-mail';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final name = _nameController.text;
      final password = _passwordController.text;
      final type = _userType!;

      final duplicateEmailError = _validateDuplicateEmail(email);
      if (duplicateEmailError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(duplicateEmailError)),
        );
        return;
      }

      if (widget.user == null) {
        final newUser = User(
          name: name,
          email: email,
          password: password,
          type: type,
        );
        widget.userRepository.addUser(newUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário registrado com sucesso!')),
        );
      } else {
        final updatedUser = User(
          id: widget.user!.id,
          name: name,
          email: email,
          password: password,
          type: type,
        );
        widget.userRepository.updateUser(updatedUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário atualizado com sucesso!')),
        );
      }

      Navigator.pushReplacementNamed(context, Routes.mainPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  hintText: 'Nome', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha com um nome';
                }
                return null;
              }),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
                hintText: 'Email', border: OutlineInputBorder()),
            validator: _emailValidator.validate,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
                hintText: 'Senha', border: OutlineInputBorder()),
            obscureText: true,
            validator: _passwordValidator.validate,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
              value: _userType,
              decoration: const InputDecoration(
                  hintText: 'Tipo de Usuário', border: OutlineInputBorder()),
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
                if (value == null || value.isEmpty) {
                  return 'Selecione um Tipo';
                }
                return null;
              }),
          const SizedBox(height: 24),
          SubmitButton(
              onPressed: _submitForm,
              text: isEditing ? 'Atualizar' : 'Registrar')
        ],
      ),
    );
  }
}
