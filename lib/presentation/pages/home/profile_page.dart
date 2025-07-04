// presentation/pages/profile/profile_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/components/submit_button.dart';
import 'package:flutter_project/core/settings/routes.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/usecases/delete_user_usecase.dart';
import 'package:flutter_project/domain/usecases/register_user_usecase.dart';
import 'package:flutter_project/domain/usecases/update_user_usecase.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_user_dao.dart';
import 'package:flutter_project/infrastructure/repositories/user_repository_impl.dart';
import 'package:flutter_project/presentation/components/info_card.dart';
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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView( // <-- Adicionado aqui
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagem e nome
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person, size: 48),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          user.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                InfoCard(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: user.email,
                ),
                const SizedBox(height: 8),

                InfoCard(
                  icon: user.isProducer() ? Icons.sell_outlined : Icons.money_rounded,
                  label: 'Tipo da Conta',
                  value: user.isProducer() ? 'Produtor' : 'Comprador',
                ),
                const SizedBox(height: 8),

                InfoCard(
                  icon: Icons.location_on_outlined,
                  label: 'Endereço',
                  value: user.address,
                ),
                const SizedBox(height: 8),

                InfoCard(
                  icon: Icons.date_range_outlined,
                  label: 'Data de Cadastro',
                  value: user.registerDate.toIso8601String(),
                ),
                const SizedBox(height: 24), // espaço antes dos botões

                SubmitButton(
                  onPressed: () => _editUser(context, user),
                  text: 'Editar Conta',
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.deepPurple,
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
      ),
    );
  }

}
