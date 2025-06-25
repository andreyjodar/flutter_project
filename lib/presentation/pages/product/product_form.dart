import 'package:flutter/material.dart';
import 'package:flutter_project/core/components/submit_button.dart';
import 'package:flutter_project/data/mock_companies.dart';
import 'package:flutter_project/data/mock_product.dart';
import 'package:flutter_project/presentation/validators/decimal_validator.dart';

class ProductForm extends StatefulWidget {
  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _priceController = TextEditingController();
  final _priceValidator = DecimalValidator();
  String? _productType;
  String? _productUn;

  String? _validateProduct(String name, String company) {
    var mockCompany = getCompanyByName(company);
    if (mockCompany == null) {
      return 'Empresa não cadastrada';
    }
    var mockProduct = getProductByNameAndCompany(name, company);
    if (mockProduct != null) {
      return 'Produto já cadastrado';
    }
    return null;
  }

  void _submitProduct() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final company = _companyController.text;
      final error = _validateProduct(name, company);
      if (error == null) {
        final price = double.parse(_priceController.text.replaceAll(',', '.'));
        addProduct(name, _productType!, price, _productUn!, company);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto registrado com sucesso!')),
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
                return 'Preencha com um nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
              value: _productType,
              decoration: const InputDecoration(
                  hintText: 'Tipo de Produto', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'Verduras', child: Text('Verduras')),
                DropdownMenuItem(
                    value: 'Hortaliças', child: Text('Hortaliças')),
                DropdownMenuItem(value: 'Frutas', child: Text('Frutas')),
                DropdownMenuItem(value: 'Tubéculos', child: Text('Tubérculos')),
                DropdownMenuItem(value: 'Grãos', child: Text('Grãos'))
              ],
              onChanged: (value) => {
                    setState(() {
                      _productType = value;
                    })
                  },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Selecione um Tipo';
                }
                return null;
              }),
          const SizedBox(height: 16),
          DropdownButtonFormField(
              value: _productUn,
              decoration: const InputDecoration(
                  hintText: 'Unidade de Medida', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'Unidade', child: Text('Unidade')),
                DropdownMenuItem(value: 'Bandeja', child: Text('Bandeja')),
                DropdownMenuItem(
                    value: 'Quilograma', child: Text('Quilograma')),
                DropdownMenuItem(value: 'Maço', child: Text('Maço')),
              ],
              onChanged: (value) => {
                    setState(() {
                      _productUn = value;
                    })
                  },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Selecione um Tipo';
                }
                return null;
              }),
          const SizedBox(height: 16),
          TextFormField(
            controller: _priceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
                hintText: 'Preço', border: OutlineInputBorder()),
            validator: _priceValidator.validate,
          ),
          const SizedBox(height: 16),
          TextFormField(
              controller: _companyController,
              decoration: const InputDecoration(
                  hintText: 'Empresa', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha com o nome de uma empresa';
                }
                return null;
              }),
          const SizedBox(height: 24),
          SubmitButton(onPressed: _submitProduct, text: 'Registrar')
        ],
      ),
    );
  }
}
