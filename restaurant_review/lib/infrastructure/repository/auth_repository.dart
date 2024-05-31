import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/domain/entities/user_entity.dart';
import 'package:restaurant_review/data/storage.dart';

class AuthRepository {
  //instantiate everytime you need the token
  final SecureStorage _secureStorage = SecureStorage.instance;

  final String _baseUrl = 'http://localhost:3000';

  Future<User> signUp({
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
        'roles': userType == UserType.owner ? 'owner' : 'user',
      }),
    );
    // print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);

      final user = User.fromJson(responseData);
      print('user: $user');
      return user;
    } else {
      throw Exception('Failed to sign up: ${response.reasonPhrase}');
    }
  }

  Future<User> login({
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
    // print(response.body);
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      await _secureStorage.write('token', responseData['access_token']);
      final user = User.fromJson(responseData);
      return user;
    } else {
      throw Exception('Failed to log in: ${response.reasonPhrase}');
    }
  }
  Future<void> logout() async {
    await _secureStorage.delete('token');
  }
}
