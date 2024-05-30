class UserDetail {
  final String? id;
  final String username;
  final String email;
  final String? password;
  final List<dynamic> roles;
  final bool isBanned;
  final String createdAt;
  final String updatedAt;

  UserDetail({
    this.id,
    required this.username,
    required this.email,
    this.password,
    required this.roles,
    required this.isBanned,
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

  UserDetail copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    List<dynamic>? roles,
    bool? isBanned,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserDetail(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      roles: roles ?? this.roles,
      isBanned: isBanned ?? this.isBanned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
