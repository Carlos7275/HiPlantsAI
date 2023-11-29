class PlantaModel {
  double? latitud;
  double? longitud;
  String? imagen;

  PlantaModel({
    this.latitud,
    this.longitud,
    this.imagen,
  });

  PlantaModel.fromJson(Map<String, dynamic> json) {
    latitud = json['latitud'];
    longitud = json['longitud'];
    imagen = json['imagen'];
  }

  Map<String, dynamic> toJson(String? json){
    final Map<String, dynamic> data = <String, dynamic>{};

    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['imagen'] = imagen;
    return data;
  }
}
