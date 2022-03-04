import 'package:equatable/equatable.dart';

import 'destination_model.dart';
import 'user_model.dart';

class TransactionModel extends Equatable {
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

  const TransactionModel({
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'destination': destination.toJson(),
      'amountOfTravelers': amountOfTravelers,
      'selectedSeats': selectedSeats,
      'insurance': insurance,
      'refundable': refundable,
      'vit': vit,
      'price': price,
      'grandTotal': grandTotal,
      'createdAt': createdAt,
    };
  }

  factory TransactionModel.fromJson(String id, Map<String, dynamic> map) {
    return TransactionModel(
      id: id,
      user: UserModel.fromJson(map['user']['id'], map['user']),
      destination: DestinationModel.fromJson(
        map['destination']['id'],
        map['destination'],
      ),
      amountOfTravelers: map['amountOfTravelers']?.toInt() ?? 0,
      selectedSeats: map['selectedSeats'] ?? '',
      insurance: map['insurance'] ?? false,
      refundable: map['refundable'] ?? false,
      vit: map['vit']?.toDouble() ?? 0.0,
      price: map['price']?.toInt() ?? 0,
      grandTotal: map['grandTotal']?.toInt() ?? 0,
      createdAt:
          map['createdAt']?.toInt() ?? DateTime.now().microsecondsSinceEpoch,
    );
  }

  TransactionModel copyWith({
    String? id,
    UserModel? user,
    DestinationModel? destination,
    int? amountOfTravelers,
    String? selectedSeats,
    bool? insurance,
    bool? refundable,
    double? vit,
    int? price,
    int? grandTotal,
    int? createdAt,
  }) {
    return TransactionModel(
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
