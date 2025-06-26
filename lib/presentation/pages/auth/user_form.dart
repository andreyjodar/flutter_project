import 'package:flutter/material.dart';
import 'package:flutter_project/core/components/appbar.dart';
import 'package:flutter_project/core/components/submit_button.dart';
import 'package:flutter_project/core/settings/routes.dart';
import 'package:flutter_project/presentation/validators/address_validator.dart';
import 'package:flutter_project/presentation/validators/email_validator.dart';
import 'package:flutter_project/presentation/validators/password_validator.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/usecases/register_user_usecase.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';
import 'package:flutter_project/domain/valueobjects/email.dart';
import 'package:flutter_project/domain/valueobjects/password.dart';
import 'package:uuid/uuid.dart';

class UserForm extends StatefulWidget {
  final RegisterUserUseCase registerUserUseCase;
  const UserForm({super.key, required this.registerUserUseCase});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  String? _userType;

  final _emailValidator = EmailValidator();
  final _passwordValidator = PasswordValidator();
  final _addressValidator = AddressValidator();

  bool _isLoading = false;

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = User(
        id: const Uuid().v4(), 
        name: _nameController.text,
        email: Email(_emailController.text),
        password: Password(_passwordController.text),

        type: _userType == 'producer' ? UserType.producer : UserType.buyer,
        address: Address(_addressController.text),
      );

      await widget.registerUserUseCase.call(user);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário registrado com sucesso!')),
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.mainPage);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao registrar: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: 'Nome', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Preencha com um nome';
                          }
                          return null;
                        },
                      ),
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
                      DropdownButtonFormField<String>(
                        value: _userType,
                        decoration: const InputDecoration(
                            hintText: 'Tipo de Usuário',
                            border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(
                              value: 'buyer', child: Text('Comprador')),
                          DropdownMenuItem(
                              value: 'producer', child: Text('Produtor')),
                        ],
                        onChanged: (value) => setState(() => _userType = value),
                        validator: (value) =>
                            value == null ? 'Selecione um tipo de usuário' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                            hintText: 'Endereço', border: OutlineInputBorder()),
                        validator: _addressValidator.validate,
                      ),
                      const SizedBox(height: 24),
                      SubmitButton(
                        onPressed: _submitForm,
                        text: 'Registrar',
                        isLoading: _isLoading, // O novo parâmetro isLoading
                        loadingText: 'Registrando...', // Opcional, para feedback específico
                      ),
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
