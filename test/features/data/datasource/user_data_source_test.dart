import 'dart:convert';

import 'package:airplane/data/datasource/user_data_source.dart';
import 'package:airplane/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFirebaseFirestore instance;
  late MockCollectionReference mockCollectionRef;
  late MockDocumentReference mockDocumentRef;
  late MockDocumentSnapshot mockDocumentSnapshot;
  late UserDataSourceImpl dataSource;
  late String messageCollection;

  setUp(() {
    instance = MockFirebaseFirestore();
    mockCollectionRef = MockCollectionReference();
    mockDocumentRef = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
    dataSource = UserDataSourceImpl(userReference: mockCollectionRef);
    messageCollection = 'users';
  });

  const UserModel tUserModel = UserModel(
    id: '1',
    email: 'email@gmail.com',
    name: 'name',
    hobby: 'hobby',
    balance: 100,
  );

  group('get user by id', () {
    final tUserId = tUserModel.id;
    test(
      'should return ApiReturnValue type User Model',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.doc(tUserId)).thenAnswer((_) => mockDocumentRef);

        when(mockDocumentRef.get())
            .thenAnswer((_) async => mockDocumentSnapshot);

        when(mockDocumentSnapshot.data()).thenReturn(
          jsonDecode(fixture('user.json')),
        );

        // act
        final result = await dataSource.getUserById(id: tUserId);

        // assert
        expect(result, equals(tUserModel));
      },
    );
    test(
      'should return type throw',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.doc(tUserId)).thenAnswer((_) => mockDocumentRef);

        when(mockDocumentRef.get())
            .thenAnswer((_) async => mockDocumentSnapshot);

        when(mockDocumentSnapshot.data()).thenThrow(Exception('error'));

        // act
        final result = dataSource.getUserById(id: tUserId);

        // assert
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });

  group('set user', () {
    test(
      'should be able to add data to the database',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.doc(tUserModel.id))
            .thenAnswer((_) => mockDocumentRef);

        when(mockDocumentRef.set(tUserModel.toJson()))
            .thenAnswer((_) async => mockDocumentSnapshot);

        // act
        await dataSource.setUser(user: tUserModel);

        // expect
        verify(mockCollectionRef.doc(tUserModel.id));
        verify(mockDocumentRef.set(tUserModel.toJson()));
      },
    );

    test(
      'should return type throw',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.doc(tUserModel.id))
            .thenAnswer((_) => mockDocumentRef);

        when(mockDocumentRef.set(tUserModel.toJson()))
            .thenThrow(Exception('error'));

        // act
        final result = dataSource.setUser(user: tUserModel);

        // assert
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });

  group('update user', () {
    test(
      'should can make data changes',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.doc(tUserModel.id))
            .thenAnswer((_) => mockDocumentRef);

        when(mockDocumentRef.update(tUserModel.toJson()))
            .thenAnswer((_) async => mockDocumentSnapshot);

        // act
        await dataSource.updateUser(user: tUserModel);

        // expect
        verify(mockCollectionRef.doc(tUserModel.id));
        verify(mockDocumentRef.update(tUserModel.toJson()));
      },
    );

    test(
      'should return type throw',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.doc(tUserModel.id))
            .thenAnswer((_) => mockDocumentRef);

        when(mockDocumentRef.update(tUserModel.toJson()))
            .thenThrow(Exception('error'));

        // act
        final result = dataSource.updateUser(user: tUserModel);

        // assert
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });
}
