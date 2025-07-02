import 'package:flutter/material.dart';
import 'package:flutter_project/core/components/appbar.dart';
import 'package:flutter_project/core/components/submit_button.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/usecases/get_producers_usecase.dart';
import 'package:flutter_project/domain/usecases/register_company_usecase.dart';
import 'package:flutter_project/domain/usecases/update_company_usecase.dart';
import 'package:flutter_project/domain/valueobjects/Cnpj.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';
import 'package:flutter_project/presentation/validators/address_validator.dart';
import 'package:flutter_project/presentation/validators/cnpj_validator.dart';
import 'package:uuid/uuid.dart';

class CompanyForm extends StatefulWidget {
  final GetProducersUseCase getProducersUseCase;
  final RegisterCompanyUseCase registerCompanyUseCase;
  final UpdateCompanyUseCase updateCompanyUseCase;
  final Company? existingCompany; 

  const CompanyForm({
    super.key, 
    required this.getProducersUseCase, 
    required this.registerCompanyUseCase, 
    required this.updateCompanyUseCase, 
    this.existingCompany
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

  List<User> _producers = [];
  User? _selectedProducer;
  bool _isLoading = true;
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
      _selectedProducer = company.producer;
    }

    _loadProducers();
  }

  Future<void> _loadProducers() async {
    try {
      final producers = await widget.getProducersUseCase();
      setState(() {
        _producers = producers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar produtores: $e')),
      );
    }
  }

  void _submitCompany() async {
    if (_formKey.currentState!.validate() && _selectedProducer != null) {
      setState(() => _isSubmitting = true); // Ativa o loading do botão

      try {
        final company = Company(
          id: widget.existingCompany?.id ?? Uuid().v4(),  // Usando o id da empresa existente ou criando um novo
          name: _nameController.text.trim(),
          cnpj: Cnpj(_cnpjController.text),
          address: Address(_addressController.text),
          producer: _selectedProducer!,
          urlImage: _urlImageController.text.isEmpty ? null : _urlImageController.text.trim(),
          description: _descriptionController.text.isEmpty ? null : _descriptionController.text.trim(),
        );

        if (isEditing) {
          await widget.updateCompanyUseCase.call(company); // Atualiza a empresa
        } else {
          await widget.registerCompanyUseCase.call(company); // Cria uma nova empresa
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Empresa salva com sucesso!')),
        );

        if (isEditing) {
          Navigator.pop(context, company); // Atualiza a empresa
        } else {
          Navigator.pop(context); // Cria uma nova empresa
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao salvar empresa: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => _isSubmitting = false); // Desativa o loading
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.existingCompany == null ? 'Cadastro' : 'Editar Empresa', showAuthActions: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.store, size: 100, color: Colors.green),
              const SizedBox(height: 24),
              _isLoading ? const Center(child: CircularProgressIndicator()) 
              : Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder()
                      ),
                      validator: (value) =>
                        (value == null || value.isEmpty) ? 'Nome obrigatório' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _urlImageController,
                      decoration: const InputDecoration(
                        labelText: 'URL Imagem',
                        border: OutlineInputBorder()
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder()
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (widget.existingCompany == null)  // Mostrar esse campo apenas se for criação
                    DropdownButtonFormField<User>(
                      value: _selectedProducer,
                      items: _producers
                          .map((u) => DropdownMenuItem(
                                value: u,
                                child: Text(u.name),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() => _selectedProducer = value),
                      validator: (value) =>
                          value == null ? 'Selecione um produtor' : null,
                      decoration: const InputDecoration(
                        labelText: 'Produtor',
                        border: OutlineInputBorder()
                      ),
                    ),
                    if (widget.existingCompany == null)
                    const SizedBox(height: 16),
                    if (widget.existingCompany == null)
                    TextFormField(
                      controller: _cnpjController,
                      decoration: const InputDecoration(
                        labelText: 'CNPJ',
                        hintText: '00.000.000/0000-00', border: OutlineInputBorder()),
                      validator: _cnpjValidator.validate,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Endereço',
                        hintText: 'Rua Limoeiro, 99', border: OutlineInputBorder()
                      ),
                      validator: _addressValidator.validate,
                    ),
                    const SizedBox(height: 24),
                    SubmitButton(
                      onPressed: _submitCompany, 
                      text: widget.existingCompany == null ? 'Cadastrar' : 'Atualizar',
                      isLoading: _isSubmitting,
                      loadingText: 'Salvando...',
                    )
                  ],
                ),
              ),
              ]
            ),
          ),
        ),
    );
  }
}
