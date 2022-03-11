import 'package:equatable/equatable.dart';

import 'destination_entities.dart';
import 'user_entities.dart';

class TransactionEntities extends Equatable {
  final String id;
  final UserEntities user;
  final DestinationEntities destination;
  final int amountOfTravelers;
  final String selectedSeats;
  final bool insurance;
  final bool refundable;
  final double vit;
  final int price;
  final int grandTotal;
  final int? createdAt;

  const TransactionEntities({
    this.id = '',
    required this.user,
    required this.destination,
    this.amountOfTravelers = 0,
    this.selectedSeats = '',
    this.insurance = false,
    this.refundable = false,
    this.vit = 0.0,
    this.price = 0,
    this.grandTotal = 0,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        destination,
        amountOfTravelers,
        selectedSeats,
        insurance,
        refundable,
        vit,
        price,
        grandTotal,
        createdAt,
      ];

  TransactionEntities copyWith({
    String? id,
    UserEntities? user,
    DestinationEntities? destination,
    int? amountOfTravelers,
    String? selectedSeats,
    bool? insurance,
    bool? refundable,
    double? vit,
    int? price,
    int? grandTotal,
    int? createdAt,
  }) {
    return TransactionEntities(
      id: id ?? this.id,
      user: user ?? this.user,
      destination: destination ?? this.destination,
      amountOfTravelers: amountOfTravelers ?? this.amountOfTravelers,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      insurance: insurance ?? this.insurance,
      refundable: refundable ?? this.refundable,
      vit: vit ?? this.vit,
      price: price ?? this.price,
      grandTotal: grandTotal ?? this.grandTotal,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
