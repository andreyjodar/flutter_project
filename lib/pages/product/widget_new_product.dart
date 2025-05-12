import 'package:flutter/material.dart';
import 'package:flutter_project/components/form/new_product_form.dart';

class WidgetNewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 100, color: Colors.green),
                const SizedBox(height: 24),
                NewProductForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
