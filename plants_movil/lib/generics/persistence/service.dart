import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/utilities/http_client.dart';

abstract class Service<M> {
  late final String _serviceUrl;
  late final HttpClient httpClient;
  Service([String serviceUrl = '']) {
    _serviceUrl = Enviroment.serverUrl + serviceUrl;
    httpClient = HttpClient(_serviceUrl);
  }

  M instanceFromMap(Map<String, dynamic> jsonMap);
}
