class Recorridos {
  int id;
  int idMapa;
  int idUsuario;
  int tiempo;
  DateTime createdAt;
  int idPlanta;
  String zona;
  double latitud;
  double longitud;
  String urlImagen;
  String estatus;
  String nombrePlanta;
  String nombreCientifico;
  String toxicidad;
  int comestible;
  int vegetable;
  int anio;
  String familia;


  Recorridos({
    required this.id,
    required this.idMapa,
    required this.idUsuario,
    required this.tiempo,
    required this.createdAt,
    required this.idPlanta,
    required this.zona,
    required this.latitud,
    required this.longitud,
    required this.urlImagen,
    required this.estatus,
    required this.nombrePlanta,
    required this.nombreCientifico,
    required this.toxicidad,
    required this.comestible,
    required this.vegetable,
    required this.anio,
    required this.familia,

    // Add more constructor parameters as needed
  });

  factory Recorridos.fromJson(Map<String, dynamic> json) {
    return Recorridos(
      id: json['id'],
      idMapa: json['id_mapa'],
      idUsuario: json['id_usuario'],
      tiempo: json['tiempo'],
      createdAt: DateTime.parse(json['created_at']),
      idPlanta: json['id_planta'],
      zona: json['zona'],
      latitud: json['latitud'].toDouble(),
      longitud: json['longitud'].toDouble(),
      urlImagen: json['url_imagen'],
      estatus: json['estatus'],
      nombrePlanta: json['nombre_planta'],
      nombreCientifico: json['nombre_cientifico'],
      toxicidad: json['toxicidad'],
      comestible: json['comestible'],
      vegetable: json['vegetable'],
      anio: json['año'],
      familia: json['familia'],
    );
  }
}
