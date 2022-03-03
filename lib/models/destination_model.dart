
import 'package:equatable/equatable.dart';

class DestinationModel extends Equatable {
  final String id;
  final String name;
  final String city;
  final String imageUrl;
  final double rating;
  final int price;

  const DestinationModel({
    required this.id,
    this.name = '',
    this.city = '',
    this.imageUrl = '',
    this.rating = 0.0,
    this.price = 0,
  });

  @override
  List<Object?> get props => [id, name, city, imageUrl, rating, price];

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
}
