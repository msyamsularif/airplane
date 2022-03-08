import '../../core/values/values.dart';
import '../../data/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<void> createTransaction({
    required TransactionModel transaction,
  });
  Future<ApiReturnValue<List<TransactionModel>>> fetchTransactions({
    required String userId,
  });
}
