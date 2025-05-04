// hotel_image_model.dart
class HotelImage {
  final String url;
  final String id;

  HotelImage({required this.url, required this.id});

  factory HotelImage.fromJson(Map<String, dynamic> json) {
    return HotelImage(
      url: json['url'] as String,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'id': id,
    };
  }
}
