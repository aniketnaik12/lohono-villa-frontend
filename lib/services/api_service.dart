import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://localhost:3000';

  static Future<List<dynamic>> getAvailability({
    required String checkIn,
    required String checkOut,
    String? search,
    List<String>? tags,
    String sort = 'avg_price_per_night',
    String order = 'ASC',
    int? minPrice,
    int? maxPrice,
  }) async {
    final queryParams = <String, String>{
      'check_in': checkIn,
      'check_out': checkOut,
      'sort': sort,
      'order': order,
    };

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    if (tags != null && tags.isNotEmpty) {
      queryParams['tags'] = tags.join(',');
    }

    if (minPrice != null) {
      queryParams['min_price'] = minPrice.toString();
    }

    if (maxPrice != null) {
      queryParams['max_price'] = maxPrice.toString();
    }

    final uri = Uri.parse('$baseUrl/v1/villas/availability')
        .replace(queryParameters: queryParams);

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('API error');
    }

    return jsonDecode(res.body)['data'];
  }

  
  /// GET /v1/villas/:id/quote
  static Future<Map<String, dynamic>> getQuote(
    int villaId,
    String checkIn,
    String checkOut,
  ) async {
    final uri = Uri.http(
      baseUrl.replaceAll('http://', ''),
      '/v1/villas/$villaId/quote',
      {
        'check_in': checkIn,
        'check_out': checkOut,
      },
    );

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('Quote API error');
    }

    return jsonDecode(res.body);
  }
}
