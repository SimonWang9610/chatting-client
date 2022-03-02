import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpUtil {
  static const String _baseUri = 'http://localhost:8080';

  static Future<Map<String, dynamic>> post(String url, {dynamic data}) async {
    final res = await http.post(
      Uri.parse(_baseUri + url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    return json.decode(res.body);
  }

  static Future<Map<String, dynamic>> get(String url) async {
    final res = await http.post(
      Uri.parse(_baseUri + url),
      headers: {'Content-Type': 'application/json'},
    );

    return json.decode(res.body);
  }
}
