class UserDetail {
  final String? id;
  final String username;
  final String email;
  final String? password;
  final List<dynamic> roles;
  final bool? isBanned;
  final String createdAt;
  final String updatedAt;

  UserDetail({
    this.id,
    required this.username,
    required this.email,
    this.password,
    required this.roles,
    this.isBanned,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
        id: json['_id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        roles: json['roles'],
        isBanned: json['isBanned'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
