abstract class RestaurantPageEvent {}

class FetchRestaurantDetails extends RestaurantPageEvent {
  final String id;

  FetchRestaurantDetails(this.id);
}
