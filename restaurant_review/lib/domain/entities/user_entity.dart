class User {
  final String access_token;
  final List<String> roles;
  final String id;

  User({
    required this.access_token,
    required this.roles,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        access_token: json['access_token'] ?? '',
        roles: List<String>.from(json['roles'] ?? []),
        id: json['_id']);
  }
}
