import 'package:flutter/material.dart';
import 'package:flutter_project/domain/valueobjects/cnpj.dart';
import 'package:flutter_project/presentation/components/appbar.dart';
import 'package:flutter_project/presentation/components/submit_button.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';
import 'package:flutter_project/domain/usecases/register_company_usecase.dart';
import 'package:flutter_project/domain/usecases/update_company_usecase.dart';
import 'package:flutter_project/presentation/stores/logged_user_store.dart';
import 'package:flutter_project/presentation/validators/address_validator.dart';
import 'package:flutter_project/presentation/validators/cnpj_validator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CompanyForm extends StatefulWidget {
  final RegisterCompanyUseCase registerCompanyUseCase;
  final UpdateCompanyUseCase updateCompanyUseCase;
  final Company? existingCompany;

  const CompanyForm({
    super.key,
    required this.registerCompanyUseCase,
    required this.updateCompanyUseCase,
    this.existingCompany,
  });

  @override
  State<CompanyForm> createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _urlImageController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _addressController = TextEditingController();
  final _cnpjValidator = CnpjValidator();
  final _addressValidator = AddressValidator();

  final cnpjMaskFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  bool _isSubmitting = false;

  bool get isEditing => widget.existingCompany != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      final company = widget.existingCompany!;
      _nameController.text = company.name;
      _urlImageController.text = company.urlImage ?? '';
      _descriptionController.text = company.description ?? '';
      _cnpjController.text = company.cnpj;
      _addressController.text = company.address;
    }
  }

  void _submitCompany() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final loggedUser = Provider.of<LoggedUserStore>(context, listen: false).user;

      if (loggedUser == null) {
        throw Exception('Usuário logado não encontrado');
      }

      final company = Company(
        id: widget.existingCompany?.id ?? const Uuid().v4(),
        name: _nameController.text.trim(),
        cnpj: Cnpj(_cnpjController.text),
        address: Address(_addressController.text),
        producer: loggedUser,
        urlImage: _urlImageController.text.isEmpty ? null : _urlImageController.text.trim(),
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text.trim(),
      );

      if (isEditing) {
        await widget.updateCompanyUseCase.call(company);
      } else {
        await widget.registerCompanyUseCase.call(company);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empresa salva com sucesso!')),
      );

      Navigator.pop(context, company);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar empresa: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.existingCompany == null ? 'Cadastro' : 'Editar Empresa',
        showAuthActions: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.store, size: 100, color: Colors.green),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          (value == null || value.isEmpty) ? 'Nome obrigatório' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _urlImageController,
                      decoration: const InputDecoration(
                        labelText: 'URL Imagem',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if(!isEditing)
                    const SizedBox(height: 16),
                    if(!isEditing)
                    TextFormField(
                      controller: _cnpjController,
                      inputFormatters: [cnpjMaskFormatter],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'CNPJ',
                        hintText: '00.000.000/0000-00',
                        border: OutlineInputBorder(),
                      ),
                      validator: _cnpjValidator.validate,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Endereço',
                        hintText: 'Rua Limoeiro, 99',
                        border: OutlineInputBorder(),
                      ),
                      validator: _addressValidator.validate,
                    ),
                    const SizedBox(height: 24),
                    SubmitButton(
                      onPressed: _submitCompany,
                      text: widget.existingCompany == null ? 'Cadastrar' : 'Atualizar',
                      isLoading: _isSubmitting,
                      loadingText: 'Salvando...',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
