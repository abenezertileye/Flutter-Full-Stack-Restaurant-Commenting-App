import 'package:restaurant_review/domain/entities/comments_entity.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String location;
  final String contact;
  final String openingTime;
  final String closingTime;
  final String ownerId;
  final List<Comment> comments;
  final bool isBanned;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.contact,
    required this.openingTime,
    required this.closingTime,
    required this.ownerId,
    required this.comments,
    required this.isBanned,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    var commentsList = json['comments'] as List;
    List<Comment> comments =
        commentsList.map((i) => Comment.fromJson(i)).toList();

    return Restaurant(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      contact: json['contact'],
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
      ownerId: json['ownerId'],
      comments: comments,
      isBanned: json['isBanned'],
    );
  }

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    String? contact,
    String? openingTime,
    String? closingTime,
    String? ownerId,
    List<Comment>? comments,
    bool? isBanned,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      contact: contact ?? this.contact,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      ownerId: ownerId ?? this.ownerId,
      comments: comments ?? this.comments,
      isBanned: isBanned ?? this.isBanned,
    );
  }
}
