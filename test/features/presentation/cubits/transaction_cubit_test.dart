import 'package:airplane/core/values/values.dart';
import 'package:airplane/data/models/destination_model.dart';
import 'package:airplane/data/models/transaction_model.dart';
import 'package:airplane/data/models/user_model.dart';
import 'package:airplane/domain/entities/transaction_entities.dart';
import 'package:airplane/presentation/cubits/transaction/transaction_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransactionRepository mockTransactionRepository;
  late TransactionCubit transactionCubit;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    transactionCubit =
        TransactionCubit(transactionRepository: mockTransactionRepository);
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

  final List<TransactionModel> tListTransactionModel = [
    tTransactionModel,
    tTransactionModel.copyWith(createdAt: 1646886760853000).toModel(),
    tTransactionModel.copyWith(createdAt: 1646886790187000).toModel(),
  ];

  test('initial state should be empty', () {
    expect(transactionCubit.state, TransactionInitial());
  });

  group('create transaction in cubit', () {
    blocTest<TransactionCubit, TransactionState>(
      'should emits [TransactionLoading, TransactionSuccess] when data is gotten successfully.',
      build: () => transactionCubit,
      act: (bloc) => bloc.createTransaction(transaction: tTransactionModel),
      expect: () => <TransactionState>[
        TransactionLoading(),
        const TransactionSuccess(transaction: []),
      ],
      verify: (bloc) {
        verify(mockTransactionRepository.createTransaction(
          transaction: tTransactionModel,
        ));
      },
    );

    blocTest<TransactionCubit, TransactionState>(
      'should emits [TransactionFailed] when get data is unsuccessful.',
      build: () {
        when(mockTransactionRepository.createTransaction(
          transaction: tTransactionModel,
        )).thenThrow(Exception('error'));

        return transactionCubit;
      },
      act: (bloc) => bloc.createTransaction(transaction: tTransactionModel),
      expect: () => <TransactionState>[
        TransactionLoading(),
        TransactionFailed(errorMessage: Exception('error').toString()),
      ],
    );
  });

  group('fetch transaction', () {
    blocTest<TransactionCubit, TransactionState>(
      'should emits [TransactionLoading, TransactionSuccess] when data is gotten successfully.',
      build: () {
        when(mockTransactionRepository.fetchTransactions(
          userId: tTransactionModel.user.id,
        )).thenAnswer(
            (_) async => ApiReturnValue(value: tListTransactionModel));

        return transactionCubit;
      },
      act: (bloc) => bloc.fetchTransactions(userId: tTransactionModel.user.id),
      expect: () => <TransactionState>[
        TransactionLoading(),
        TransactionSuccess(transaction: tListTransactionModel),
      ],
      verify: (bloc) {
        verify(mockTransactionRepository.fetchTransactions(
          userId: tTransactionModel.user.id,
        ));
      },
    );

    blocTest<TransactionCubit, TransactionState>(
      'should emits [TransactionFailed] when get data is unsuccessful.',
      build: () {
        when(mockTransactionRepository.fetchTransactions(
          userId: tTransactionModel.user.id,
        )).thenThrow(Exception('error'));

        return transactionCubit;
      },
      act: (bloc) => bloc.fetchTransactions(userId: tTransactionModel.user.id),
      expect: () => <TransactionState>[
        TransactionLoading(),
        TransactionFailed(errorMessage: Exception('error').toString()),
      ],
    );
  });

  test(
    'should return List<Transaction> with sorted transaction by createdAt',
    () async {
      // act
      final List<TransactionEntities> result = await transactionCubit
          .sortedTransactionByDateTime(transaction: tListTransactionModel);

      // assert
      expect(result, [
        tTransactionModel.copyWith(createdAt: 1646886790187000).toModel(),
        tTransactionModel.copyWith(createdAt: 1646886760853000).toModel(),
        tTransactionModel,
      ]);
    },
  );
}
