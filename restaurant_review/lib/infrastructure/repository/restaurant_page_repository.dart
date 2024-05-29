import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/domain/entities/restaurant_entity.dart';
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';

class RestaurantPageRepository {
  // final String username;

  // RestaurantPageRepository({required this.username});
  final String _baseUrl = 'http://localhost:3000';

//GET RESTAURANTS
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
      print('responseData in restaurant repo: $responseData');
      final restaurant = Restaurant.fromJson(responseData);
      print(
          'restaurant comments in restaurant page repository: ${restaurant.comments}');
      return restaurant;
    } else {
      throw Exception('Failed to fetch restaurants: ${response.reasonPhrase}');
    }
  }

//CREATE COMMENT
  Future<String> createCommentRepo(opinion) async {
    final response = await http
        .post(Uri.parse('$_baseUrl/comment'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    print('status code in rest page repo: ${response.statusCode}');
    if (response.statusCode == 200) {
      final confirmation = 'Comment Updated Successfully';
      return confirmation;
    } else {
      throw Exception('Failed to update comment: ${response.reasonPhrase}');
    }
  }

  //DELETE COMMENT
  Future<String> deleteCommentRepo(commentId) async {
    // print(commentId);
    print('$_baseUrl/comment/$commentId');
    final response = await http.delete(
        Uri.parse('$_baseUrl/comment/$commentId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(
        'delete comment status code in rest page repo: ${response.statusCode}');
    if (response.statusCode == 200) {
      final confirmation = 'Comment Deleted Successfully';
      return confirmation;
    } else {
      throw Exception('Failed to update comment: ${response.reasonPhrase}');
    }
  }
}
