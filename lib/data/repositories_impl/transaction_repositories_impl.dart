import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/transaction_entities.dart';
import '../../domain/repositories/transaction_repositories.dart';
import '../datasource/transaction_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDataSource transactionDataSource;

  TransactionRepositoryImpl({
    required this.transactionDataSource,
  });

  @override
  Future<Either<Failure, void>> createTransaction(
      {required TransactionEntities transaction}) async {
    try {
      await transactionDataSource.createTransaction(
        transaction: transaction.toModel(),
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntities>>> fetchTransactions({
    required String userId,
  }) async {
    try {
      final valueTransaction = await transactionDataSource.fetchTransactions(
        userId: userId,
      );
      return Right(valueTransaction);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
