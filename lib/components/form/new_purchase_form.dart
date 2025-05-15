import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/components/elements/submit_button.dart';
import 'package:flutter_project/data/mock_product.dart';
import 'package:flutter_project/data/mock_purchase.dart';
import 'package:flutter_project/data/mock_users.dart';
import 'package:flutter_project/util/address.dart';
import 'package:flutter_project/util/email.dart';
import 'package:flutter_project/util/integer.dart';

class NewPurchaseForm extends StatefulWidget {
  @override
  State<NewPurchaseForm> createState() => _NewPurchaseFormState();
}

class _NewPurchaseFormState extends State<NewPurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllerProduct = TextEditingController();
  final _controllerCompany = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerAddress = TextEditingController();
  final _controllerQuantity = TextEditingController();

  String? _validatePurchase(String product, String company, String email) {
    final mockProduct = getProductByNameAndCompany(product, company);
    if(mockProduct == null) {
      return 'Produto não cadastrado';
    }
    final mockUser = getUserByEmail(email);
    if(mockUser == null) {
      return 'Comprador não cadastrado';
    }
    return null;
  }

  void _submitPurchase() {
    if(_formKey.currentState!.validate()) {
      final product = _controllerProduct.text;
      final company = _controllerCompany.text;
      final email = _controllerEmail.text;
      final error = _validatePurchase(product, company, email);
      if(error == null) {
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
            decoration: const InputDecoration(hintText: 'Nome do Produto', border: OutlineInputBorder()),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Produto nulo ou vazio';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllerCompany,
            decoration: const InputDecoration(hintText: 'Nome da Empresa', border: OutlineInputBorder()),
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Empresa nula ou vazia';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllerEmail,
            decoration: const InputDecoration(hintText: 'Email do Comprador', border: OutlineInputBorder()),
            validator: Email.validate
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllerAddress,
            decoration: const InputDecoration(hintText: 'Endereço de Entrega', border: OutlineInputBorder()),
            validator: Address.validate
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllerQuantity,
            decoration: const InputDecoration(hintText: 'Quantidade', border: OutlineInputBorder()),
            validator: Integer.validate
          ),
          const SizedBox(height: 24),
          SubmitButton(
            onPressed: _submitPurchase,
            text: 'Comprar'
          )
        ],
      ),
    );
  }
}