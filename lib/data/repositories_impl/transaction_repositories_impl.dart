import '../../core/values/values.dart';
import '../../domain/entities/transaction_entities.dart';
import '../../domain/repositories/transaction_repositories.dart';
import '../datasource/transaction_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDataSource transactionDataSource;

  TransactionRepositoryImpl({
    required this.transactionDataSource,
  });

  @override
  Future<void> createTransaction(
      {required TransactionEntities transaction}) async {
    try {
      await transactionDataSource.createTransaction(
        transaction: transaction.toModel(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiReturnValue<List<TransactionEntities>>> fetchTransactions({
    required String userId,
  }) async {
    try {
      final valueTransaction = await transactionDataSource.fetchTransactions(
        userId: userId,
      );
      return ApiReturnValue(value: valueTransaction);
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }
}
