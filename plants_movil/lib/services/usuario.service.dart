import 'dart:convert';

import 'package:plants_movil/generics/persistence/service.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioService extends Service<Usuario> {
  UsuarioService() : super('');

  @override
  Usuario instanceFromMap(Map<String, dynamic> jsonMap) =>
      Usuario.fromJson(jsonMap);

  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    return (token != null);
  }

  Future<Usuario> obtenerInfoUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = (prefs.getString("info_usuario")!);

    Map<String, dynamic> usuario = jsonDecode(json);
    var user = Usuario.fromJson(usuario);
    return user;
  }

  Future<Map<String, dynamic>> login(String correo, String password) async {
    final parameters = jsonEncode({"email": correo, "password": password});
    http.Response resp = await httpClient.post(
      url: 'auth/login',
      body: parameters,
    );

    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    } else {
      throw resp;
    }
  }

  Future<Map<String, dynamic>> me() async {
    http.Response resp = await httpClient.get(url: 'auth/me');

    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw resp;
    }
  }
}
