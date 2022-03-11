import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transaction_model.dart';

abstract class TransactionDataSource {
  Future<void> createTransaction({
    required TransactionModel transaction,
  });
  Future<List<TransactionModel>> fetchTransactions({required String userId});
}

class TransactionDataSourceImpl implements TransactionDataSource {
  final CollectionReference transactionReference;

  TransactionDataSourceImpl({
    required this.transactionReference,
  });

  @override
  Future<void> createTransaction({
    required TransactionModel transaction,
  }) async {
    try {
      await transactionReference.add(transaction.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TransactionModel>> fetchTransactions({
    required String userId,
  }) async {
    try {
      QuerySnapshot result = await transactionReference.get();

      List<TransactionModel> transactions = result.docs
          .map(
            (e) => TransactionModel.fromJson(
                e.id, e.data() as Map<String, dynamic>),
          )
          .toList();

      final filterTransaction =
          transactions.where((element) => element.user.id == userId).toList();

      return filterTransaction;
    } catch (e) {
      rethrow;
    }
  }
}
