class Comandos {
  int? id;
  String? comando;
  String? descripcion;

  Comandos({this.id, this.comando, this.descripcion});

  Comandos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comando = json['comando'];
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comando'] = comando;
    data['descripcion'] = descripcion;
    return data;
  }
}
