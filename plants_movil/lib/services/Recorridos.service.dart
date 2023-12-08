import 'dart:convert';
import 'package:plants_movil/generics/persistence/service.dart';
import 'package:http/http.dart' as http;
import 'package:plants_movil/models/Recorridos.model.dart';

class RecorridosService extends Service<Recorridos> {
  @override
  Recorridos instanceFromMap(Map<String, dynamic> jsonMap) =>
      Recorridos.fromJson(jsonMap);

  Future<List<Recorridos>> obtenerRecorridos(
      String fechaInicial, String fechaFinal) async {
    final parameters =
        jsonEncode({"fechainicial": fechaInicial, "fechafinal": fechaFinal});
    http.Response resp = await httpClient.post(
      url: 'MisRecorridos',
      body: parameters,
    );

    if (resp.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(resp.body)["data"];
      return jsonResponse.map((mapa) => Recorridos.fromJson(mapa)).toList();
    } else {
      throw resp;
    }
  }
}
