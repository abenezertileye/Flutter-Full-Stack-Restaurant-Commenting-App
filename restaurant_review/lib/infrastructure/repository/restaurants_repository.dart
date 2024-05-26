import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';

class RestaurantsRepository {
  final String _baseUrl = 'http://localhost:3000';

  Future<List<dynamic>> FetchRestaurants() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final user = jsonDecode(response.body);
      // print(responseData);
      // final user = User(
      //   username: responseData['username'],
      //   email: responseData['email'],
      //   roles: responseData['roles'],
      //   createdAt: responseData['createdAt'],
      // );
      // print(user);
      return user;
    } else {
      throw Exception('Failed to fetch restaurants: ${response.reasonPhrase}');
    }
  }
}
