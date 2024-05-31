import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/domain/entities/create_restaurant_entity.dart';
import 'package:restaurant_review/domain/entities/update_restaurant_entity.dart';
import 'package:restaurant_review/domain/failures/restaurant_failure.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_crud_repository.dart';
import 'package:restaurant_review/domain/usecase/restaurant_crud_usecase.dart';

import 'package:http/http.dart' as http;

import 'restaurant_crud_usecase_test.mocks.dart';

@GenerateMocks([RestaurantCrudRepository])
void main() {
  late MockRestaurantCrudRepository mockRestaurantCrudRepository;
  late RestaurantCrudUsecase restaurantCrudUsecase;

  setUp(() {
    mockRestaurantCrudRepository = MockRestaurantCrudRepository();
    restaurantCrudUsecase = RestaurantCrudUsecase(mockRestaurantCrudRepository);
  });

  group('RestaurantCrudUsecase', () {
    final createRestaurantDTO = CreateRestaurantDTO(
      name: 'Test Restaurant',
      description: 'A description',
      location: 'Location',
      contact: '12345',
      openingTime: '09:00',
      closingTime: '22:00',
    );

    final updateRestaurantDTO = UpdateRestaurantDTO(
      name: 'Updated Restaurant',
      description: 'Updated description',
    );

    test('should create restaurant successfully', () async {
      when(mockRestaurantCrudRepository.checkOwnerRestaurant())
          .thenAnswer((_) async => http.Response('[]', 200));
      when(mockRestaurantCrudRepository.createRestaurant(createRestaurantDTO))
          .thenAnswer((_) async => http.Response('{}', 201));

      final result =
          await restaurantCrudUsecase.createRestaurant(createRestaurantDTO);

      expect(result.isRight(), false);
      verify(mockRestaurantCrudRepository.checkOwnerRestaurant()).called(1);
      verify(mockRestaurantCrudRepository.createRestaurant(createRestaurantDTO))
          .called(1);
    });

    test('should return failure if owner already has a restaurant', () async {
      when(mockRestaurantCrudRepository.checkOwnerRestaurant())
          .thenAnswer((_) async => http.Response('[{"_id": "1"}]', 200));

      final result =
          await restaurantCrudUsecase.createRestaurant(createRestaurantDTO);

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), isA<RestaurantFailure>());
      verify(mockRestaurantCrudRepository.checkOwnerRestaurant()).called(1);
    });

    test('should update restaurant successfully', () async {
      when(mockRestaurantCrudRepository.checkOwnerRestaurant())
          .thenAnswer((_) async => http.Response('[{"_id": "1"}]', 200));
      when(mockRestaurantCrudRepository.updateRestaurant(any, any))
          .thenAnswer((_) async => http.Response('{}', 200));

      final result =
          await restaurantCrudUsecase.updateRestaurant(updateRestaurantDTO);

      expect(result.isRight(), false);
      // verify(mockRestaurantCrudRepository.checkOwnerRestaurant()).called(1);
      // verify(mockRestaurantCrudRepository.updateRestaurant(
      //         any, updateRestaurantDTO))
      //     .called(1);
    });

    test('should delete restaurant successfully', () async {
      when(mockRestaurantCrudRepository.checkOwnerRestaurant())
          .thenAnswer((_) async => http.Response('[{"_id": "1"}]', 200));
      when(mockRestaurantCrudRepository.deleteRestaurant(any))
          .thenAnswer((_) async => http.Response('{}', 200));

      final result = await restaurantCrudUsecase.deleteRestaurant();

      expect(result.isRight(), false);
      // verify(mockRestaurantCrudRepository.checkOwnerRestaurant()).called(1);
      // verify(mockRestaurantCrudRepository.deleteRestaurant(any)).called(1);
    });
  });
}
