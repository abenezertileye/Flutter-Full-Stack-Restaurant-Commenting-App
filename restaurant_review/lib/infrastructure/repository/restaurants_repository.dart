import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/data/storage.dart';

class RestaurantsRepository {
  final SecureStorage _secureStorage = SecureStorage.instance;

  final String _baseUrl = 'http://localhost:3000';
//FETCH ALL RESTAURATS
  Future<List<dynamic>> FetchRestaurants() async {
    String? token = await _secureStorage.read('token');

    final response = await http.get(
      Uri.parse('$_baseUrl/restaurant'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
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
