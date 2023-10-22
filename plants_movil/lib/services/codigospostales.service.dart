import 'dart:convert';

import 'package:plants_movil/generics/persistence/service.dart';
import 'package:plants_movil/models/CodigosPostales.model.dart';
import 'package:plants_movil/models/Generos.model.dart';
import 'package:http/http.dart' as http;

class CodigosPostalesService extends Service<CodigosPostales> {
  CodigosPostalesService() : super('');

  @override
  CodigosPostales instanceFromMap(Map<String, dynamic> jsonMap) =>
      CodigosPostales.fromJson(jsonMap);

  Future<List<CodigosPostales>> obtenerAsentamientos(String cp) async {
    http.Response resp = await httpClient.get(url: 'CodigoPostal/$cp');

    if (resp.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(resp.body)["data"];
      return jsonResponse
          .map((asentamientos) => CodigosPostales.fromJson(asentamientos))
          .toList();
    } else {
      throw resp;
    }
  }
}
