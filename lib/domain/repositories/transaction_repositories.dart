import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/transaction_entities.dart';

abstract class TransactionRepository {
  Future<Either<Failure, void>> createTransaction({
    required TransactionEntities transaction,
  });
  Future<Either<Failure, List<TransactionEntities>>> fetchTransactions({
    required String userId,
  });
}
