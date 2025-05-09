import 'package:flutter/material.dart';
import 'package:flutter_project/pages/auth/widget_register.dart';
import 'package:flutter_project/pages/product/widget_buy_product.dart';
import 'package:flutter_project/pages/product/widget_product.dart';
import 'package:flutter_project/pages/purchase/widget_purchase.dart';
import 'package:flutter_project/pages/purchase/widget_purchase_log.dart';
import 'package:flutter_project/pages/shopping/widget_seller.dart';
import 'package:flutter_project/settings/routes.dart';
import 'package:flutter_project/pages/auth/widget_login.dart';
import 'package:flutter_project/pages/home/widget_home.dart';
import 'package:flutter_project/pages/auth/widget_profile.dart';
import 'package:flutter_project/pages/shopping/widget_shopping.dart';
import 'package:flutter_project/pages/product/widget_new_product.dart';

class App extends StatelessWidget {
  const App({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: Routes.home,
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.home: (context) => WidgetHome(),
          Routes.login: (context) => WidgetLogin(),
          Routes.register: (context) => WidgetRegister(),
          Routes.profile: (context) => WidgetProfile(),
          Routes.shopping: (context) => WidgetShopping(),
          Routes.seller: (context) => WidgetSeller(),
          Routes.product: (context) => WidgetProduct(),
          Routes.newProduct: (context) => WidgetNewProduct(),
          Routes.buyProduct: (context) => WidgetBuyProduct(),
          Routes.purchaseLog: (context) => WidgetPurchaseLog(),
          Routes.purchase: (context) => WidgetPurchase()
        });
  }
}
