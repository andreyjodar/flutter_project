import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/presentation/components/appbar.dart';
import 'package:flutter_project/domain/usecases/delete_user_usecase.dart';
import 'package:flutter_project/domain/usecases/update_user_usecase.dart';
import 'package:flutter_project/external/datasources/firebase/firebase_user_dao.dart';
import 'package:flutter_project/infrastructure/repositories/user_repository_impl.dart';
import 'package:flutter_project/presentation/pages/home/profile_page.dart';
import 'package:flutter_project/presentation/pages/home/home_page.dart';
import 'package:flutter_project/presentation/pages/purchase/purchase_log_page.dart';
import 'package:flutter_project/presentation/pages/home/shopping_page.dart';

class MenuPages extends StatefulWidget {
  @override
  State<MenuPages> createState() => _MenuPagesState();
}

class _MenuPagesState extends State<MenuPages> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ShoppingPage(),
    PurchaseLogPage(),
    ProfilePage(updateUserUseCase: UpdateUserUseCase(UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))),deleteUserUseCase: DeleteUserUseCase(UserRepositoryImpl(FirebaseUserDao(FirebaseFirestore.instance))),)
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
