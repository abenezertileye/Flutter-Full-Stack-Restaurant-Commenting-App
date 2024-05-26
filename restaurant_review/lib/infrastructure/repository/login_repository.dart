import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/domain/entities/user.dart';

class LoginAuthRepository {
  final String _baseUrl = 'http://localhost:3000';

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 400) {
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
      throw Exception('Failed to sign up: ${response.reasonPhrase}');
    }
  }
}
