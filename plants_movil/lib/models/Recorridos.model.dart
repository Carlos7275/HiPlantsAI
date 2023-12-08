class Recorridos {
  int id;
  String tiempo;
  int idPlanta;
  String zona;
  double latitud;
  double longitud;
  String urlImagen;
  String nombrePlanta;
  String nombreCientifico;
  String toxicidad;
  int anio;
  String familia;

  Recorridos({
    required this.id,
    required this.tiempo,
    required this.idPlanta,
    required this.zona,
    required this.latitud,
    required this.longitud,
    required this.urlImagen,
    required this.nombrePlanta,
    required this.nombreCientifico,
    required this.toxicidad,
    required this.anio,
    required this.familia,

    // Add more constructor parameters as needed
  });

  factory Recorridos.fromJson(Map<String, dynamic> json) {
    return Recorridos(
      id: json['id'],
      tiempo: json['tiempo'],
      idPlanta: json['id_planta'],
      zona: json['zona'],
      latitud: json['latitud'].toDouble(),
      longitud: json['longitud'].toDouble(),
      urlImagen: json['url_imagen'],
      nombrePlanta: json['nombre_planta'],
      nombreCientifico: json['nombre_cientifico'],
      toxicidad: json['toxicidad'],
      anio: json['año'],
      familia: json['familia'],
    );
  }
}
