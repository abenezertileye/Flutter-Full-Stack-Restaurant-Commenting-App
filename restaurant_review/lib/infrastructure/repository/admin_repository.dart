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
    print('customer status code: ${response.statusCode}');

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

// //FETCH ALL OWNERS
//   Future<List<Restaurant>> fetchOwners() async {
//     String? token = await _secureStorage.read('token');

//     final response = await http.get(
//       Uri.parse('$_baseUrl/user?roles=owner'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token'
//       },
//     );

//     print('status code in admin repo: ${response.statusCode}');

//     if (response.statusCode == 200) {
//       // Decode the response body as a list
//       final responseData = jsonDecode(response.body);

//       if (responseData is List) {
//         // print('response in admin repo (as List): $responseData');

//         // Map each item in the list to a Restaurant object
//         final List<UserDetail> owners = responseData.map((data) {
//           return UserDetail.fromJson(data as Map<String, dynamic>);
//         }).toList();

//         // print('owners list in admin repo: $owners');
//         return owners;
//       } else {
//         throw Exception('Expected a list but got ${responseData.runtimeType}');
//       }
//     } else {
//       throw Exception('Failed to fetch owners: ${response.reasonPhrase}');
//     }
//   }

//BAN OWNERS OR USERS
  Future<String> ban(username) async {
    print(username);
    String? token = await _secureStorage.read('token');

    final response = await http.patch(
      Uri.parse('$_baseUrl/admin-func/ban/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    print('status code in admin repo: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Customer Banned Successfully');
      return 'Customer Banned Successfully';
    } else {
      throw Exception('Failed to fetch owners: ${response.reasonPhrase}');
    }
  }

//UNBAN OWNERS OR USERS
  Future<String> unban(username) async {
    print(username);
    String? token = await _secureStorage.read('token');

    final response = await http.patch(
      Uri.parse('$_baseUrl/admin-func/unban/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    print('status code in admin repo: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Customer Banned Successfully');
      return 'Customer Banned Successfully';
    } else {
      throw Exception('Failed to fetch owners: ${response.reasonPhrase}');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete('token');
  }
}
