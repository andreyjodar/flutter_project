import 'package:flutter/material.dart';
import 'package:flutter_project/core/settings/routes.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/domain/usecases/get_products_by_company_usecase.dart';
import 'package:flutter_project/presentation/components/appbar.dart';
import 'package:flutter_project/presentation/components/floating_button.dart';
import 'package:flutter_project/presentation/pages/product/product_form_args.dart';
import 'package:flutter_project/presentation/stores/logged_user_store.dart';
import 'package:provider/provider.dart';

class CompanyProductsPage extends StatefulWidget{
  final Company existingCompany;

  const CompanyProductsPage({super.key, required this.existingCompany});

  @override
  State<CompanyProductsPage> createState() => _CompanyProductsPage();
}

class _CompanyProductsPage extends State<CompanyProductsPage> {
  late final GetProductsByCompanyUseCase _getProductsByCompanyUseCase;
  List<Product> _products = [];
  bool _isLoading = true;
  bool _isProducer = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _getProductsByCompanyUseCase = Provider.of<GetProductsByCompanyUseCase>(context);
      _loadProducts();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  Future<void> _loadProducts() async {
    try {
      final user = Provider.of<LoggedUserStore>(context, listen: false).user;
      if (user == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final products = await _getProductsByCompanyUseCase(widget.existingCompany.id);

      setState(() {
        _products = products;
        _isLoading = false;
        _isProducer = user.isProducer();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao carregar produtos: $e')));
    }
  }

  void _goToCreateProduct() {
    Navigator.pushNamed(context, Routes.productForm, arguments: ProductFormArgs(company: widget.existingCompany),).then((_) => _loadProducts());
  }

  void _goToProductDetails(Product product) {
    Navigator.pushNamed(context, Routes.product, arguments: product).then((_) => _loadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Produtos', showAuthActions: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _products.isEmpty
                  ? const Center(child: Text('Empresa não possui produtos'))
                  : ListView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return Column(
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black12, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              leading: const Icon(Icons.sell_outlined),
                              title: Text(product.name),
                              subtitle: Text(product.company.name),
                              onTap: () => _goToProductDetails(product),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
        ),
      ),
      floatingActionButton: _isProducer ? FloatingButton(
        onPressed: _goToCreateProduct, 
        icon: Icons.add
      ) : null,
    );
  }
}
