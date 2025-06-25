import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/core/components/submit_button.dart';
import 'package:flutter_project/data/mock_product.dart';
import 'package:flutter_project/data/mock_purchase.dart';
import 'package:flutter_project/data/mock_users.dart';
import 'package:flutter_project/presentation/validators/address_validator.dart';
import 'package:flutter_project/presentation/validators/email_validator.dart';
import 'package:flutter_project/presentation/validators/integer_validator.dart';

class PurchaseForm extends StatefulWidget {
  @override
  State<PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllerProduct = TextEditingController();
  final _controllerCompany = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _emailValidator = EmailValidator();
  final _controllerAddress = TextEditingController();
  final _addressValidator = AddressValidator();
  final _controllerQuantity = TextEditingController();
  final _quantityValidator = IntegerValidator();

  String? _validatePurchase(String product, String company, String email) {
    final mockProduct = getProductByNameAndCompany(product, company);
    if (mockProduct == null) {
      return 'Produto não cadastrado';
    }
    final mockUser = getUserByEmail(email);
    if (mockUser == null) {
      return 'Comprador não cadastrado';
    }
    return null;
  }

  void _submitPurchase() {
    if (_formKey.currentState!.validate()) {
      final product = _controllerProduct.text;
      final company = _controllerCompany.text;
      final email = _controllerEmail.text;
      final error = _validatePurchase(product, company, email);
      if (error == null) {
        final quantity = int.tryParse(_controllerQuantity.text);
        final address = _controllerAddress.text;
        addPurchase(product, company, email, quantity!, address);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compra registrada com sucesso!')),
        );
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
      child: Column(
        children: [
          TextFormField(
            controller: _controllerProduct,
            decoration: const InputDecoration(
                hintText: 'Nome do Produto', border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Produto nulo ou vazio';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllerCompany,
            decoration: const InputDecoration(
                hintText: 'Nome da Empresa', border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Empresa nula ou vazia';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
              controller: _controllerEmail,
              decoration: const InputDecoration(
                  hintText: 'Email do Comprador', border: OutlineInputBorder()),
              validator: _emailValidator.validate),
          const SizedBox(height: 16),
          TextFormField(
              controller: _controllerAddress,
              decoration: const InputDecoration(
                  hintText: 'Endereço de Entrega',
                  border: OutlineInputBorder()),
              validator: _addressValidator.validate),
          const SizedBox(height: 16),
          TextFormField(
              controller: _controllerQuantity,
              decoration: const InputDecoration(
                  hintText: 'Quantidade', border: OutlineInputBorder()),
              validator: _quantityValidator.validate),
          const SizedBox(height: 24),
          SubmitButton(onPressed: _submitPurchase, text: 'Comprar')
        ],
      ),
    );
  }
}
