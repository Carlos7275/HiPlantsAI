class Utilities {
  static final RegExp email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp names = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$');
  static final RegExp codigopostal = RegExp(r'^\d{5}$');

  static String? emailValidator(String? text) {
    if (text != null && email.hasMatch(text)) {
      return null;
    } else {
      return 'Ingresa un email valido';
    }
  }

  static String? passwordValidator(String? text) {
    if (text != null && text.length >= 5) {
      return null;
    } else {
      return 'Contraseña minima de 5 caracteres';
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

  static String? fechaNacimientoValidator(String? text) {
    if (text == null) {
      return "Ingrese su Fecha de nacimiento";
    } else {
      DateTime fechaNacimiento = DateTime.parse(text);

      if (DateTime.now().year - fechaNacimiento.year >= 10) {
        return null;
      } else {
        return "Para registrarse necesita ser de 9 años de edad";
      }
    }
  }

  static String? generosValidator(value) {
    if (value == null) return "Ingrese el Genero";
    return null;
  }

  static String? asentamientoValidator(value) {
    if (value == null) return "Ingrese la Colonia";
    return null;
  }

  static String? codigopostalValidator(String? text) {
    if (text != null && codigopostal.hasMatch(text)) {
      return null;
    }
    return 'Ingrese un codigo postal valido';
  }
}
