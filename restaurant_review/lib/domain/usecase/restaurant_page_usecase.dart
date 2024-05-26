import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_page_repository.dart';

class RestaurantPageUseCase {
  final RestaurantPageRepository restaurantPageRepository;

  RestaurantPageUseCase({required this.restaurantPageRepository});

  Future<Map<String, dynamic>> execute(username) async {
    final restaurantData = await restaurantPageRepository.FetchRestaurantData();
    print(restaurantData);
    return restaurantData;
  }
}
