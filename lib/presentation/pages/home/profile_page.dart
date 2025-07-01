// presentation/pages/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/usecases/delete_user_usecase.dart';
import 'package:flutter_project/domain/usecases/update_user_usecase.dart';
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
      Provider.of<LoggedUserStore>(context, listen: false).clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir usuário: $e')),
      );
    }
  }

  void _editUser(BuildContext context, User user) async {
    // Implemente lógica de edição com um novo formulário ou pop-up
    // Por exemplo:
    // Navigator.push(context, MaterialPageRoute(builder: (_) => EditUserForm(user: user)));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoggedUserStore>(context).user;

    if (user == null) {
      return const Center(child: Text('Nenhum usuário logado.'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.person, size: 100, color: Colors.green),
            const SizedBox(height: 24),
            Text('Nome: ${user.name}', style: const TextStyle(fontSize: 18)),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _editUser(context, user),
              icon: const Icon(Icons.edit),
              label: const Text('Editar Conta'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _deleteUser(context, user),
              icon: const Icon(Icons.delete),
              label: const Text('Excluir Conta'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
