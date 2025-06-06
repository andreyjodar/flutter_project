import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/appbar.dart';
import 'package:flutter_project/pages/auth/profile_page.dart';
import 'package:flutter_project/pages/main_page/home_page.dart';
import 'package:flutter_project/pages/purchase/purchase_page.dart';
import 'package:flutter_project/pages/shopping/shopping_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ShoppingPage(),
    PurchasePage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Frutify', showAuthActions: true),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            unselectedItemColor: Colors.black45,
            selectedItemColor: Colors.black87,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Início'),
              BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Lojas'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long), label: 'Compras'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil')
            ]));
  }
}
