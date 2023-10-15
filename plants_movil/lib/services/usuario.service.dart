import 'dart:convert';

import 'package:plants_movil/generics/persistence/service.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:http/http.dart' as http;

class UsuarioService extends Service<Usuario> {
  UsuarioService() : super('');

  @override
  Usuario instanceFromMap(Map<String, dynamic> jsonMap) =>
      Usuario.fromJson(jsonMap);

  Future<Map<String, dynamic>> login(String correo, String password) async {
    final parameters = jsonEncode({"email": correo, "password": password});
    http.Response resp = await httpClient.post(
      url: 'auth/login',
      body: parameters,
    );

    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw resp;
    }
  }
}
