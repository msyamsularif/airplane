import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/transaction_entities.dart';
import '../../../domain/repositories/transaction_repositories.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository _transactionRepository;

  TransactionCubit({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository,
        super(TransactionInitial());

  void createTransaction({required TransactionEntities transaction}) async {
    emit(TransactionLoading());
    final transactionOrFailure = await _transactionRepository.createTransaction(
      transaction: transaction,
    );

    transactionOrFailure.fold(
        (failure) => emit(
              TransactionFailed(errorMessage: failure.failureMessage()),
            ),
        (_) => emit(const TransactionSuccess(transaction: [])));
  }

  void fetchTransactions({required String userId}) async {
    emit(TransactionLoading());

    final transactionsOrFailure =
        await _transactionRepository.fetchTransactions(userId: userId);

    transactionsOrFailure.fold(
      (failure) => emit(
        TransactionFailed(errorMessage: failure.failureMessage()),
      ),
      (transactions) async {
        final sortedTransaction = await sortedTransactionByDateTime(
          transaction: transactions,
        );
        return emit(TransactionSuccess(transaction: sortedTransaction));
      },
    );
  }

  Future<List<TransactionEntities>> sortedTransactionByDateTime({
    required List<TransactionEntities> transaction,
  }) async {
    final sortedByDateTime = transaction
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return sortedByDateTime;
  }
}
