import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final String? loadingText;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? minimumSize;

  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.loadingText,
    this.backgroundColor,
    this.foregroundColor,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = isLoading ? (loadingText ?? 'Carregando...') : text;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: minimumSize ?? const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: backgroundColor ?? Colors.green,
        foregroundColor: foregroundColor ?? Colors.white,
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            )
          : Text(
              displayText,
            ),
    );
  }
}
