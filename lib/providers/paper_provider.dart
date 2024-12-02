import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaperProvider with ChangeNotifier {
  bool _isLoading = false;
  List<Map<String, dynamic>> _articles = [];
  String _error = ''; // Added error field

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get articles => _articles;
  String get error => _error;

  get papers => _articles; // Getter for error

  Future<void> fetchArticles(String query) async {
    const String apiKey = '8kgz84dse7edhukewfa9z97x'; // API key
    final String url =
        'https://ieeexploreapi.ieee.org/api/v1/search/articles?querytext=$query&apikey=$apiKey';

    _isLoading = true;
    _error = ''; // Clear previous errors
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response: ${response.body}');

        if (data['articles'] != null) {
          _articles = List<Map<String, dynamic>>.from(data['articles']);
        } else {
          _articles = [];
        }
      } else {
        _error =
            'Failed to fetch articles: ${response.reasonPhrase} (${response.statusCode})';
            
      }
    } catch (e) {
      _error = 'provide articles: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
