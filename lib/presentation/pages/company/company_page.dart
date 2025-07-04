import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/components/submit_button.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/usecases/delete_company_usecase.dart';
import 'package:flutter_project/presentation/components/info_card.dart';
import 'package:flutter_project/core/settings/routes.dart';
import 'package:flutter_project/presentation/stores/logged_user_store.dart';
import 'package:provider/provider.dart';

class CompanyPage extends StatefulWidget {
  final DeleteCompanyUseCase deleteCompanyUseCase;
  final Company initialCompany;

  const CompanyPage({
    super.key,
    required this.deleteCompanyUseCase,
    required this.initialCompany,
  });

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  late Company company;
  bool _isProducer = false;

  @override
  void initState() {
    super.initState();
    company = widget.initialCompany;
    
    // Verifica se o usuário logado é do tipo producer
    final user = Provider.of<LoggedUserStore>(context, listen: false).user;
    if (user != null && user.type == UserType.producer) {
      _isProducer = true;  // Habilita os botões se for produtor
    }
  }

  void _editCompany(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.companyForm,
      arguments: company,
    ).then((result) {
      if (result != null && result is Company) {
        setState(() {
          company = result;
        });
      }
    });
  }

  void _deleteCompany(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir esta empresa?'),
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
      await widget.deleteCompanyUseCase(company.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empresa excluída com sucesso.')),
      );
      Navigator.pop(context, true); // Retorna para ShoppingPage com sinal de alteração
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir empresa: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InfoCard(
                  icon: Icons.person,
                  label: 'Proprietário',
                  value: company.producer.name,
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.business,
                  label: 'CNPJ',
                  value: company.cnpj,
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.description,
                  label: 'Descrição',
                  value: company.description ?? 'Sem descrição',
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.location_on,
                  label: 'Endereço',
                  value: company.address,
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.date_range,
                  label: 'Data de Cadastro',
                  value: company.registerDate.toIso8601String(),
                ),
                const SizedBox(height: 24),
                // Condicional para exibir os botões apenas se o usuário for 'producer'
                if (_isProducer) ...[
                  SubmitButton(
                    onPressed: () => _editCompany(context),
                    text: 'Editar Empresa',
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.deepPurple,
                  ),
                  const SizedBox(height: 12),
                  SubmitButton(
                    onPressed: () => _deleteCompany(context),
                    text: 'Excluir Empresa',
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
