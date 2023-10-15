import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/generics/persistence/model.dart';
import 'package:plants_movil/utilities/http_client.dart';

abstract class Service<M extends BaseModel> {
  late final String _serviceUrl;
  late final HttpClient httpClient;
  Service([String serviceUrl = '']) {
    _serviceUrl = Enviroment.serverUrl + serviceUrl;
    httpClient = HttpClient(_serviceUrl);
  }

  Future<M> create(M model) async {
    http.Response resp = await httpClient.post(body: model);
    if (resp.statusCode == 200) {
      return instanceFromMap((json.decode(resp.body) as Map<String, dynamic>));
    } else {
      throw resp;
    }
  }

  Future<M> update(M model) async {
    http.Response resp =
        await httpClient.put(url: '/${model.id}', body: model);
    if (resp.statusCode == 200) {
      return instanceFromMap((json.decode(resp.body) as Map<String, dynamic>));
    } else {
      throw resp;
    }
  }

  Future<M> delete(M model) async {
    http.Response resp =
        await httpClient.delete(url: '/${model.id}');
    if (resp.statusCode == 200) {
      return instanceFromMap((json.decode(resp.body) as Map<String, dynamic>));
    } else {
      throw resp;
    }
  }

  Future<M> getOne(int id) async {
    http.Response resp = await httpClient.get(url: '/$id');
    if (resp.statusCode == 200) {
      return instanceFromMap((json.decode(resp.body) as Map<String, dynamic>));
    } else {
      throw resp;
    }
  }

  Future<List<M>> getAll() async {
    http.Response resp = await httpClient.get();
    if (resp.statusCode == 200) {
      return ((json.decode(resp.body) as List<dynamic>)
          .map<M>((element) => instanceFromMap(element as Map<String, dynamic>))
          .toList());
    } else {
      throw resp;
    }
  }

  M instanceFromMap(Map<String, dynamic> jsonMap);
}
