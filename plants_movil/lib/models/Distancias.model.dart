class Distancias {
  int? distanciamin;
  int? distanciamax;

  Distancias({this.distanciamin, this.distanciamax});

  Distancias.fromJson(Map<String, dynamic> json) {
    distanciamin = json['distanciamin'];
    distanciamax = json['distanciamax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distanciamin'] = distanciamin;
    data['distanciamax'] = distanciamax;
    return data;
  }
}