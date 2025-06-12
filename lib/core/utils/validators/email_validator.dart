class EmailValidator {
  const EmailValidator();

  bool isValid(String email) {
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if(emailRegex.hasMatch(email)) {
      return true;
    }
    return false;
  }
  
  String? validate(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email nulo ou vazio';
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if(!emailRegex.hasMatch(email)) {
      return 'Formato inválido';
    }
    return null;
  }
}