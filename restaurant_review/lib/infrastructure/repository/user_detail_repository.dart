import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/data/storage.dart';
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepository {
  //jwt decoder for user detail entities
  final SecureStorage _secureStorage = SecureStorage.instance;

  final String _baseUrl = 'http://localhost:3000';

//FETCH USER DETAIL INFO
  Future<UserDetail> fetchUser() async {
    //jwt decoder for fetching users
    String? token = await _secureStorage.read('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    // Decode the token to get the user ID (sub)
    Map<String, dynamic> payload = JwtDecoder.decode(token);
    String userId = payload['sub'];

    final response = await http.get(
      Uri.parse('$_baseUrl/users/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    print('user fetch status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('response data in user repo: $responseData');
      final user = UserDetail.fromJson(responseData);
      print('user in user repo: $user');
      print(user);
      return user;
    } else {
      throw Exception('Failed to fetch restaurants: ${response.reasonPhrase}');
    }
  }

  //UPDATE PASSWORD
  Future<String> updatePasswordReq({
    required String oldPassword,
    required String newPassword,
  }) async {
    print('oldPassword: $oldPassword, newPassword: $newPassword');

    String? token = await _secureStorage.read('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    // Decode the token to get the user ID (sub)
    Map<String, dynamic> payload = JwtDecoder.decode(token);
    String userId = payload['sub'];

    try {
      final response = await http.patch(
          Uri.parse('$_baseUrl/users/changePassword/$userId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(
              {'old_password': oldPassword, 'new_password': newPassword}));

      print(' password update status code: ${response.statusCode}');
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = 'Password Updated Successfuly';
        return responseData;
      } else {
        return 'Failed to update password';
      }
    } catch (e) {
      throw Exception('Failed to update password: $e');
    }
  }

  //DELETE ACCOUNT
  Future<String> deleteAccountReq() async {
    String? token = await _secureStorage.read('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    // Decode the token to get the user ID (sub)
    Map<String, dynamic> payload = JwtDecoder.decode(token);
    String userId = payload['sub'];

    final response = await http.delete(
      Uri.parse('$_baseUrl/users/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    print('user delete status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final message = 'Account Deleted Successfully';
      return message;
    } else {
      throw Exception('Failed to delete account: ${response.reasonPhrase}');
    }
  }
}
