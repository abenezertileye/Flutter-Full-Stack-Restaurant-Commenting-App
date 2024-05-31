import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:restaurant_review/domain/entities/restaurant_entity.dart';
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/data/storage.dart';
import 'package:restaurant_review/url.dart';

class RestaurantPageRepository {
  final SecureStorage _secureStorage = SecureStorage.instance;

  final String _baseUrl = Domain.url;

//GET RESTAURANT
  Future<Restaurant> FetchRestaurantData(restaurantId) async {
    String? token = await _secureStorage.read('token');

    final response = await http.get(
      Uri.parse('$_baseUrl/restaurant/$restaurantId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    // print('fetching restaurant data: ${response.statusCode}');
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // print('responseData in restaurant repo: $responseData');
      final restaurant = Restaurant.fromJson(responseData);

      return restaurant;
    } else {
      throw Exception('Failed to fetch restaurants: ${response.reasonPhrase}');
    }
  }

//CREATE COMMENT
  Future<String> createCommentRepo(opinion, restId) async {
    print('comment in repo, restId: ${restId}');

    String? token = await _secureStorage.read('token');

    final response = await http.post(
      Uri.parse('$_baseUrl/comment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'restaurantId': restId,
        'opinion': opinion,
      }),
    );
    print('create comment status code: ${response.statusCode}');
    if (response.statusCode == 201) {
      final confirmation = 'Comment Updated Successfully';
      return confirmation;
    } else {
      throw Exception('Failed to update comment: ${response.reasonPhrase}');
    }
  }

  //DELETE COMMENT
  Future<String> deleteCommentRepo(commentId) async {
    String? token = await _secureStorage.read('token');

    print('$_baseUrl/comment/$commentId');
    final response = await http.delete(
      Uri.parse('$_baseUrl/comment/$commentId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    print(
        'delete comment status code in rest page repo: ${response.statusCode}');
    if (response.statusCode == 200) {
      final confirmation = 'Comment Deleted Successfully';
      return confirmation;
    } else {
      throw Exception('Failed to update comment: ${response.reasonPhrase}');
    }
  }

  //UPDATE COMMENTS
  Future<String> updateCommentRepo(opinion, commentId) async {
    String? token = await _secureStorage.read('token');

    print('$_baseUrl/comment/$commentId');
    final response = await http.put(Uri.parse('$_baseUrl/comment/$commentId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({"opinion": opinion}));

    print(
        'update comment status code in rest page repo: ${response.statusCode}');
    print('updated comment rest page repo: ${response.body}');
    if (response.statusCode == 200) {
      final confirmation = 'Comment Updated Successfully';
      return confirmation;
    } else {
      throw Exception('Failed to update comment: ${response.reasonPhrase}');
    }
  }
}
