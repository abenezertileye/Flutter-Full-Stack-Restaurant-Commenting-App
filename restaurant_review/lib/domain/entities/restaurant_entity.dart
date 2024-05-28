class Restaurant {
  final String id;
  final String name;
  final String description;
  final String location;
  final String contact;
  final String openingTime;
  final String closingTime;
  final String ownerId;
  final List<String> comments;
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
    return Restaurant(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      contact: json['contact'],
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
      ownerId: json['ownerId'],
      comments: List<String>.from(json['comments'] ?? []),
      isBanned: json['isBanned'],
    );
  }
}
