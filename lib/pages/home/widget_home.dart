import 'package:flutter/material.dart';
import 'package:flutter_project/components/elements/appbar.dart';
import 'package:flutter_project/components/elements/bottom_menu.dart';

class WidgetHome extends StatelessWidget {
  const WidgetHome({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: const CustomAppBar(title: 'Frutify'),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0)
      );
  }
}
