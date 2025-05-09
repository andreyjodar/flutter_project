import 'package:flutter/material.dart';
import 'package:flutter_app_1/settings/routes.dart';

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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Text('Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              createSubmenu(
                  icon: Icons.home_rounded, name: 'Home', route: Routes.home),
              createSubmenu(
                  icon: Icons.article_outlined,
                  name: 'Search',
                  route: Routes.search),
              createSubmenu(
                  icon: Icons.help_outline, name: 'About', route: Routes.about),
              createSubmenu(
                  icon: Icons.person, name: 'Profile', route: Routes.profile)
            ],
          ),
        ),
        body: ListView.builder(
            itemBuilder: (context, count) => Container(
                  child: Column(
                    children: [Card()],
                  ),
                )));
  }
}
