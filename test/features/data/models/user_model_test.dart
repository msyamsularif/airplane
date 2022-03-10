import 'dart:convert';

import 'package:airplane/data/models/user_model.dart';
import 'package:airplane/domain/entities/user_entities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
    id: '1',
    email: 'email@gmail.com',
    name: "name",
    hobby: "hobby",
    balance: 100,
  );

  test('should be a subclass of UserEntities', () {
    expect(tUserModel, isA<UserEntities>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('user.json'),
      );

      // act
      final result = UserModel.fromJson(tUserModel.id, jsonMap);

      // assert
      expect(result, tUserModel);
    });
  });

  group('toJson', () {
    test('should return a json map containing proper data', () async {
      // act
      final result = tUserModel.toJson();

      // assert
      final expectedMap = {
        "id": tUserModel.id,
        "email": tUserModel.email,
        "name": tUserModel.name,
        "hobby": tUserModel.hobby,
        "balance": tUserModel.balance,
      };
      
      expect(result, expectedMap);
    });
  });
}
