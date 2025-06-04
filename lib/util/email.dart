class EmailValidator {
  const EmailValidator();
  
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email nulo ou vazio';
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if(!emailRegex.hasMatch(value)) {
      return 'Formato inválido';
    }
    return null;
  }
}