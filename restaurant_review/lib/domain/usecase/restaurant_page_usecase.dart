import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_page_repository.dart';

import '../entities/restaurant_entity.dart';

class RestaurantPageUseCase {
  final RestaurantPageRepository restaurantPageRepository;

  RestaurantPageUseCase({required this.restaurantPageRepository});

//GET RESTAURANTS
  Future<Restaurant> fetch(restaurantId) async {
    final restaurantData =
        await restaurantPageRepository.FetchRestaurantData(restaurantId);

    print('inside restaurant page usecase: $restaurantData');
    return restaurantData;
  }

//CREATE COMMENT
  Future<String> createComment(
      {required String opinion, required String restId}) async {
    print('comment in usecase, opinion: ${opinion}');
    print('comment in usecase, restId: ${restId}');

    final confirmation =
        await restaurantPageRepository.createCommentRepo(opinion, restId);
    return confirmation;
  }

  //DELETECOMMENT
  Future<String> deleteComment({required String commentId}) async {
    final confirmation =
        await restaurantPageRepository.deleteCommentRepo(commentId);
    return confirmation;
  }

  Future<String> updateComment(
      {required String opinion, required String commentId}) async {
    final confirmation =
        await restaurantPageRepository.updateCommentRepo(opinion, commentId);
    return confirmation;
  }
}
