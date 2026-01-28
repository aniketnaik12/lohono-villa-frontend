import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔁 Platform-aware base URL
 static const baseUrl = 'http://localhost:3000';

  /// GET /v1/villas/availability
  static Future<List<dynamic>> getAvailability({
    required String checkIn,
    required String checkOut,
    String? search,
    List<String>? tags,
    String sort = 'avg_price_per_night',
    String order = 'ASC',
  }) async {
    final queryParams = {
      'check_in': checkIn,
      'check_out': checkOut,
      'sort': sort,
      'order': order,
      if (search != null && search.isNotEmpty) 'search': search,
      if (tags != null && tags.isNotEmpty) 'tags': tags.join(','),
    };

    final uri = Uri.http(
      baseUrl.replaceAll('http://', ''),
      '/v1/villas/availability',
      queryParams,
    );

    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('Availability API error');
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
