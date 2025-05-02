class Event {
  final String id;
  final String name;
  final String description;
  final String venue;
  final DateTime date;
  final String category;
  final double entryFee;
  final int capacity;
  final String imageUrl;
  final List<String> galleryImages;
  final String organizerContact;
  final String website;
  final bool isBookmarked;
  final String location;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.venue,
    required this.date,
    required this.category,
    required this.entryFee,
    required this.capacity,
    required this.imageUrl,
    required this.galleryImages,
    required this.organizerContact,
    required this.website,
    this.isBookmarked = false,
    required this.location,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      venue: json['venue'] as String,
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String,
      entryFee: (json['entryFee'] as num).toDouble(),
      capacity: json['capacity'] as int,
      imageUrl: json['imageUrl'] as String,
      galleryImages: List<String>.from(json['galleryImages'] as List),
      organizerContact: json['organizerContact'] as String,
      website: json['website'] as String,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'venue': venue,
      'date': date.toIso8601String(),
      'category': category,
      'entryFee': entryFee,
      'capacity': capacity,
      'imageUrl': imageUrl,
      'galleryImages': galleryImages,
      'organizerContact': organizerContact,
      'website': website,
      'isBookmarked': isBookmarked,
      'location': location,
    };
  }

  Event copyWith({
    String? id,
    String? name,
    String? description,
    String? venue,
    DateTime? date,
    String? category,
    double? entryFee,
    int? capacity,
    String? imageUrl,
    List<String>? galleryImages,
    String? organizerContact,
    String? website,
    bool? isBookmarked,
    String? location,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      venue: venue ?? this.venue,
      date: date ?? this.date,
      category: category ?? this.category,
      entryFee: entryFee ?? this.entryFee,
      capacity: capacity ?? this.capacity,
      imageUrl: imageUrl ?? this.imageUrl,
      galleryImages: galleryImages ?? this.galleryImages,
      organizerContact: organizerContact ?? this.organizerContact,
      website: website ?? this.website,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      location: location ?? this.location,
    );
  }
} 