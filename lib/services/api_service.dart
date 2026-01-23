import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://localhost:3000';

  static Future<List<dynamic>> getAvailability(
      String checkIn, String checkOut) async {
    final url =
        '$baseUrl/v1/villas/availability?check_in=$checkIn&check_out=$checkOut';

    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) throw Exception('API error');

    return jsonDecode(res.body)['data'];
  }

  static Future<Map<String, dynamic>> getQuote(
      int villaId, String checkIn, String checkOut) async {
    final url =
        '$baseUrl/v1/villas/$villaId/quote?check_in=$checkIn&check_out=$checkOut';

    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) throw Exception('API error');

    return jsonDecode(res.body);
  }
}
