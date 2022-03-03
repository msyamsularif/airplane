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
      emit(TransactionSuccess(transaction: transactions));
    } catch (e) {
      emit(TransactionFailed(errorMessage: e.toString()));
    }
  }
}