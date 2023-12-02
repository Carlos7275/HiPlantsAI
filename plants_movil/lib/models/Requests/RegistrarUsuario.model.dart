class RegistrarUsuarioModel {
  String? email;
  String? password;
  int? idRol;
  int? idGenero;
  String? nombres;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? domicilio;
  int? idAsentaCpcons;
  String? cp;
  String? fechaNacimiento;
  String? referencia;

  RegistrarUsuarioModel(
      {this.email,
      this.password,
      this.nombres,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.domicilio,
      this.fechaNacimiento,
      this.idRol,
      this.idGenero,
      this.idAsentaCpcons,
      this.cp,
      this.referencia});

  RegistrarUsuarioModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    nombres = json['nombres'];
    apellidoPaterno = json['apellido_paterno'];
    apellidoMaterno = json['apellido_materno'];
    domicilio = json['domicilio'];
    fechaNacimiento = json['fecha_nacimiento'];
    idRol = json['id_rol'];
    idGenero = json['id_genero'];
    idAsentaCpcons = json['id_asenta'];
    cp = json['cp'];
    referencia = json['referencia'];
  }

  Map<String, dynamic> toJson(String? json) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['email'] = email;
    data['password'] = password;
    data['nombres'] = nombres;
    data['apellido-paterno'] = apellidoPaterno;
    data['apellido_materno'] = apellidoMaterno;
    data['domicilio'] = domicilio;
    data['fecha_nacimiento'] = fechaNacimiento;
    data['id_rol'] = idRol;
    data['id_genero'] = idGenero;
    data['id_asenta'] = idAsentaCpcons;
    data['cp'] = cp;
    data['referencia'] = referencia;
    return data;
  }
}
