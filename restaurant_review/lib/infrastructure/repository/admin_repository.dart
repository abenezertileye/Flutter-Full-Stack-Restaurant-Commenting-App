import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';
import 'package:restaurant_review/domain/entities/restaurant_entity.dart';
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/data/storage.dart';
import 'package:restaurant_review/url.dart';

class AdminRepository {
  final SecureStorage _secureStorage = SecureStorage.instance;

  final String _baseUrl = Domain.url;

//FETCH USERS OR OWNERS
  Future<List<UserDetail>> fetch(role) async {
    String? token = await _secureStorage.read('token');

    final response = await http.get(
      Uri.parse('$_baseUrl/users?roles=$role'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as List<dynamic>;
      // print('response in admin repo: $responseData');

      final List<UserDetail> customers = responseData.map((data) {
        // print('Mapping data: $data');
        return UserDetail.fromJson(data as Map<String, dynamic>);
      }).toList();

      // print('customers in repo: $customers');
      // print('customers list in admin repo: $customers');
      return customers;
    } else {
      throw Exception('Failed to fetch customers: ${response.reasonPhrase}');
    }
  }



//BAN OWNERS OR USERS
  Future<String> ban(username) async {
    
    String? token = await _secureStorage.read('token');

    final response = await http.patch(
      Uri.parse('$_baseUrl/admin-func/ban/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    

    if (response.statusCode == 200) {
      
      return 'Customer Banned Successfully';
    } else {
      throw Exception('Failed to fetch owners: ${response.reasonPhrase}');
    }
  }

//UNBAN OWNERS OR USERS
  Future<String> unban(username) async {
    
    String? token = await _secureStorage.read('token');

    final response = await http.patch(
      Uri.parse('$_baseUrl/admin-func/unban/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    

    if (response.statusCode == 200) {
      
      return 'Customer Banned Successfully';
    } else {
      throw Exception('Failed to fetch owners: ${response.reasonPhrase}');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete('token');
  }
}
