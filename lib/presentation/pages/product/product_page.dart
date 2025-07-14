import 'package:flutter/material.dart';
import 'package:flutter_project/core/settings/routes.dart';
import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/usecases/delete_product_usecase.dart';
import 'package:flutter_project/presentation/components/appbar.dart';
import 'package:flutter_project/presentation/components/info_card.dart';
import 'package:flutter_project/presentation/components/submit_button.dart';
import 'package:flutter_project/presentation/pages/product/product_form_args.dart';
import 'package:flutter_project/presentation/stores/logged_user_store.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final DeleteProductUseCase deleteProductUseCase;
  final Product initialProduct;

  const ProductPage({
    super.key,
    required this.deleteProductUseCase,
    required this.initialProduct
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Product product;
  bool _isProducer = false;

  @override
  void initState() {
    super.initState();
    product = widget.initialProduct;

    final user = Provider.of<LoggedUserStore>(context, listen: false).user;
    if (user != null && user.type == UserType.producer) {
      _isProducer = true;
    }
  }

  void _deleteProduct(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir este produto?'),
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
      await widget.deleteProductUseCase(product.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto excluído com sucesso.')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir produto: $e')),
      );
    }
  }

  void _editProduct(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.productForm,
      arguments: ProductFormArgs(
        company: product.company, 
        product: product
      ),
    ).then((result) {
      if (result != null && result is Product) {
        setState(() {
          product = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name, showAuthActions: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
                      const Icon(Icons.sell_outlined, size: 48),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          product.name,
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
                  icon: Icons.store, 
                  label: 'Empresa', 
                  value: product.company.name
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.grass_rounded, 
                  label: 'Tipo de Produto', 
                  value: product.isFruit() ? 'Fruta'
                    : product.isGrain() ? 'Grão' 
                    : product.isTuber() ? 'Tubéculo'
                    : product.isVegetable() ? 'Vegetal'
                    : 'Não Identificado'
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.scale_outlined, 
                  label: 'Unidade de Venda', 
                  value: product.isKilogram() ? 'Kilograma (KG)' 
                    : product.isMililliters() ? 'Mililitros (ML)'
                    : product.isUnit() ? 'Unidade (UN)'
                    : product.isPack() ? 'Bandeja (BDJ)' 
                    : 'Não Identificado'
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.attach_money_outlined, 
                  label: 'Preço Unitário', 
                  value: '${product.price}'
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.description,
                  label: 'Descrição',
                  value: product.description ?? 'Sem descrição',
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.question_mark_rounded, 
                  label: 'Status', 
                  value: product.isAvailable() ? 'Disponível' : 'Indisponível'
                ),
                const SizedBox(height: 8),
                InfoCard(
                  icon: Icons.date_range, 
                  label: 'Data de Cadastro', 
                  value: product.registerDate.toIso8601String()
                ),
                if (_isProducer) ...[
                  const SizedBox(height: 24),
                  SubmitButton(
                    onPressed: () => _editProduct(context),
                    text: 'Editar Produto',
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.deepPurple,
                  ),
                  const SizedBox(height: 12),
                  SubmitButton(
                    onPressed: () => _deleteProduct(context),
                    text: 'Excluir Produto',
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ]
              ],
            ),
          ),
        )
      ),
    );
  }

}