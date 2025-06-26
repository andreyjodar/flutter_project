import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  // Alterado para VoidCallback? para permitir que o botão seja desativado
  // (passando null quando o formulário estiver em estado de carregamento).
  final VoidCallback? onPressed;
  final String text;
  // Novo parâmetro para indicar se o botão está em estado de carregamento.
  // Permite que o próprio botão gerencie o estado de disabled/loading text.
  final bool isLoading;
  // Novo parâmetro opcional para o texto exibido durante o carregamento.
  final String? loadingText;
  // Parâmetros opcionais para customizar as cores do botão.
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? minimumSize;

  const SubmitButton({
    super.key, // Use super.key em vez de Key? key para convenções modernas
    required this.onPressed,
    required this.text,
    this.isLoading = false, // Padrão é false (não está carregando)
    this.loadingText, // Não é obrigatório
    this.backgroundColor,
    this.foregroundColor,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    // Determine o texto a ser exibido baseado no estado de carregamento
    final displayText = isLoading
        ? (loadingText ?? 'Carregando...') // Usa loadingText se fornecido, senão 'Carregando...'
        : text;

    return ElevatedButton(
      // Se estiver carregando, onPressed é null (desabilita o botão).
      // Caso contrário, usa o onPressed fornecido.
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        // Use minimumSize para preencher a largura se o pai permitir (ex: Column, Row com Expanded)
        minimumSize: minimumSize ?? const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // Cores padrão ou personalizadas
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
              // O estilo do texto já está na propriedade foregroundColor do ElevatedButton.
              // Remover style: const TextStyle(color: Colors.white) aqui para evitar conflito
            ),
    );
  }
}