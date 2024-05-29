abstract class RestaurantPageEvent {}

class FetchRestaurantDetails extends RestaurantPageEvent {
  final String restaurantName;

  FetchRestaurantDetails(this.restaurantName);
}

class CreateCommentButtonPressed extends RestaurantPageEvent {
  final String opinion;

  CreateCommentButtonPressed({required this.opinion});
}

class DeleteCommentButtonPressed extends RestaurantPageEvent {
  final String commentId;

  DeleteCommentButtonPressed({required this.commentId});
}

class UpdateCommentButtonPressed extends RestaurantPageEvent {
  final String commentId;
  final String opinion;

  UpdateCommentButtonPressed({required this.commentId, required this.opinion});
}
