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
        ? InfoPlantas.fromJson(json['info_plantas'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_planta'] = idPlanta;
    data['zona'] = zona;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['url_imagen'] = urlImagen;
    data['estatus'] = estatus;
    data['created_at'] = createdAt;
    if (infoPlantas != null) {
      data['info_plantas'] = infoPlantas!.toJson();
    }
    return data;
  }
}

class InfoPlantas {
  int? id;
  String? nombrePlanta;
  String? nombreCientifico;
  String? urlImagen;
  String? toxicidad;
  bool? comestible;
  bool? vegetable;
  int? aO;
  String? familia;
  NombresComunes? nombresComunes;

  List<String>? colores;
  String? humedadAtmosferica;
  String? cantidadLuz;
  List<String>? mesesCrecimiento;
  String? genero;
  String? estatus;
  String? createdAt;

  InfoPlantas(
      {this.id,
      this.nombrePlanta,
      this.nombreCientifico,
      this.urlImagen,
      this.toxicidad,
      this.comestible,
      this.vegetable,
      this.aO,
      this.familia,
      this.colores,
      this.humedadAtmosferica,
      this.cantidadLuz,
      this.mesesCrecimiento,
      this.nombresComunes,
      this.genero,
      this.estatus,
      this.createdAt});

  InfoPlantas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombrePlanta = json['nombre_planta'];
    nombreCientifico = json['nombre_cientifico'];
    urlImagen = json['url_imagen'];
    toxicidad = json['toxicidad'];
    comestible = json['comestible'];
    vegetable = json['vegetable'];
    aO = json['año'];
    if (json["colores"] != null) {
      colores = json['colores'].cast<String>();
    }
    if (json["meses_crecimiento"] != null) {
      mesesCrecimiento = json['meses_crecimiento'].cast<String>();
    }
    if (json["nombres_comunes"] != null) {
      nombresComunes = NombresComunes.fromJson(json["nombres_comunes"]);
    }

    familia = json['familia'];
    humedadAtmosferica = json['humedad_atmosferica'];
    cantidadLuz = json['cantidad_luz'];
    genero = json['genero'];
    estatus = json['estatus'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre_planta'] = nombrePlanta;
    data['nombre_cientifico'] = nombreCientifico;
    data['url_imagen'] = urlImagen;
    data['toxicidad'] = toxicidad;
    data['comestible'] = comestible;
    data['vegetable'] = vegetable;
    data['año'] = aO;
    data['familia'] = familia;
    data['colores'] = colores;
    data['humedad_atmosferica'] = humedadAtmosferica;
    data['cantidad_luz'] = cantidadLuz;
    data['meses_crecimiento'] = mesesCrecimiento;
    data['genero'] = genero;
    data['estatus'] = estatus;
    data['created_at'] = createdAt;
    data['nombres_comunes'] = nombresComunes;
    return data;
  }
}

class NombresComunes {
  List<String>? spa;

  NombresComunes({this.spa});

  NombresComunes.fromJson(Map<String, dynamic> json) {
    spa = (json['spa'] != null) ? json['spa'].cast<String>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['spa'] = spa;
    return data;
  }
}

class Distribucion {
  List<Native>? native;

  Distribucion({this.native});

  Distribucion.fromJson(Map<String, dynamic> json) {
    if (json['native'] != null) {
      native = <Native>[];
      json['native'].forEach((v) {
        native!.add(Native.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (native != null) {
      data['native'] = native!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Native {
  int? id;
  String? name;
  String? slug;
  String? tdwgCode;
  int? tdwgLevel;
  int? speciesCount;
  Links? links;

  Native(
      {this.id,
      this.name,
      this.slug,
      this.tdwgCode,
      this.tdwgLevel,
      this.speciesCount,
      this.links});

  Native.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    tdwgCode = json['tdwg_code'];
    tdwgLevel = json['tdwg_level'];
    speciesCount = json['species_count'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['tdwg_code'] = tdwgCode;
    data['tdwg_level'] = tdwgLevel;
    data['species_count'] = speciesCount;
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }
}

class Links {
  String? self;
  String? plants;
  String? species;

  Links({this.self, this.plants, this.species});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    plants = json['plants'];
    species = json['species'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['self'] = self;
    data['plants'] = plants;
    data['species'] = species;
    return data;
  }
}
