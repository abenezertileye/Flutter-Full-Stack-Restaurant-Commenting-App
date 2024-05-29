import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';

class RestaurantsRepository {
  final String _baseUrl = 'http://localhost:3000';

  Future<List<dynamic>> FetchRestaurants() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/restaurant'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NjU0NDUyZDlhYTg1YTdiMmI1ZDM3NDMiLCJ1c2VybmFtZSI6InVzZXIxIiwicm9sZXMiOlsiY3VzdG9tZXIiXSwiaWF0IjoxNzE2OTIwNzAzLCJleHAiOjE3MTcwMDcxMDN9.AMPbR3DwwEctmynnSej8WQt8fWIjg9NNfy1Y-q4GpC0'
      },
    );
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final restaurants = jsonDecode(response.body);
      print('restaurants list in restaurants repo: $restaurants');
      return restaurants;
    } else {
      throw Exception('Failed to fetch restaurants: ${response.reasonPhrase}');
    }
  }
}
