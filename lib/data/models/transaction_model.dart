import 'package:airplane/domain/entities/destination_entities.dart';
import 'package:airplane/domain/entities/user_entities.dart';

import '../../domain/entities/transaction_entities.dart';
import 'destination_model.dart';
import 'user_model.dart';

class TransactionModel extends TransactionEntities {
  final UserModel user;
  final DestinationModel destination;
  const TransactionModel({
    String id = '',
    required this.user,
    required this.destination,
    int amountOfTravelers = 0,
    String selectedSeats = '',
    bool insurance = false,
    bool refundable = false,
    double vit = 0.0,
    int price = 0,
    int grandTotal = 0,
    int? createdAt,
  }) : super(
          id: id,
          user: user,
          destination: destination,
          amountOfTravelers: amountOfTravelers,
          selectedSeats: selectedSeats,
          insurance: insurance,
          refundable: refundable,
          vit: vit,
          price: price,
          grandTotal: grandTotal,
          createdAt: createdAt,
        );

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

  @override
  TransactionModel copyWith({
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
    final UserModel? userModel = UserModel(
      id: user!.id,
      email: user.email,
      name: user.name,
      hobby: user.hobby,
      balance: user.balance,
    );

    final DestinationModel? destinationModel = DestinationModel(
      id: destination!.id,
      name: destination.name,
      city: destination.city,
      imageUrl: destination.imageUrl,
      rating: destination.rating,
      price: destination.price,
    );

    return TransactionModel(
      id: id ?? this.id,
      user: userModel ?? this.user,
      destination: destinationModel ?? this.destination,
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
