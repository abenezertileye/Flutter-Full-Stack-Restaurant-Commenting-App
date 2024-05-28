abstract class RestaurantPageEvent {}

class FetchRestaurantDetails extends RestaurantPageEvent {
  final String restaurantName;

  FetchRestaurantDetails(this.restaurantName);
}
