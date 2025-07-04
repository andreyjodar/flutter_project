import 'package:flutter/material.dart';
import 'package:flutter_project/core/settings/routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showAuthActions;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.showAuthActions
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 30)),
      backgroundColor: Colors.green,
      actions: showAuthActions ? [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.login, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                }
              ), 
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.userForm);
                }
              ),
            ]
          )
        ), 
      ] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}