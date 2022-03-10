import 'dart:convert';

import 'package:airplane/data/models/destination_model.dart';
import 'package:airplane/data/models/transaction_model.dart';
import 'package:airplane/data/models/user_model.dart';
import 'package:airplane/domain/entities/transaction_entities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tTransactionModel = TransactionModel(
    id: '1',
    user: UserModel(
      id: '1',
      email: 'email@gmail.com',
      name: 'name',
      hobby: 'hobby',
      balance: 100,
    ),
    destination: DestinationModel(
      id: '1',
      name: "name",
      city: "city",
      imageUrl: "imageUrl",
      rating: 1.0,
      price: 1,
    ),
    amountOfTravelers: 1,
    selectedSeats: 'A1',
    insurance: true,
    refundable: true,
    vit: 0.5,
    price: 100,
    grandTotal: 100,
    createdAt: 1646795474440000,
  );

  test('should be a subclass of TransactionEntities', () {
    expect(tTransactionModel, isA<TransactionEntities>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('transaction.json'),
      );

      // act
      final result = TransactionModel.fromJson(tTransactionModel.id, jsonMap);

      // assert
      expect(result, tTransactionModel);
    });
  });

  group('toJson', () {
    test('should return a json map containing proper data', () async {
      // act
      final result = tTransactionModel.toJson();

      // assert
      final expectedMap = {
        "id": "1",
        "user": {
          "id": "1",
          "email": "email@gmail.com",
          "name": "name",
          "hobby": "hobby",
          "balance": 100
        },
        "destination": {
          "id": "1",
          "name": "name",
          "city": "city",
          "imageUrl": "imageUrl",
          "rating": 1.0,
          "price": 1
        },
        "amountOfTravelers": 1,
        "selectedSeats": "A1",
        "insurance": true,
        "refundable": true,
        "vit": 0.5,
        "price": 100,
        "grandTotal": 100,
        "createdAt": 1646795474440000
      };

      expect(result, expectedMap);
    });
  });
}
