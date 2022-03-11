import 'package:airplane/data/models/destination_model.dart';
import 'package:airplane/data/models/transaction_model.dart';
import 'package:airplane/data/models/user_model.dart';

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
      final user = UserModel(
        id: transaction.user.id,
        email: transaction.user.email,
        name: transaction.user.name,
        hobby: transaction.user.hobby,
        balance: transaction.user.balance,
      );

      final destination = DestinationModel(
        id: transaction.destination.id,
        name: transaction.destination.name,
        city: transaction.destination.city,
        imageUrl: transaction.destination.imageUrl,
        rating: transaction.destination.rating,
        price: transaction.destination.price,
      );

      final resultTransaction = TransactionModel(
        id: transaction.id,
        user: user,
        destination: destination,
        amountOfTravelers: transaction.amountOfTravelers,
        selectedSeats: transaction.selectedSeats,
        price: transaction.price,
        insurance: transaction.insurance,
        refundable: transaction.refundable,
        vit: transaction.vit,
        grandTotal: transaction.grandTotal,
        createdAt: transaction.createdAt,
      );

      await transactionDataSource.createTransaction(
        transaction: resultTransaction,
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
