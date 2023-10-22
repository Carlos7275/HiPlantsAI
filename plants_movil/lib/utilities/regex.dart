class Utilities {
  static final RegExp email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp names =
      RegExp(r"^[a-zA-ZÀ-ÖØ-öø-ÿ]+(?:['\-][a-zA-ZÀ-ÖØ-öø-ÿ]+)?$");

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

  static String? nameValidator(String? text) {
    if (text != null && names.hasMatch(text)) {
      return null;
    } else {
      return "Ingrese el Nombre de la Persona";
    }
  }

  static String? apellidoValitador(String? text) {
    if (text == null) {
      return null;
    } else {
      if (!names.hasMatch(text)) return "Ingrese un Apellido válido";
      return null;
    }
  }

  static String? domicilioValidator(String? text) {
    if (text != null) {
      return null;
    } else {
      return "Ingrese el Domicilio";
    }
  }
}
