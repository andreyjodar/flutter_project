import 'package:flutter/material.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/domain/usecases/register_product_usecase.dart';
import 'package:flutter_project/domain/usecases/update_product_usecase.dart';
import 'package:flutter_project/presentation/components/submit_button.dart';
import 'package:flutter_project/presentation/validators/decimal_validator.dart';
import 'package:uuid/uuid.dart';

class ProductForm extends StatefulWidget {
  final RegisterProductUseCase registerProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final Company currentCompany;
  final Product? existingProduct;

  const ProductForm({
    super.key,
    required this.registerProductUseCase,
    required this.updateProductUseCase,
    required this.currentCompany,
    this.existingProduct,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  final _priceValidator = DecimalValidator();

  bool _isSubmitting = false;
  bool get isEditing => widget.existingProduct != null;

  ProductType? _productType;
  ProductUnit? _productUnit;
  ProductStatus? _productStatus;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      final product = widget.existingProduct!;
      _nameController.text = product.name;
      _descriptionController.text = product.description ?? '';
      _priceController.text = product.price.toStringAsFixed(2).replaceAll('.', ',');
      _productType = product.type;
      _productStatus = product.status;
      _productUnit = product.unit;
    } else {
      _productStatus = ProductStatus.available; // valor padrão
    }
  }

  Future<void> _submitProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final product = Product(
        id: isEditing ? widget.existingProduct!.id : const Uuid().v4(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
        type: _productType!, // só pode ser null em modo criação
        unit: _productUnit!,
        status: _productStatus!,
        price: double.parse(_priceController.text.replaceAll(',', '.')),
        company: widget.currentCompany,
      );

      if (isEditing) {
        await widget.updateProductUseCase.call(product);
      } else {
        await widget.registerProductUseCase.call(product);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto salvo com sucesso!')),
      );

      Navigator.pop(context, product);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar produto: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Produto' : 'Novo Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha com um nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                if (!isEditing) ...[
                  DropdownButtonFormField<ProductType>(
                    value: _productType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Produto',
                      border: OutlineInputBorder(),
                    ),
                    items: ProductType.values
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type.name),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _productType = value),
                    validator: (value) {
                      if (value == null) return 'Selecione um tipo';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                DropdownButtonFormField<ProductUnit>(
                  value: _productUnit,
                  decoration: const InputDecoration(
                    labelText: 'Unidade de Medida',
                    border: OutlineInputBorder(),
                  ),
                  items: ProductUnit.values
                      .map((unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit.name),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _productUnit = value),
                  validator: (value) {
                    if (value == null) return 'Selecione uma unidade';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<ProductStatus>(
                  value: _productStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: ProductStatus.values
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status.name),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _productStatus = value),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Preço',
                    border: OutlineInputBorder(),
                  ),
                  validator: _priceValidator.validate,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                SubmitButton(
                  onPressed: _isSubmitting ? null : _submitProduct,
                  text: isEditing ? 'Atualizar' : 'Cadastrar',
                  isLoading: _isSubmitting,
                  loadingText: 'Salvando...'
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
