// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import './api_config.dart';

class ApiService {
  // Fetch articles from IEEE Xplore API
  Future<dynamic> fetchArticles(String query) async {
    final String url = "$baseUrl?querytext=$query&apikey=$apiKey"; // Append parameters

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Parse JSON response
      } else {
        throw Exception("Failed to fetch articles: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching articles: $e");
    }
  }
}
