import 'package:equatable/equatable.dart';

import 'package:airplane/data/models/destination_model.dart';

class DestinationEntities extends Equatable {
  final String id;
  final String name;
  final String city;
  final String imageUrl;
  final double rating;
  final int price;

  const DestinationEntities({
    required this.id,
    this.name = '',
    this.city = '',
    this.imageUrl = '',
    this.rating = 0.0,
    this.price = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        city,
        imageUrl,
        rating,
        price,
      ];

  DestinationEntities copyWith({
    String? id,
    String? name,
    String? city,
    String? imageUrl,
    double? rating,
    int? price,
  }) {
    return DestinationEntities(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      price: price ?? this.price,
    );
  }

  DestinationModel toModel() => DestinationModel(
        id: id,
        name: name,
        city: city,
        imageUrl: imageUrl,
        rating: rating,
        price: price,
      );
}
