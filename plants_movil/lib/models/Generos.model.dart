class Generos {
  int? idGenero;
  String? descripcion;

  Generos({this.idGenero, this.descripcion});

  Generos.fromJson(Map<String, dynamic> json) {
    idGenero = json['id_genero'];
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_genero'] = idGenero;
    data['descripcion'] = descripcion;
    return data;
  }
}