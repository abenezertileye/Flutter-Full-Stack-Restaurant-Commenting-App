abstract class RestaurantPageState {}

class RestaurantPageInitial extends RestaurantPageState {}

class RestaurantPageLoading extends RestaurantPageState {}

class RestaurantPageLoaded extends RestaurantPageState {
  final Map<String, dynamic> restaurant;

  RestaurantPageLoaded(this.restaurant);
}

class RestaurantPageError extends RestaurantPageState {
  final String message;

  RestaurantPageError(this.message);
}
