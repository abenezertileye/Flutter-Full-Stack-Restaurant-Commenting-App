
class CreateRestaurantDTO {
  final String name;
  final String description;
  final String location;
  final String contact;
  final String openingTime;
  final String closingTime;

  CreateRestaurantDTO({
    required this.name,
    required this.description,
    required this.location,
    required this.contact,
    required this.openingTime,
    required this.closingTime,
  });

  factory CreateRestaurantDTO.fromJson(Map<String, dynamic> json) {
    return CreateRestaurantDTO(
      name: json['name'],
      description: json['description'],
      location: json['location'],
      contact: json['contact'],
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'contact': contact,
      'openingTime': openingTime,
      'closingTime': closingTime,
    };
  }
}
