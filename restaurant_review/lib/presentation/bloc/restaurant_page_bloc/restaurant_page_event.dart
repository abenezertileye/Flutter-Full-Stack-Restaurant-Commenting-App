abstract class RestaurantPageEvent {}

class FetchRestaurantDetails extends RestaurantPageEvent {
  final String username;

  FetchRestaurantDetails(this.username);
}
