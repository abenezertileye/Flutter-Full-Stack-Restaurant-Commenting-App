import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/domain/entities/user.dart';

class RestaurantsUseCase {
  final RestaurantsRepository restaurantsRepository;

  RestaurantsUseCase({required this.restaurantsRepository});

  Future<List<dynamic>> execute() async {
    final user = await restaurantsRepository.FetchRestaurants();
    print(user);
    return user;
  }
}
