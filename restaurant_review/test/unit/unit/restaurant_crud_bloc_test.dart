import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/application/bloc/restaurant_crud_bloc/restaurant_crud_bloc.dart';
import 'package:restaurant_review/application/bloc/restaurant_crud_bloc/restaurant_crud_event.dart';
import 'package:restaurant_review/application/bloc/restaurant_crud_bloc/restaurant_crud_state.dart';
import 'package:restaurant_review/domain/entities/create_restaurant_entity.dart';
import 'package:restaurant_review/domain/entities/update_restaurant_entity.dart';
import 'package:restaurant_review/domain/usecase/restaurant_crud_usecase.dart';

import 'restaurant_crud_bloc_test.mocks.dart';

@GenerateMocks([RestaurantCrudUsecase])
void main() {
  late MockRestaurantCrudUsecase mockRestaurantCrudUsecase;
  late RestaurantCrudBloc restaurantCrudBloc;

  setUp(() {
    mockRestaurantCrudUsecase = MockRestaurantCrudUsecase();
    restaurantCrudBloc = RestaurantCrudBloc(mockRestaurantCrudUsecase);
  });

  group('RestaurantCrudBloc', () {
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

    blocTest<RestaurantCrudBloc, RestaurantCrudState>(
      'emits [RestaurantCreationLoading, RestaurantCreated] when CreateRestaurantRequested is added',
      build: () {
        when(mockRestaurantCrudUsecase.createRestaurant(createRestaurantDTO))
            .thenAnswer((_) async => Right(createRestaurantDTO));
        return restaurantCrudBloc;
      },
      act: (bloc) => bloc.add(CreateRestaurantRequested(createRestaurantDTO)),
      expect: () => [
        RestaurantCreationLoading(),
        RestaurantCreated(createRestaurantDTO),
      ],
    );

    blocTest<RestaurantCrudBloc, RestaurantCrudState>(
      'emits [RestaurantUpdateLoading, RestaurantUpdated] when UpdateRestaurantRequested is added',
      build: () {
        when(mockRestaurantCrudUsecase.updateRestaurant(updateRestaurantDTO))
            .thenAnswer((_) async => Right(updateRestaurantDTO));
        return restaurantCrudBloc;
      },
      act: (bloc) => bloc.add(UpdateRestaurantRequested(updateRestaurantDTO)),
      expect: () => [
        RestaurantUpdateLoading(),
        RestaurantUpdated(updateRestaurantDTO),
      ],
    );

    blocTest<RestaurantCrudBloc, RestaurantCrudState>(
      'emits [RestaurantDeleteLoading, RestaurantDeleted] when DeleteRestaurantRequested is added',
      build: () {
        when(mockRestaurantCrudUsecase.deleteRestaurant())
            .thenAnswer((_) async => Right(unit));
        return restaurantCrudBloc;
      },
      act: (bloc) => bloc.add(DeleteRestaurantRequested()),
      expect: () => [
        RestaurantDeleteLoading(),
        RestaurantDeleted(),
      ],
    );
  });
}
