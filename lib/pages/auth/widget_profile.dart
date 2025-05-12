import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/appbar.dart';
import 'package:flutter_project/components/elements/bottom_menu.dart';

class WidgetProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Frutify'),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3)
    );
  }
}
