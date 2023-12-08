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

  Future<String> plantaMasVisitadaTiempo() async {
    http.Response resp =
        await httpClient.get(url: 'Plantas/MasVisitadas/Tiempo/1');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> plantaMenosVisitadaTiempo() async {
    http.Response resp =
        await httpClient.get(url: 'Plantas/MenosVisitadas/Tiempo/1');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> plantaNoVisitadas() async {
    http.Response resp = await httpClient.get(url: 'Plantas/NoVisitadas/1');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> plantaCercanas(double lat, double longitud) async {
    http.Response resp =
        await httpClient.get(url: 'Plantas/Cercanas/1/$lat/$longitud');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> plantaCercanasToxicas(double lat, double longitud) async {
    http.Response resp =
        await httpClient.get(url: 'Plantas/Cercanas/Toxicas/1/$lat/$longitud');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> plantaCercanasNoToxicas(double lat, double longitud) async {
    http.Response resp = await httpClient.get(
        url: 'Plantas/Cercanas/No/Toxicas/1/$lat/$longitud');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> areasCercanas(double lat, double longitud) async {
    http.Response resp =
        await httpClient.get(url: 'Areas/Cercanas/1/$lat/$longitud');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> areaMasVisitada() async {
    http.Response resp = await httpClient.get(url: 'Areas/MasVisitadas/1');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> areaMenosVisitadaTiempo() async {
    http.Response resp =
        await httpClient.get(url: 'Areas/MenosVisitadas/Tiempo/1');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> plantasCercanasComestibles(double lat, double long) async {
    http.Response resp =
        await httpClient.get(url: 'Plantas/Cercanas/Comestibles/1/$lat/$long');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }

  Future<String> plantasCercanasVegetables(double lat, double long) async {
    http.Response resp =
        await httpClient.get(url: 'Plantas/Cercanas/Vegetables/1/$lat/$long');

    if (resp.statusCode == 200) {
      return json.decode(resp.body)["data"];
    } else {
      throw resp;
    }
  }
}
