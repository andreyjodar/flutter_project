import 'package:flutter/material.dart';
import 'package:flutter_project/components/bottom_menu.dart';

class WidgetProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 3)
    );
  }
}
