import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plants_movil/generics/persistence/service.dart';
import 'package:plants_movil/models/Comandos.model.dart';

class ComandosService extends Service<Comandos> {
  ComandosService() : super('');

  @override
  Comandos instanceFromMap(Map<String, dynamic> jsonMap) =>
      Comandos.fromJson(jsonMap);

  Future<List<Comandos>> obtenerComandos() async {
    http.Response resp = await httpClient.get(url: 'Comandos');

    if (resp.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(resp.body)["data"];
      return jsonResponse
          .map((comandos) => Comandos.fromJson(comandos))
          .toList();
    } else {
      throw resp;
    }
  }

  Future<String> plantaMasVisitada() async {
    http.Response resp = await httpClient.get(url: 'Plantas/MasVisitadas/1');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }
}
