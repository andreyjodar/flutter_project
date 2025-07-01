// presentation/pages/profile/profile_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/core/components/submit_button.dart';
import 'package:flutter_project/core/settings/routes.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/usecases/delete_user_usecase.dart';
import 'package:flutter_project/domain/usecases/register_user_usecase.dart';
import 'package:flutter_project/domain/usecases/update_user_usecase.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_user_dao.dart';
import 'package:flutter_project/infrastructure/repositories/user_repository_impl.dart';
import 'package:flutter_project/presentation/pages/auth/user_form.dart';
import 'package:flutter_project/presentation/stores/logged_user_store.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final DeleteUserUseCase deleteUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  const ProfilePage({
    super.key,
    required this.deleteUserUseCase,
    required this.updateUserUseCase,
  });

  void _deleteUser(BuildContext context, User user) async {
    try {
      await deleteUserUseCase(user.id);
      if (!context.mounted) return;
      Provider.of<LoggedUserStore>(context, listen: false).clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sua conta foi excluída com sucesso!')),
      );
      Navigator.pushReplacementNamed(context, Routes.login);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir usuário: $e')),
      );
    }
  }

  void _editUser(BuildContext context, User user) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserForm(
          registerUserUseCase: RegisterUserUseCase(UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))),
          updateUserUseCase: UpdateUserUseCase(UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))),
          existingUser: Provider.of<LoggedUserStore>(context, listen: false).user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoggedUserStore>(context).user;

    if (user == null) {
      return const Center(child: Text('Nenhum usuário logado.'));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 30, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          user.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('Email'),
                  subtitle: Text(user.email),
                ),
                const SizedBox(height: 8),
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: user.isProducer() ? Icon(Icons.sell_outlined) : Icon(Icons.money_rounded),
                  title: const Text('Tipo de Conta'),
                  subtitle: Text(user.isProducer() ? 'Produtor' : 'Compador'),
                ),
                const SizedBox(height: 8),
                if (user.address != null)
                  ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    leading: const Icon(Icons.location_on_outlined),
                    title: const Text('Endereço'),
                    subtitle: Text(user.address!),
                  ),
                const SizedBox(height: 8), 
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: const Icon(Icons.date_range_outlined),
                  title: const Text('Data de Cadastro'),
                  subtitle: Text(user.registerDate.toIso8601String()),
                ),
                const Spacer(),

                // Botões finais
                SubmitButton(
                  onPressed: () => _editUser(context, user),
                  text: 'Editar Conta',
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.deepPurple,
                  // você pode ajustar os ícones caso deseje integrá-los dentro do botão
                ),

                const SizedBox(height: 12),

                SubmitButton(
                  onPressed: () => _deleteUser(context, user),
                  text: 'Excluir Conta',
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ),
      ),
    );
  }

}
