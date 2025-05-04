class Attraction {
  final String id;
  final String name;
  final String description;
  final String category;
  final String location;
  final String? imageUrl;
  final double ticketPrice;

  Attraction({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    this.imageUrl,
    required this.ticketPrice,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    if (json['images'].isNotEmpty) {
      imageUrl = json['images'][0]['url'];
    }

    return Attraction(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      location: json['location'],
      imageUrl: imageUrl,
      ticketPrice: json['ticketPrice'].toDouble(),
    );
  }
}
