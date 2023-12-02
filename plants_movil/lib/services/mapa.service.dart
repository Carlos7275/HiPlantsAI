import 'dart:convert';
import 'package:plants_movil/generics/persistence/service.dart';
import 'package:plants_movil/models/Mapa.model.dart';
import 'package:http/http.dart' as http;
import 'package:plants_movil/models/Requests/Planta.model.dart';
import 'package:plants_movil/models/Requests/Recorrido.model.dart';

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

  Future<Map<String, dynamic>> registrarPlanta(PlantaModel plantaModel) async {
    final parameters = jsonEncode({
      "latitud": plantaModel.latitud,
      "longitud": plantaModel.longitud,
      "imagen": plantaModel.imagen,
    });

    http.Response resp =
        await httpClient.post(url: 'Registrar/Planta/', body: parameters);

    if (resp.statusCode == 201) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw resp;
    }
  }

  Future<Map<String, dynamic>> registrarRecorrido(
      RecorridoModel recorridoModel) async {
    final parameters = jsonEncode(
        {"puntos": recorridoModel.puntos, "tiempo": recorridoModel.tiempo});

    http.Response resp =
        await httpClient.post(url: 'Registrar/Recorrido/', body: parameters);

    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw resp;
    }
  }
}
