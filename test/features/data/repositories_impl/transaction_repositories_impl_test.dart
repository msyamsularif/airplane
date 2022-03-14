import 'package:airplane/core/values/values.dart';
import 'package:airplane/data/models/destination_model.dart';
import 'package:airplane/data/models/transaction_model.dart';
import 'package:airplane/data/models/user_model.dart';
import 'package:airplane/data/repositories_impl/transaction_repositories_impl.dart';
import 'package:airplane/domain/entities/transaction_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransactionDataSource mocDataSource;
  late TransactionRepositoryImpl repository;

  setUp(() {
    mocDataSource = MockTransactionDataSource();
    repository =
        TransactionRepositoryImpl(transactionDataSource: mocDataSource);
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
    tTransactionModel.copyWith(id: '2', user: tUserModel).toModel(),
    tTransactionModel.copyWith(id: '3', user: tUserModel).toModel(),
  ];

  group('create transaction', () {
    test(
      'should make a new transaction',
      () async {
        // act
        await repository.createTransaction(transaction: tTransactionModel);

        // assert
        verify(mocDataSource.createTransaction(transaction: tTransactionModel));
      },
    );

    test(
      'should return type throw',
      () async {
        // arrange
        when(mocDataSource.createTransaction(transaction: tTransactionModel))
            .thenThrow(Exception('error'));

        // act
        final result =
            repository.createTransaction(transaction: tTransactionModel);

        // assert
        verify(mocDataSource.createTransaction(transaction: tTransactionModel));
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });

  group('fetch transaction', () {
    final tUserId = tUserModel.id;
    test(
      'should fetch transaction data',
      () async {
        // arrange
        when(mocDataSource.fetchTransactions(userId: tUserId))
            .thenAnswer((_) async => tTransactionUserModelsList);

        // act
        final result = await repository.fetchTransactions(userId: tUserId);

        // assert
        verify(mocDataSource.fetchTransactions(userId: tUserId));
        expect(
          result,
          equals(ApiReturnValue<List<TransactionEntities>>(
            value: tTransactionUserModelsList,
          )),
        );
      },
    );

    test(
      'should return ApiReturnValue type throw',
      () async {
        // arrange
        when(mocDataSource.fetchTransactions(userId: tUserId))
            .thenThrow(Exception('error'));

        // act
        final result = await repository.fetchTransactions(userId: tUserId);

        // assert
        verify(mocDataSource.fetchTransactions(userId: tUserId));
        expect(
          result,
          equals(
            ApiReturnValue<List<TransactionEntities>>(
              message: Exception('error').toString(),
            ),
          ),
        );
      },
    );
  });
}
