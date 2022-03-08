import '../../core/values/values.dart';
import '../../domain/repositories/transaction_repositories.dart';
import '../datasource/transaction_data_source.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDataSource transactionDataSource;

  TransactionRepositoryImpl({
    required this.transactionDataSource,
  });

  @override
  Future<void> createTransaction(
      {required TransactionModel transaction}) async {
    try {
      await transactionDataSource.createTransaction(transaction: transaction);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiReturnValue<List<TransactionModel>>> fetchTransactions({
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
