import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      onPressed: onPressed,
      child: const Icon(Icons.shopping_cart, color: Colors.white),
    );
  }
}
