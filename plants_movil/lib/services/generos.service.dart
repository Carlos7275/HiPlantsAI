import 'dart:convert';

import 'package:plants_movil/generics/persistence/service.dart';
import 'package:plants_movil/models/Generos.model.dart';
import 'package:http/http.dart' as http;

class GenerosService extends Service<Generos> {
  GenerosService() : super('');

  @override
  Generos instanceFromMap(Map<String, dynamic> jsonMap) =>
      Generos.fromJson(jsonMap);

  Future<List<Generos>> obtenerGeneros() async {
    http.Response resp = await httpClient.get(url: 'Generos');

    if (resp.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(resp.body)["data"];
      return jsonResponse.map((genero) => Generos.fromJson(genero)).toList();
    } else {
      throw resp;
    }
  }
}
