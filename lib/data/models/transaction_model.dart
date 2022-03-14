import '../../domain/entities/transaction_entities.dart';
import 'destination_model.dart';
import 'user_model.dart';

class TransactionModel extends TransactionEntities {
  const TransactionModel({
    String id = '',
    required UserModel user,
    required DestinationModel destination,
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

  TransactionEntities toEntity() => TransactionEntities(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toModel().toJson(),
      'destination': destination.toModel().toJson(),
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
  String toString() {
    return 'TransactionEntities(id: $id, user: $user, destination: $destination, amountOfTravelers: $amountOfTravelers, selectedSeats: $selectedSeats, insurance: $insurance, refundable: $refundable, vit: $vit, price: $price, grandTotal: $grandTotal, createdAt: $createdAt)';
  }
}
