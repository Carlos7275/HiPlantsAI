import 'package:plants_movil/generics/persistence/model.dart';

class Usuario extends BaseModel{
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
  String? referencia;
  int? idAsentaCpcons;
  String? cp;
  String? telefono;
  String? fechaNacimiento;

  
  Usuario(
      {
      this.email,
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
      this.referencia,
      this.idAsentaCpcons,
      this.cp,
      this.telefono,
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
    referencia = json['referencia'];
    idAsentaCpcons = json['id_asenta_cpcons'];
    cp = json['cp'];
    telefono = json['telefono'];
    fechaNacimiento = json['fecha_nacimiento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['url_imagen'] = this.urlImagen;
    data['id_rol'] = this.idRol;
    data['id_genero'] = this.idGenero;
    data['estatus'] = this.estatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nombres'] = this.nombres;
    data['apellido_paterno'] = this.apellidoPaterno;
    data['apellido_materno'] = this.apellidoMaterno;
    data['domicilio'] = this.domicilio;
    data['referencia'] = this.referencia;
    data['id_asenta_cpcons'] = this.idAsentaCpcons;
    data['cp'] = this.cp;
    data['telefono'] = this.telefono;
    data['fecha_nacimiento'] = this.fechaNacimiento;
    return data;
  }
}