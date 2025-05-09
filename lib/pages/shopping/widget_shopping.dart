import 'package:flutter/material.dart';
import 'package:flutter_project/components/bottom_menu.dart';

class WidgetShopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 1)
    );
  }
}
