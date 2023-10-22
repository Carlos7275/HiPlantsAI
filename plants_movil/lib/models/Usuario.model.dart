class Usuario {
  int? id;
  String? email;
  String? urlImagen;
  int? idRol;
  int? idGenero;
  String? estatus;
  String? createdAt;
  String? updatedAt;
  String? nombres;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? domicilio;
  int? idAsentaCpcons;
  String? cp;
  String? fechaNacimiento;

  Usuario(
      {this.email,
      this.urlImagen,
      this.idRol,
      this.idGenero,
      this.estatus,
      this.createdAt,
      this.updatedAt,
      this.nombres,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.domicilio,
      this.idAsentaCpcons,
      this.cp,
      this.fechaNacimiento});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    urlImagen = json['url_imagen'];
    idRol = json['id_rol'];
    idGenero = json['id_genero'];
    estatus = json['estatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nombres = json['nombres'];
    apellidoPaterno = json['apellido_paterno'];
    apellidoMaterno = json['apellido_materno'];
    domicilio = json['domicilio'];
    idAsentaCpcons = json['id_asenta_cpcons'];
    cp = json['cp'];
    fechaNacimiento = json['fecha_nacimiento'];
  }

  Map<String, dynamic> toJson(String? json) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['url_imagen'] = urlImagen;
    data['id_rol'] = idRol;
    data['id_genero'] = idGenero;
    data['estatus'] = estatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['nombres'] = nombres;
    data['apellido_paterno'] = apellidoPaterno;
    data['apellido_materno'] = apellidoMaterno;
    data['domicilio'] = domicilio;
    data['id_asenta_cpcons'] = idAsentaCpcons;
    data['cp'] = cp;
    data['fecha_nacimiento'] = fechaNacimiento;
    return data;
  }
}
