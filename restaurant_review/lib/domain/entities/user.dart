class User {
  final String username;
  final String email;
  final String roles;
  final String createdAt;

  User({
    required this.username,
    required this.email,
    required this.roles,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        email: json['email'],
        roles: json['roles'],
        createdAt: json['createdAt']);
  }
}
