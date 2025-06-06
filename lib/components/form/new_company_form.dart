import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/submit_button.dart';
import 'package:flutter_project/data/mock_companies.dart';
import 'package:flutter_project/data/mock_users.dart';
import 'package:flutter_project/util/address.dart';
import 'package:flutter_project/util/cnpj.dart';
import 'package:flutter_project/util/email.dart';

class NewCompanyForm extends StatefulWidget {
  @override
  State<NewCompanyForm> createState() => _NewCompanyFormState();
}

class _NewCompanyFormState extends State<NewCompanyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailValidator = EmailValidator();
  final _cnpjController = TextEditingController();
  final _cnpjValidator = CnpjValidator();
  final _addressController = TextEditingController();
  final _addressValidator = AddressValidator();

  String? _validateCompany(String name, String email, String cnpj) {
    var mockCompanyName = getCompanyByName(name);
    var mockCompanyCnpj = getCompanyByCnpj(cnpj);
    var mockUser = getUserByEmail(email);
    if (mockCompanyName != null || mockCompanyCnpj != null) {
      return 'Empresa já cadastrada';
    }
    if (mockUser == null) {
      return 'Email não registrado por um Produtor';
    }
    if (mockUser['type'] == 'Comprador') {
      return 'Usuário sem premissão de Produtor';
    }
    return null;
  }

  void _submitCompany() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final cnpj = _cnpjController.text;
      final error = _validateCompany(name, email, cnpj);
      if (error == null) {
        final address = _addressController.text;
        addCompany(name, email, cnpj, address);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Empresa registrada com sucesso!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  return 'Nome nulo ou vazio';
                }
                return null;
              }),
          const SizedBox(height: 16),
          TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                  hintText: 'Email', border: OutlineInputBorder()),
              validator: _emailValidator.validate),
          const SizedBox(height: 16),
          TextFormField(
              controller: _cnpjController,
              decoration: const InputDecoration(
                  hintText: 'CNPJ', border: OutlineInputBorder()),
              validator: _cnpjValidator.validate),
          const SizedBox(height: 16),
          TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                  hintText: 'Endereço', border: OutlineInputBorder()),
              validator: _addressValidator.validate),
          const SizedBox(height: 24),
          SubmitButton(onPressed: _submitCompany, text: 'Cadastrar')
        ],
      ),
    );
  }
}
