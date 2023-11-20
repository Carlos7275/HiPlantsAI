class Mapa {
  int? id;
  int? idPlanta;
  String? zona;
  double? latitud;
  double? longitud;
  String? urlImagen;
  int? estatus;
  String? createdAt;
  InfoPlantas? infoPlantas;

  Mapa(
      {this.id,
      this.idPlanta,
      this.zona,
      this.latitud,
      this.longitud,
      this.urlImagen,
      this.estatus,
      this.createdAt,
      this.infoPlantas});

  Mapa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPlanta = json['id_planta'];
    zona = json['zona'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    urlImagen = json['url_imagen'];
    estatus = json['estatus'];
    createdAt = json['created_at'];
    infoPlantas = json['info_plantas'] != null
        ? new InfoPlantas.fromJson(json['info_plantas'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_planta'] = this.idPlanta;
    data['zona'] = this.zona;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['url_imagen'] = this.urlImagen;
    data['estatus'] = this.estatus;
    data['created_at'] = this.createdAt;
    if (this.infoPlantas != null) {
      data['info_plantas'] = this.infoPlantas!.toJson();
    }
    return data;
  }
}

class InfoPlantas {
  int? id;
  String? nombrePlanta;
  String? nombreCientifico;
  String? toxicidad;
  int? aO;
  String? familia;

  Null? colores;
  String? humedadAtmosferica;
  String? cantidadLuz;
  Null? mesesCrecimiento;
  String? genero;
  String? estatus;
  String? createdAt;

  InfoPlantas(
      {this.id,
      this.nombrePlanta,
      this.nombreCientifico,
      this.toxicidad,
      this.aO,
      this.familia,
      this.colores,
      this.humedadAtmosferica,
      this.cantidadLuz,
      this.mesesCrecimiento,
      this.genero,
      this.estatus,
      this.createdAt});

  InfoPlantas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombrePlanta = json['nombre_planta'];
    nombreCientifico = json['nombre_cientifico'];
    toxicidad = json['toxicidad'];
    aO = json['año'];
    familia = json['familia'];

    colores = json['colores'];
    humedadAtmosferica = json['humedad_atmosferica'];
    cantidadLuz = json['cantidad_luz'];
    mesesCrecimiento = json['meses_crecimiento'];
    genero = json['genero'];
    estatus = json['estatus'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre_planta'] = this.nombrePlanta;
    data['nombre_cientifico'] = this.nombreCientifico;
    data['toxicidad'] = this.toxicidad;
    data['año'] = this.aO;
    data['familia'] = this.familia;

    data['humedad_atmosferica'] = this.humedadAtmosferica;
    data['cantidad_luz'] = this.cantidadLuz;
    data['genero'] = this.genero;
    data['estatus'] = this.estatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
