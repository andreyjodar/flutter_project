import 'package:flutter/material.dart';
import 'package:flutter_project/data/repositories_impl/user_repository.dart';
import 'package:flutter_project/presentation/company/company_form.dart';
import 'package:flutter_project/presentation/pages/auth/login_form.dart';
import 'package:flutter_project/presentation/pages/auth/user_form.dart';
import 'package:flutter_project/presentation/pages/home/menu_pages.dart';
import 'package:flutter_project/presentation/pages/product/product_form.dart';
import 'package:flutter_project/presentation/pages/product/product_page.dart';
import 'package:flutter_project/presentation/pages/purchase/purchase_form.dart';
import 'package:flutter_project/presentation/pages/company/company_page.dart';
import 'package:flutter_project/core/settings/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository();

    return MaterialApp(
      initialRoute: Routes.mainPage,
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.mainPage: (context) => MenuPages(),
        Routes.login: (context) => LoginForm(userRepository: userRepository),
        Routes.userForm: (context) => UserForm(userRepository: userRepository),
        Routes.company: (context) => CompanyPage(),
        Routes.companyForm: (context) => CompanyForm(),
        Routes.product: (context) => ProductPage(),
        Routes.productForm: (context) => ProductForm(),
        Routes.purchaseForm: (context) => PurchaseForm(),
      }
    );
  }
}
