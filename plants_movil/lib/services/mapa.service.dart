import 'dart:convert';
import 'package:plants_movil/generics/persistence/service.dart';
import 'package:plants_movil/models/Mapa.model.dart';
import 'package:http/http.dart' as http;

class MapaService extends Service<Mapa> {
  @override
  Mapa instanceFromMap(Map<String, dynamic> jsonMap) => Mapa.fromJson(jsonMap);

  Future<List<Mapa>> obtenerPlantasActivas() async {
    http.Response resp = await httpClient.get(url: 'Mapa/Plantas/Activas');

    if (resp.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(resp.body)["data"];
      return jsonResponse.map((mapa) => Mapa.fromJson(mapa)).toList();
    } else {
      throw resp;
    }
  }

  Future<Map<String, dynamic>> cambiarEstatus(int id) async {
    http.Response resp =
        await httpClient.get(url: 'Cambiar/Estatus/Planta/$id');
    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw resp;
    }
  }
}
