import '../../core/values/values.dart';
import '../entities/transaction_entities.dart';

abstract class TransactionRepository {
  Future<void> createTransaction({
    required TransactionEntities transaction,
  });
  Future<ApiReturnValue<List<TransactionEntities>>> fetchTransactions({
    required String userId,
  });
}
