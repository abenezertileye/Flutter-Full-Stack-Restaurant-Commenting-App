import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_page_repository.dart';

import '../entities/restaurant_entity.dart';

class RestaurantPageUseCase {
  final RestaurantPageRepository restaurantPageRepository;

  RestaurantPageUseCase({required this.restaurantPageRepository});

  Future<Restaurant> execute(restaurantId) async {
    final restaurantData =
        await restaurantPageRepository.FetchRestaurantData(restaurantId);

    print('inside restaurant page usecase$restaurantData');
    return restaurantData;
  }
}
