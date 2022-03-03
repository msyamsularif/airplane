import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transaction_model.dart';

class TransactionService {
  final CollectionReference _transactionReference =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> createTransaction(
      {required TransactionModel transaction}) async {
    try {
      _transactionReference.add({
        'destination': transaction.destination.toJson(),
        'amountOfTravelers': transaction.amountOfTravelers,
        'selectedSeats': transaction.selectedSeats,
        'insurance': transaction.insurance,
        'refundable': transaction.refundable,
        'vit': transaction.vit,
        'price': transaction.price,
        'grandTotal': transaction.grandTotal,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    try {
      QuerySnapshot result = await _transactionReference.get();

      List<TransactionModel> transactions = result.docs
          .map(
            (e) => TransactionModel.fromJson(
                e.id, e.data() as Map<String, dynamic>),
          )
          .toList();

      return transactions;
    } catch (e) {
      rethrow;
    }
  }
}
