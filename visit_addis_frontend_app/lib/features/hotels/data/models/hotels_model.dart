// // hotels_model.dart
// import '../models/image_model.dart'; // Import the HotelImage model

// class Restaurant {
//   final String? name;
//   final String? location;
//   final String? contact;
//   final String? description;
//   final List<HotelImage>? images; // List of HotelImage objects
//   // final List<String> menu;
//   final double? averageRating;
//   final String id;

//   Restaurant({
//     required this.name,
//     required this.location,
//     required this.contact,
//     required this.description,
//     required this.images,
//     // required this.menu,
//     required this.averageRating,
//     required this.id,
//   });

//   factory Restaurant.fromJson(Map<String, dynamic> json) {
//     return Restaurant(
//       name: json['name'] as String?,
//       location: json['location'] as String?,
//       contact: json['contact'] as String?,
//       description: json['description'] as String?,
//       images: (json['images'] as List<dynamic>?)
//           ?.map((imageJson) =>
//               HotelImage.fromJson(imageJson as Map<String, dynamic>))
//           .toList(),
//       // menu: (json['menu'] as List<dynamic>?)
//       //         ?.map((item) => item.toString())
//       //         .toList() ??
//       //     [],
//       averageRating: (json['averageRating'] as num).toDouble(),
//       id: json['id'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'location': location,
//       'contact': contact,
//       'description': description,
//       'images': images?.map((image) => image.toJson()).toList(),
//       // 'menu': menu,
//       'averageRating': averageRating,
//       'id': id,
//     };
//   }
// }

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

class Restaurant {
  final String? name;
  final String? location;
  final String? description;
  final List<HotelImage>? images;
  final String id;

  Restaurant({
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.id,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'] as String?,
      location: json['location'] as String?,
      description: json['description'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((imageJson) =>
              HotelImage.fromJson(imageJson as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'description': description,
      'images': images?.map((image) => image.toJson()).toList(),
      'id': id,
    };
  }
}
