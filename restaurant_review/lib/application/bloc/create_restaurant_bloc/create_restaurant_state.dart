// restaurant_state.dart
abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantCreated extends RestaurantState {}

class RestaurantUpdated extends RestaurantState {}

class RestaurantError extends RestaurantState {
  final String message;

  RestaurantError(this.message);
}

// Add other states as needed
