class Restaurant {
  final String id;
  final String username;
  final String email;
  final List<String> roles;
  final String createdAt;

  Restaurant({
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.createdAt,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      roles: List<String>.from(json['roles'] ?? []),
      createdAt: json['createdAt'],
    );
  }
}
