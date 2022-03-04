import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/transaction_model.dart';
import '../../services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void createTransaction({required TransactionModel transaction}) async {
    try {
      emit(TransactionLoading());
      await TransactionService().createTransaction(transaction: transaction);
      emit(const TransactionSuccess(transaction: []));
    } catch (e) {
      emit(TransactionFailed(errorMessage: e.toString()));
    }
  }

  void fetchTransactions() async {
    try {
      emit(TransactionLoading());
      final transactions = await TransactionService().fetchTransactions();
      final sortedTransaction =
          await sortedTransactionByDateTime(transaction: transactions);
      emit(TransactionSuccess(transaction: sortedTransaction));
    } catch (e) {
      emit(TransactionFailed(errorMessage: e.toString()));
    }
  }

  Future<List<TransactionModel>> sortedTransactionByDateTime({
    required List<TransactionModel> transaction,
  }) async {
    final sortedByDateTime = transaction
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return sortedByDateTime;
  }
}
