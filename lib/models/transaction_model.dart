import 'package:equatable/equatable.dart';

import 'destination_model.dart';

class TransactionModel extends Equatable {
  final DestinationModel destination;
  final int amountOfTravelers;
  final String selectedSeats;
  final bool insurance;
  final bool refundable;
  final double vit;
  final int price;
  final int grandTotal;

  const TransactionModel({
    required this.destination,
    this.amountOfTravelers = 0,
    this.selectedSeats = '',
    this.insurance = false,
    this.refundable = false,
    this.vit = 0.0,
    this.price = 0,
    this.grandTotal = 0,
  });

  @override
  List<Object?> get props => [
        destination,
        amountOfTravelers,
        selectedSeats,
        insurance,
        refundable,
        vit,
        price,
        grandTotal
      ];
}
