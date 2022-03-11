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
    try {
      emit(TransactionLoading());
      await _transactionRepository.createTransaction(transaction: transaction);
      emit(const TransactionSuccess(transaction: []));
    } catch (e) {
      emit(TransactionFailed(errorMessage: e.toString()));
    }
  }

  void fetchTransactions({required String userId}) async {
    try {
      emit(TransactionLoading());

      final transactions =
          await _transactionRepository.fetchTransactions(userId: userId);
      final sortedTransaction = await sortedTransactionByDateTime(
        transaction: transactions.value!,
      );

      emit(TransactionSuccess(transaction: sortedTransaction));
    } catch (e) {
      emit(TransactionFailed(errorMessage: e.toString()));
    }
  }

  Future<List<TransactionEntities>> sortedTransactionByDateTime({
    required List<TransactionEntities> transaction,
  }) async {
    final sortedByDateTime = transaction
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return sortedByDateTime;
  }
}
