import 'package:flutter/material.dart';
import 'package:flutter_project/settings/routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if(index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, Routes.shopping);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, Routes.purchaseLog);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, Routes.profile);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      unselectedItemColor: Colors.black45,
      selectedItemColor: Colors.black87,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Início'),
        BottomNavigationBarItem(
          icon: Icon(Icons.store), 
          label: 'Lojas'),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long), 
          label: 'Compras'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person), 
          label: 'Perfil')
      ]
    );
  }
}
