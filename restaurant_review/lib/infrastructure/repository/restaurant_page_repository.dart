import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/domain/entities/restaurant_entity.dart';
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';

class RestaurantPageRepository {
  // final String username;

  // RestaurantPageRepository({required this.username});
  final String _baseUrl = 'http://localhost:3000';

  Future<Restaurant> FetchRestaurantData(restaurantId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/restaurant/$restaurantId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('fetching restaurant data: ${response.statusCode}');
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('responseData: $responseData');
      final restaurant = Restaurant.fromJson(responseData);
      print('restaurant in restaurant page repository: $restaurant');
      return restaurant;
    } else {
      throw Exception('Failed to fetch restaurants: ${response.reasonPhrase}');
    }
  }
}
