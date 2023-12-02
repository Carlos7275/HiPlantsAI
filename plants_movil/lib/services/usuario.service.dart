import 'dart:convert';
import 'package:plants_movil/generics/persistence/service.dart';
import 'package:plants_movil/models/Distancias.model.dart';
import 'package:plants_movil/models/Requests/Contra.model.dart';
import 'package:plants_movil/models/Requests/RegistrarUsuario.model.dart';
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

  Future<Map<String, dynamic>> actualizarUsuario(
      int id, Usuario usuario) async {
    final parameters = jsonEncode({
      "email": usuario.email,
      "nombres": usuario.nombres,
      "apellido_paterno": usuario.apellidoPaterno,
      "apellido_materno": usuario.apellidoMaterno,
      "domicilio": usuario.domicilio,
      "fecha_nacimiento": usuario.fechaNacimiento,
      "id_rol": usuario.idRol,
      "id_genero": usuario.idGenero,
      "id_asenta": usuario.idAsentaCpcons,
      "cp": usuario.cp,
      "imagen": usuario.urlImagen
    });

    http.Response resp =
        await httpClient.put(url: 'Modificar/Usuario/$id', body: parameters);

    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw resp;
    }
  }

  Future<Map<String, dynamic>> registrarUsuario(
      RegistrarUsuarioModel usuario) async {
    final parameters = jsonEncode({
      "email": usuario.email,
      "password": usuario.password,
      "nombres": usuario.nombres,
      "apellido_paterno": usuario.apellidoPaterno,
      "apellido_materno": usuario.apellidoMaterno,
      "domicilio": usuario.domicilio,
      "fecha_nacimiento": usuario.fechaNacimiento,
      "id_rol": 2,
      "id_genero": usuario.idGenero,
      "id_asenta": usuario.idAsentaCpcons,
      "cp": usuario.cp,
    });

    http.Response resp =
        await httpClient.post(url: 'Registrar/Usuario/', body: parameters);

    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw resp;
    }
  }

  Future<Map<String, dynamic>> cambiarContra(ContrasModel contras) async {
    final parameters = jsonEncode({
      "PasswordActual": contras.passwordActual,
      "PasswordNueva": contras.passwordNueva,
      "PasswordAuxiliar": contras.passwordAuxiliar,
    });

    http.Response resp =
        await httpClient.put(url: 'Cambiar/Contraseña/', body: parameters);

    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw resp;
    }
  }

  Future<Distancias> obtenerDistancias() async {
    http.Response resp = await httpClient.get(url: 'Distancias');

    if (resp.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(resp.body)["data"];
      return Distancias.fromJson(jsonResponse);
    } else {
      throw resp;
    }
  }
}
