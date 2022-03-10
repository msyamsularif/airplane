import 'dart:convert';

import 'package:airplane/data/models/destination_model.dart';
import 'package:airplane/domain/entities/destination_entities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tDestinationModel = DestinationModel(
    id: '1',
    name: 'name',
    city: 'city',
    imageUrl: 'imageUrl',
    rating: 1.0,
    price: 1,
  );

  test('should be a subclass of DestinationEntities', () {
    expect(tDestinationModel, isA<DestinationEntities>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('destination.json'),
      );

      // act
      final result = DestinationModel.fromJson(tDestinationModel.id, jsonMap);

      // assert
      expect(result, tDestinationModel);
    });
  });

  group('toJson', () {
    test('should return a json map containing proper data', () async {
      // act
      final result = tDestinationModel.toJson();

      // assert
      final expectedMap = {
        "id": "1",
        "name": "name",
        "city": "city",
        "imageUrl": "imageUrl",
        "rating": 1.0,
        "price": 1
      };

      expect(result, expectedMap);
    });
  });
}
