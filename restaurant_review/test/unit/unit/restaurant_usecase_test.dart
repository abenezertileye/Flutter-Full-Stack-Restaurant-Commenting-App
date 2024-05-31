import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/domain/usecase/restaurants_usecase.dart';

import 'restaurant_usecase_test.mocks.dart';

@GenerateMocks([RestaurantsRepository])
void main() {
  late MockRestaurantsRepository mockRestaurantsRepository;
  late RestaurantsUseCase restaurantsUseCase;

  setUp(() {
    mockRestaurantsRepository = MockRestaurantsRepository();
    restaurantsUseCase =
        RestaurantsUseCase(restaurantsRepository: mockRestaurantsRepository);
  });

  group('RestaurantsUseCase', () {
    test('returns list of restaurants when repository call is successful',
        () async {
      final restaurants = [
        {
          'id': '1',
          'name': 'Test Restaurant',
          'description': 'A description',
          'location': 'Location',
          'contact': '12345',
          'openingTime': '09:00',
          'closingTime': '22:00',
          'ownerId': 'owner1',
          'comments': [],
          'isBanned': false,
        },
      ];

      when(mockRestaurantsRepository.FetchRestaurants())
          .thenAnswer((_) async => restaurants);

      final result = await restaurantsUseCase.execute();

      expect(result, restaurants);
      verify(mockRestaurantsRepository.FetchRestaurants()).called(1);
    });

    test('throws an exception when repository call fails', () async {
      when(mockRestaurantsRepository.FetchRestaurants())
          .thenThrow(Exception('Failed to fetch restaurants'));

      expect(() => restaurantsUseCase.execute(), throwsException);
      verify(mockRestaurantsRepository.FetchRestaurants()).called(1);
    });
  });
}
