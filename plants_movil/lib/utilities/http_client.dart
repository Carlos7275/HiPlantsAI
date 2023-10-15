import 'package:http/http.dart' as http;
import 'package:plants_movil/utilities/local_persistance.dart';

class HttpClient {
  final String? url;
  final LocalPersistance _localPersistance = LocalPersistance.instance;

  HttpClient([this.url]);

  String? get _jwt => _localPersistance.jwt;

  Uri _generateUri(String? url) => Uri.parse((this.url ?? '') + (url ?? ''));
  Map<String, String> _generateheaders(Map<String, String>? headers) {
    Map<String, String>? finalHeaders = {};

    if (_jwt != null && _jwt != '') {
      finalHeaders.addAll({'Authorization': 'Bearer ' + _jwt!});
    }
    finalHeaders.addAll(headers ?? {});

    return finalHeaders;
  }

  Future<http.Response> get({String? url, Map<String, String>? headers}) =>
      http.get(_generateUri(url), headers: _generateheaders(headers));

  Future<http.Response> delete(
          {String? url, Object? body, Map<String, String>? headers}) =>
      http.delete(_generateUri(url),
          body: body, headers: _generateheaders(headers));

  Future<http.Response> post(
          {String? url, Object? body, Map<String, String>? headers}) async =>
      await http.post(_generateUri(url),
          body: body, headers: _generateheaders(headers));

  Future<http.Response> put(
          {String? url, Object? body, Map<String, String>? headers}) =>
      http.put(_generateUri(url),
          body: body, headers: _generateheaders(headers));

  Future<http.Response> patch(
          {String? url, Object? body, Map<String, String>? headers}) =>
      http.patch(_generateUri(url),
          body: body, headers: _generateheaders(headers));
}
