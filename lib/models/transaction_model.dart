
import 'package:equatable/equatable.dart';

import 'destination_model.dart';

class TransactionModel extends Equatable {
  final String id;
  final DestinationModel destination;
  final int amountOfTravelers;
  final String selectedSeats;
  final bool insurance;
  final bool refundable;
  final double vit;
  final int price;
  final int grandTotal;

  const TransactionModel({
    this.id = '',
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
        id,
        destination,
        amountOfTravelers,
        selectedSeats,
        insurance,
        refundable,
        vit,
        price,
        grandTotal
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destination': destination.toJson(),
      'amountOfTravelers': amountOfTravelers,
      'selectedSeats': selectedSeats,
      'insurance': insurance,
      'refundable': refundable,
      'vit': vit,
      'price': price,
      'grandTotal': grandTotal,
    };
  }

  factory TransactionModel.fromJson(String id, Map<String, dynamic> map) {
    return TransactionModel(
      id: id,
      destination: DestinationModel.fromJson(
          map['destination']['id'], map['destination']),
      amountOfTravelers: map['amountOfTravelers']?.toInt() ?? 0,
      selectedSeats: map['selectedSeats'] ?? '',
      insurance: map['insurance'] ?? false,
      refundable: map['refundable'] ?? false,
      vit: map['vit']?.toDouble() ?? 0.0,
      price: map['price']?.toInt() ?? 0,
      grandTotal: map['grandTotal']?.toInt() ?? 0,
    );
  }
}
