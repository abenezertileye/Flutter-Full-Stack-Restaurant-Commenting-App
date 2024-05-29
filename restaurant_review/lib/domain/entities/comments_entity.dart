class Comment {
  final String id;
  final String opinion;
  final String userId;
  final String username;
  final String restaurantId;
  Comment({
    required this.id,
    required this.opinion,
    required this.userId,
    required this.username,
    required this.restaurantId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] as String,
      opinion: json['opinion'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      restaurantId: json['restaurantId'] as String,
    );
  }
}
