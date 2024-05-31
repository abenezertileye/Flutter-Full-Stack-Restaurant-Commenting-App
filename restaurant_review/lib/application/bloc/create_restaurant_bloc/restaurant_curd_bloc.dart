// // restaurant_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:restaurant_review/application/restaurant/restaurant_event.dart';
// import 'package:restaurant_review/application/restaurant/restaurant_state.dart';
// import 'package:restaurant_review/infrastructure/restaurant/restaurant_repository.dart';

// class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
//   final RestaurantRepository restaurantRepository;

//   RestaurantBloc(this.restaurantRepository) : super(RestaurantInitial());

//   @override
//   Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
//     if (event is CreateRestaurantRequested) {
//       yield RestaurantLoading();
//       try {
//         await restaurantRepository.createRestaurant(event.restaurant);
//         yield RestaurantCreated();
//       } catch (error) {
//         yield RestaurantError(error.toString());
//       }
//     } else if (event is UpdateRestaurantRequested) {
//       yield RestaurantLoading();
//       try {
//         await restaurantRepository.updateRestaurant(event.restaurant);
//         yield RestaurantUpdated();
//       } catch (error) {
//         yield RestaurantError(error.toString());
//       }
//     }
//     // Add other event handlers as needed
//   }
// }
