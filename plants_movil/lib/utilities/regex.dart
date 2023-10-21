class Utilities {
  static final RegExp email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static String? emailValidator(String? text) {
    if (text != null && email.hasMatch(text)) {
      return null;
    } else {
      return 'Ingresa un email valido';
    }
  }

  static String? passwordValidator(String? text) {
    if (text != null && text.length >= 3) {
      return null;
    } else {
      return 'Contraseña minima de 3 caracteres';
    }
  }
}
