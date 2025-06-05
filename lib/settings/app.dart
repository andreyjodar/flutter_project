import 'package:flutter/material.dart';
import 'package:flutter_project/data/repository/user_repository.dart';
import 'package:flutter_project/pages/auth/register_page.dart';
import 'package:flutter_project/pages/main_page/main_page.dart';
import 'package:flutter_project/pages/product/widget_product.dart';
import 'package:flutter_project/pages/purchase/widget_new_purchase.dart';
import 'package:flutter_project/pages/shopping/widget_company.dart';
import 'package:flutter_project/pages/shopping/widget_new_company.dart';
import 'package:flutter_project/settings/routes.dart';
import 'package:flutter_project/pages/auth/login_page.dart';
import 'package:flutter_project/pages/product/widget_new_product.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository();

    return MaterialApp(
        initialRoute: Routes.mainPage,
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.mainPage: (context) => MainPage(),
          Routes.login: (context) => LoginPage(userRepository: userRepository),
          Routes.register: (context) => RegisterPage(userRepository: userRepository),
          Routes.company: (context) => WidgetCompany(),
          Routes.newCompany: (context) => WidgetNewCompany(),
          Routes.product: (context) => WidgetProduct(),
          Routes.newProduct: (context) => WidgetNewProduct(),
          Routes.newPurchase: (context) => WidgetNewPurchase(),
        });
  }
}
