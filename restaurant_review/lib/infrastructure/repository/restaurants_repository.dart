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
