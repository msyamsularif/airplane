import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/transaction_model.dart';

class TransactionService {
  final CollectionReference _transactionReference =
      FirebaseFirestore.instance.collection('transactions');

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> createTransaction(
      {required TransactionModel transaction}) async {
    try {
      _transactionReference.add({
        'user': transaction.user.toJson(),
        'destination': transaction.destination.toJson(),
        'amountOfTravelers': transaction.amountOfTravelers,
        'selectedSeats': transaction.selectedSeats,
        'insurance': transaction.insurance,
        'refundable': transaction.refundable,
        'vit': transaction.vit,
        'price': transaction.price,
        'grandTotal': transaction.grandTotal,
        'createdAt': DateTime.now().microsecondsSinceEpoch,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    try {
      if (user == null) throw 'User no authenticated';

      QuerySnapshot result = await _transactionReference.get();

      List<TransactionModel> transactions = result.docs
          .map(
            (e) => TransactionModel.fromJson(
                e.id, e.data() as Map<String, dynamic>),
          )
          .toList();

      final filterTransaction = transactions
          .where((element) => element.user.id == user!.uid)
          .toList();

      return filterTransaction;
    } catch (e) {
      rethrow;
    }
  }
}
