class CodigosPostales {
  int? idAsentaCpcons;
  String? dCodigo;
  String? dAsenta;
  String? dTipoAsenta;
  String? dMnpio;
  String? dEstado;
  String? dCiudad;

  CodigosPostales(
      {this.idAsentaCpcons,
      this.dCodigo,
      this.dAsenta,
      this.dTipoAsenta,
      this.dMnpio,
      this.dEstado,
      this.dCiudad});

  CodigosPostales.fromJson(Map<String, dynamic> json) {
    idAsentaCpcons = json['id_asenta_cpcons'];
    dCodigo = json['d_codigo'];
    dAsenta = json['d_asenta'];
    dTipoAsenta = json['d_tipo_asenta'];
    dMnpio = json['d_mnpio'];
    dEstado = json['d_estado'];
    dCiudad = json['d_ciudad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_asenta_cpcons'] = idAsentaCpcons;
    data['d_codigo'] = dCodigo;
    data['d_asenta'] = dAsenta;
    data['d_tipo_asenta'] = dTipoAsenta;
    data['d_mnpio'] = dMnpio;
    data['d_estado'] = dEstado;
    data['d_ciudad'] = dCiudad;
    return data;
  }
}
