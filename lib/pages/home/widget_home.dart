import 'package:flutter/material.dart';
import 'package:flutter_project/settings/routes.dart';
import 'package:flutter_project/components/bottom_menu.dart';

class WidgetHome extends StatelessWidget {
  const WidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    Widget createSubmenu(
        {required IconData icon, required String name, required String route}) {
      return ListTile(
          leading: Icon(icon, color: Colors.green),
          title:
              Text(name, style: TextStyle(color: Colors.green, fontSize: 20)),
          onTap: () => Navigator.pushNamed(context, route));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('IF Xplore',
              style: TextStyle(color: Colors.white, fontSize: 30)),
          backgroundColor: Colors.green,
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0)
      );
  }
}
