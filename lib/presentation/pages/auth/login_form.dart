import 'package:flutter/material.dart';
import 'package:flutter_project/core/components/appbar.dart';
import 'package:flutter_project/core/components/submit_button.dart';
import 'package:flutter_project/core/settings/routes.dart';
import 'package:flutter_project/domain/usecases/login_user_usecase.dart';
import 'package:flutter_project/presentation/stores/logged_user_store.dart';
import 'package:flutter_project/presentation/validators/email_validator.dart';
import 'package:flutter_project/presentation/validators/password_validator.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final LoginUserUseCase loginUserUseCase;

  const LoginForm({super.key, required this.loginUserUseCase});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailValidator = EmailValidator();
  final _passwordValidator = PasswordValidator();

  bool _isLoading = false;

  void _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      final user = await widget.loginUserUseCase(email, password);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );

      Provider.of<LoggedUserStore>(context, listen: false).setUser(user);
      Navigator.pushReplacementNamed(context, Routes.mainPage); 
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                          labelText: 'Email',
                          hintText: 'teste@email.com',
                          border: OutlineInputBorder(),
                        ),
                        validator: _emailValidator.validate,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: _passwordValidator.validate,
                      ),
                      const SizedBox(height: 24),
                      SubmitButton(
                        onPressed: _submitLogin,
                        text: 'Entrar',
                        isLoading: _isLoading, 
                        loadingText: 'Entrando...', 
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
