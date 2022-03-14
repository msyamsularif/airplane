import 'dart:convert';

import 'package:airplane/data/datasource/transaction_data_source.dart';
import 'package:airplane/data/models/destination_model.dart';
import 'package:airplane/data/models/transaction_model.dart';
import 'package:airplane/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFirebaseFirestore instance;
  late MockCollectionReference mockCollectionRef;
  late MockDocumentReference mockDocumentRef;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQueryDocumentSnapshot mockQueryDocumentSnapshot;
  late TransactionDataSourceImpl dataSource;
  late String messageCollection;

  setUp(() {
    instance = MockFirebaseFirestore();
    mockCollectionRef = MockCollectionReference();
    mockDocumentRef = MockDocumentReference();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    dataSource =
        TransactionDataSourceImpl(transactionReference: mockCollectionRef);
    messageCollection = 'transactions';
  });

  const TransactionModel tTransactionModel = TransactionModel(
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

  const UserModel tUserModel = UserModel(
    id: '1',
    email: 'email@gmail.com',
    name: 'name',
    hobby: 'hobby',
    balance: 100,
  );

  final List<TransactionModel> tTransactionUserModelsList = [
    tTransactionModel.copyWith(id: '1', user: tUserModel).toModel(),
  ];

  group('create transaction', () {
    test(
      'should make a new transaction',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.add(any))
            .thenAnswer((_) async => mockDocumentRef);

        // act
        await dataSource.createTransaction(transaction: tTransactionModel);

        // assert
        verify(mockCollectionRef.add(any));
      },
    );

    test(
      'should return type throw',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.add(any)).thenThrow(Exception('error'));

        // act
        final result =
            dataSource.createTransaction(transaction: tTransactionModel);

        // assert
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });

  group('fetch transaction', () {
    test(
      'should fetch transaction data',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.get())
            .thenAnswer((_) async => mockQuerySnapshot);

        when(mockQuerySnapshot.docs)
            .thenAnswer((_) => [mockQueryDocumentSnapshot]);

        when(mockQueryDocumentSnapshot.id)
            .thenAnswer((_) => tTransactionUserModelsList[0].id);

        when(mockQueryDocumentSnapshot.data())
            .thenAnswer((_) => json.decode(fixture('transaction.json')));

        // act
        final result =
            await dataSource.fetchTransactions(userId: tTransactionModel.id);

        // assert
        expect(result, tTransactionUserModelsList);
      },
    );

    test(
      'should return type throw',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.get()).thenThrow(Exception('error'));

        // act
        final result = dataSource.fetchTransactions(
          userId: tTransactionModel.id,
        );

        // assert
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });
}
