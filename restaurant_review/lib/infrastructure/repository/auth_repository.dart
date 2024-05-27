import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/domain/entities/user.dart';

class AuthRepository {
  final String _baseUrl = 'http://localhost:3000';

  Future<Map<String, dynamic>> signUp({
    required String username,
    required String email,
    required String password,
    required UserType userType,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'roles': userType == UserType.owner ? 'owner' : 'customer',
      }),
    );

    if (response.statusCode == 201) {
      final user = jsonDecode(response.body);
      print(user);
      return user;
    } else {
      throw Exception('Failed to sign up: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      final user = jsonDecode(response.body);
      // print(responseData);
      // final user = User(
      //   username: responseData['username'],
      //   email: responseData['email'],
      //   roles: responseData['roles'],
      //   createdAt: responseData['createdAt'],
      // );
      // print(user);
      print(user);
      return user;
    } else {
      throw Exception('Failed to sign up: ${response.reasonPhrase}');
    }
  }
}
