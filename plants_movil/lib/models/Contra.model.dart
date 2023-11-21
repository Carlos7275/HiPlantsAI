class ContrasModel {
  String? passwordActual;
  String? passwordNueva;
  String? passwordAuxiliar;

  ContrasModel(
      {this.passwordActual,
      this.passwordNueva,
      this.passwordAuxiliar,});

  ContrasModel.fromJson(Map<String, dynamic> json) {
    passwordActual = json['PasswordActual'];
    passwordNueva = json['PasswordNueva'];
    passwordAuxiliar = json['PasswordAuxiliar'];
  }

  Map<String, dynamic> toJson(String? json) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['PasswordActual'] = passwordActual;
    data['PasswordNueva'] = passwordNueva;
    data['PasswordAuxiliar'] = passwordAuxiliar;
    return data;
  }
}
