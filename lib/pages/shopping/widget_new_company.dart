import 'package:flutter/material.dart';
import 'package:flutter_project/components/form/new_company_form.dart';

class WidgetNewCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      // appBar: ,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Você pode colocar uma logo aqui, por exemplo:
                const Icon(Icons.lock_outline, size: 100, color: Colors.green),
                const SizedBox(height: 24),
                // Aqui entra seu widget personalizado de formulário:
                NewCompanyForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}