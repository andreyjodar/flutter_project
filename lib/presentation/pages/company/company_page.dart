import 'package:flutter/material.dart';
import 'package:flutter_project/core/components/submit_button.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/usecases/delete_company_usecase.dart';
import 'package:flutter_project/presentation/components/info_card.dart';
import 'package:flutter_project/core/settings/routes.dart';

class CompanyPage extends StatelessWidget {
  final DeleteCompanyUseCase deleteCompanyUseCase;

  const CompanyPage({
    super.key,
    required this.deleteCompanyUseCase,
  });

  void _editCompany(BuildContext context, Company company) {
    Navigator.pushNamed(
      context,
      Routes.companyForm,
      arguments: company,
    ).then((_) {
      // Opcional: pode fazer algo após edição se necessário
    });
  }

  void _deleteCompany(BuildContext context, Company company) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir esta empresa?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await deleteCompanyUseCase(company.id);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empresa excluída com sucesso.')),
      );
      Navigator.pop(context, true); // Volta com sinal para atualizar lista
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir empresa: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Company company = ModalRoute.of(context)?.settings.arguments as Company;

    return Scaffold(
      appBar: AppBar(title: Text(company.name)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.store, size: 48),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          company.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InfoCard(icon: Icons.person, label: 'Proprietário', value: company.producer.name),
                const SizedBox(height: 8),
                InfoCard(icon: Icons.business, label: 'CNPJ', value: company.cnpj),
                const SizedBox(height: 8),
                InfoCard(icon: Icons.description, label: 'Descrição', value: company.description ?? 'Sem descrição'),
                const SizedBox(height: 8),
                InfoCard(icon: Icons.location_on, label: 'Endereço', value: company.address),
                const SizedBox(height: 8),
                InfoCard(icon: Icons.date_range, label: 'Data de Cadastro', value: company.registerDate.toIso8601String()),
                const SizedBox(height: 24),
                SubmitButton(
                  onPressed: () => _editCompany(context, company),
                  text: 'Editar Conta',
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.deepPurple,
                ),
                const SizedBox(height: 12),
                SubmitButton(
                  onPressed: () => _deleteCompany(context, company),
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
