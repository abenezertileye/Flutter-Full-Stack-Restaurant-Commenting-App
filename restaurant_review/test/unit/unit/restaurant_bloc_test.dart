import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/application/bloc/home_page_bloc/restaurants_bloc.dart';
import 'package:restaurant_review/application/bloc/home_page_bloc/restaurants_event.dart';
import 'package:restaurant_review/application/bloc/home_page_bloc/restaurants_state.dart';
import 'package:restaurant_review/domain/usecase/restaurants_usecase.dart';

import 'restaurant_bloc_test.mocks.dart';

@GenerateMocks([RestaurantsUseCase])
void main() {
  late MockRestaurantsUseCase mockRestaurantsUseCase;
  late RestaurantBloc restaurantBloc;

  setUp(() {
    mockRestaurantsUseCase = MockRestaurantsUseCase();
    restaurantBloc = RestaurantBloc(restaurantsUseCase: mockRestaurantsUseCase);
  });

  group('RestaurantBloc', () {
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

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantLoaded] when FetchRestaurants is added and usecase is successful',
      build: () {
        when(mockRestaurantsUseCase.execute())
            .thenAnswer((_) async => restaurants);
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(FetchRestaurants()),
      expect: () => [
        isA<RestaurantLoading>(),
        isA<RestaurantLoaded>(),
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantError] when FetchRestaurants is added and usecase fails',
      build: () {
        when(mockRestaurantsUseCase.execute())
            .thenThrow(Exception('Failed to fetch restaurants'));
        return restaurantBloc;
      },
      act: (bloc) => bloc.add(FetchRestaurants()),
      expect: () => [
        isA<RestaurantLoading>(),
        isA<RestaurantError>(),
      ],
    );
  });
}
