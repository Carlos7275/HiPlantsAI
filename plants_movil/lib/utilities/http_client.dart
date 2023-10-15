import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient {
  final String? url;
  HttpClient([this.url]);

  Uri _generateUri(String? url) => Uri.parse((this.url ?? '') + (url ?? ''));
  Future<Map<String, String>> _generateheaders(
      Map<String, String>? headers) async {
    Map<String, String>? finalHeaders = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jwt = prefs.get("token");

    if (jwt != '') {
      finalHeaders.addAll({'Authorization': 'Bearer $jwt'});
    } else {
      finalHeaders.addAll(headers ?? {});
    }

    return finalHeaders;
  }

  Future<http.Response> get(
          {String? url, Map<String, String>? headers}) async =>
      http.get(_generateUri(url), headers: await _generateheaders(headers));

  Future<http.Response> delete(
          {String? url, Object? body, Map<String, String>? headers}) async =>
      http.delete(_generateUri(url),
          body: body, headers: await _generateheaders(headers));

  Future<http.Response> post(
          {String? url, Object? body, Map<String, String>? headers}) async =>
      await http.post(_generateUri(url),
          body: body, headers: await _generateheaders(headers));

  Future<http.Response> put(
          {String? url, Object? body, Map<String, String>? headers}) async =>
      http.put(_generateUri(url),
          body: body, headers: await _generateheaders(headers));

  Future<http.Response> patch(
          {String? url, Object? body, Map<String, String>? headers}) async =>
      http.patch(_generateUri(url),
          body: body, headers: await _generateheaders(headers));
}
