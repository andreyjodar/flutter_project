import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final String? label;

  const FloatingButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultBackgroundColor = backgroundColor ?? Colors.green;

    if (label != null && label!.isNotEmpty) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        backgroundColor: defaultBackgroundColor,
        icon: Icon(icon, color: Colors.white),
        label: Text(label!, style: const TextStyle(color: Colors.white)),
      );
    } else {
      return FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: defaultBackgroundColor,
        child: Icon(icon, color: Colors.white),
      );
    }
  }
}