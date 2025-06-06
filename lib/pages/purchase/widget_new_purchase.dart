import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/appbar.dart';
import 'package:flutter_project/components/form/new_purchase_form.dart';

class WidgetNewPurchase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Nova Compra', showAuthActions: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_basket_rounded,
                    size: 100, color: Colors.green),
                const SizedBox(height: 24),
                NewPurchaseForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
