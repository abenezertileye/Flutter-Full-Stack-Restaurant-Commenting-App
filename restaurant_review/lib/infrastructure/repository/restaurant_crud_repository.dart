import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:restaurant_review/data/storage.dart';
import 'package:restaurant_review/domain/entities/create_restaurant_entity.dart';
import 'package:restaurant_review/domain/entities/update_restaurant_entity.dart';

class RestaurantCrudRepository {
  final SecureStorage _secureStorage = SecureStorage.instance;

  final String _baseUrl = 'http://localhost:3000';

  Future<http.Response> checkOwnerRestaurant() async {
    String? token = await _secureStorage.read('token');
    if (token == null) {
      throw Exception('Token not found');
    }

    // Decode the token to get the user ID (sub)
    Map<String, dynamic> payload = JwtDecoder.decode(token);
    String ownerId = payload['sub'];
    final url = Uri.parse('$_baseUrl/restaurant/owner/$ownerId');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    final response = await http.get(url, headers: headers);
    print("Check owner service response: ${response.body}");
    return response;
  }

  // Method to create a restaurant
  Future<http.Response> createRestaurant(CreateRestaurantDTO restaurant) async {
    String? token = await _secureStorage.read('token');

    final url = Uri.parse('$_baseUrl/restaurant');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    final body = jsonEncode(restaurant.toJson());

    final response = await http.post(url, headers: headers, body: body);
    // print(response);
    return response;
  }

//method to update a restaurant
  Future<http.Response> updateRestaurant(
      String id, UpdateRestaurantDTO restaurant) async {
    String? token = await _secureStorage.read('token');

    final url = Uri.parse('$_baseUrl/restaurant/$id');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    final body = jsonEncode(restaurant.toJson());

    final response = await http.patch(url, headers: headers, body: body);
    return response;
  }

  // Method to delete a restaurant
  Future<http.Response> deleteRestaurant(String id) async {
    String? token = await _secureStorage.read('token');

    // final responsefromCheck = await checkOwnerRestaurant();
    // if (responsefromCheck.statusCode == 200) {
    //   if (responsefromCheck.body.isEmpty) {
    //     throw Exception('User does not have a restaurant');
    //   }
    // }

    final url = Uri.parse('$_baseUrl/restaurant/$id');
    final headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    final response = await http.delete(url, headers: headers);
    return response;
  }
}
