class Event {
  final String id;
  final String name;
  final String description;
  final String date;
  final String time;
  final List<EventImage> images;
  final double? averageRating;
  final List<EventReview>? reviews;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.images,
    this.averageRating,
    this.reviews,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      images: (json['images'] as List)
          .map((img) => EventImage.fromJson(img))
          .toList(),
      averageRating: json['averageRating']?.toDouble(),
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
              .map((review) => EventReview.fromJson(review))
              .toList()
          : null,
    );
  }
}

class EventImage {
  final String id;
  final String url;

  EventImage({
    required this.id,
    required this.url,
  });

  factory EventImage.fromJson(Map<String, dynamic> json) {
    return EventImage(
      id: json['id'],
      url: json['url'],
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}

class EventReview {
  final String id;
  final String userId;
  final String comment;
  final int rating;

  EventReview({
    required this.id,
    required this.userId,
    required this.comment,
    required this.rating,
  });

  factory EventReview.fromJson(Map<String, dynamic> json) {
    return EventReview(
      id: json['id'],
      userId: json['userId'],
      comment: json['comment'],
      rating: json['rating'],
    );
  }
}
