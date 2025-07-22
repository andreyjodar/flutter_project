import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/components/appbar.dart';
import 'package:flutter_project/presentation/components/submit_button.dart';
import 'package:flutter_project/presentation/stores/cart_notifier.dart';
import 'package:provider/provider.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final notifier = context.read<CartNotifier>();

    await notifier.loadCart();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, _) {
        if (_loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final cart = cartNotifier.cart!;
        return Scaffold(
          appBar: CustomAppBar(title: 'Meu Carrinho', showAuthActions: false),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cart.cartItems[index];
                  return Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black12, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: const Icon(Icons.sell_outlined),
                        title: Text(item.product.name),
                        subtitle: Text('Qtd: ${item.quantity} | Preço: R\$ ${item.calculatePrice().toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(context, cartNotifier, item);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  cartNotifier.removeItem(item.id);
                                },
                              ),
                            ],
                          ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              )
            )
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12, width: 2),
                    color: Colors.white, // opcional para dar contraste
                  ),
                  child: Center(
                    child: Text(
                      'Total: R\$ ${cartNotifier.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SubmitButton(
                  onPressed: () {},
                  text: 'Finalizar Compra',
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _showEditDialog(BuildContext context, CartNotifier notifier, dynamic item) {
    final controller = TextEditingController(text: item.quantity.toString());
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(
          child: Text('Alterar Quantidade'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.product.name, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = int.tryParse(controller.text);
              if (quantity != null && quantity > 0) {
                notifier.updateItem(item.id, quantity);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Atualizar'),
          ),
        ],
      ),
    );
  }
}
