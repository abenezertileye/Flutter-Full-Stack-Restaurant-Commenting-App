import 'dart:convert';

import 'package:restaurant_review/domain/entities/create_restaurant_entity.dart';
import 'package:restaurant_review/domain/entities/update_restaurant_entity.dart';
import 'package:restaurant_review/domain/failures/restaurant_failure.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_crud_repository.dart';
import 'package:dartz/dartz.dart';

class RestaurantCrudUsecase {
  final RestaurantCrudRepository _restaurantCrudRepository;

  RestaurantCrudUsecase(this._restaurantCrudRepository);


  Future<Either<RestaurantFailure, bool>>
      checkOwnerRestaurantforCreation() async {
    try {
      final response = await _restaurantCrudRepository.checkOwnerRestaurant();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("entered");
        final body = json.decode(response.body);
        print("ss ${body.isNotEmpty}");
        return right(body.isNotEmpty);
      } else {
        return left(RestaurantFailure(response.body));
      }
    } catch (e) {
      return left(RestaurantFailure(e.toString()));
    }
  }


  Future<Either<RestaurantFailure, CreateRestaurantDTO>> createRestaurant(
      CreateRestaurantDTO restaurant) async {
    final checkResponse = await checkOwnerRestaurantforCreation();
    return checkResponse.fold(
      (failure) => left(failure),
      (hasRestaurant) async {
        if (hasRestaurant) {
          return left(RestaurantFailure('Owner already has a restaurant'));
        } else {
          try {
            final response =
                await _restaurantCrudRepository.createRestaurant(restaurant);
            if (response.statusCode == 201) {
              final body = json.decode(response.body);
              final createdRestaurant = CreateRestaurantDTO.fromJson(body);
              return right(createdRestaurant);
            } else {
              return left(RestaurantFailure(response.body));
            }
          } catch (e) {
            return left(RestaurantFailure(e.toString()));
          }
        }
      },
    );
  }

  Future<Either<RestaurantFailure, Either<bool, String>>>
      checkOwnerRestaurantforUpdate() async {
    try {
      final response = await _restaurantCrudRepository.checkOwnerRestaurant();
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body.isEmpty) {
          return right(left(false));
        }
        print("CORU ${body['_id']}");
        
        return right(right(body['_id']));
      } else {
        return left(RestaurantFailure(response.body));
      }
    } catch (e) {
      return left(RestaurantFailure(e.toString()));
    }
  }

  Future<Either<RestaurantFailure, UpdateRestaurantDTO>> updateRestaurant(
      UpdateRestaurantDTO restaurant) async {
    final checkResponse = await checkOwnerRestaurantforUpdate();
    
    return checkResponse.fold(
      (failure) => left(failure),
      (result) async {
        
        if (result.isLeft()) {
          final hasRestaurant = result.getOrElse(() => '');
          if (hasRestaurant.isEmpty) {
            return left(RestaurantFailure('Owner does not have a restaurant'));
          }
        } else {
          final restaurantID = result.getOrElse(() => '');
          print("res id in usecase $restaurantID");
          print("rstaurant in usecase ${restaurant.location}");
          
          try {
            final response = await _restaurantCrudRepository.updateRestaurant(
                restaurantID, restaurant);
            print(response.statusCode);
            if (response.statusCode == 200) {
              final body = json.decode(response.body);
              final updatedRestaurant = UpdateRestaurantDTO.fromJson(body);
              print("UPDATED $updatedRestaurant");
              
              return right(updatedRestaurant);
            } else {
              return left(RestaurantFailure(response.body));
            }
          } catch (e) {
            return left(RestaurantFailure(e.toString()));
          }
        }
        return left(RestaurantFailure('An unexpected error occurred'));
      },
    );
  }

  Future<Either<RestaurantFailure, Unit>> deleteRestaurant() async {
    final checkResponse = await checkOwnerRestaurantforUpdate();
    return checkResponse.fold(
      (failure) => left(failure),
      (result) async {
        if (result.isLeft()) {
          final hasRestaurant = result.getOrElse(() => '');
          if (hasRestaurant.isEmpty) {
            return left(RestaurantFailure('Owner does not have a restaurant'));
          }
        } else {
          final restaurantID = result.getOrElse(() => '');
          try {
            final response =
                await _restaurantCrudRepository.deleteRestaurant(restaurantID);
            if (response.statusCode == 200) {
              return right(unit);
            } else {
              return left(RestaurantFailure(response.body));
            }
          } catch (e) {
            return left(RestaurantFailure(e.toString()));
          }
        }
        return left(RestaurantFailure('An unexpected error occurred'));
      },
    );
  }












}
