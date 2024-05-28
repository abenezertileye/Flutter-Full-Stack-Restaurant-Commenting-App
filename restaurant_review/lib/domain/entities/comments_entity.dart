class Comment {
  final String username;
  final String opinion;
  final String date; // Assuming each comment has a date field

  Comment({
    required this.username,
    required this.opinion,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      username: json['username'] ?? '',
      opinion: json['opinion'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
