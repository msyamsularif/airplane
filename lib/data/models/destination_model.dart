import '../../domain/entities/destination_entities.dart';

class DestinationModel extends DestinationEntities {
  const DestinationModel({
    required String id,
    String name = '',
    String city = '',
    String imageUrl = '',
    double rating = 0.0,
    int price = 0,
  }) : super(
          id: id,
          name: name,
          city: city,
          imageUrl: imageUrl,
          rating: rating,
          price: price,
        );

  @override
  List<Object?> get props => [id, name, city, imageUrl, rating, price];

  DestinationEntities toEntity() => DestinationEntities(
        id: id,
        name: name,
        city: city,
        imageUrl: imageUrl,
        rating: rating,
        price: price,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'imageUrl': imageUrl,
      'rating': rating,
      'price': price,
    };
  }

  factory DestinationModel.fromJson(String id, Map<String, dynamic> map) {
    return DestinationModel(
      id: id,
      name: map['name'] ?? '',
      city: map['city'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      price: map['price']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'DestinationEntities(id: $id, name: $name, city: $city, imageUrl: $imageUrl, rating: $rating, price: $price)';
  }
}
