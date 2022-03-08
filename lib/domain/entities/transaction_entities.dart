import 'package:equatable/equatable.dart';

import '../../data/models/destination_model.dart';
import '../../data/models/user_model.dart';

class TransactionEntities extends Equatable {
  final String id;
  final UserModel user;
  final DestinationModel destination;
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
}
