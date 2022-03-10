import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  static String destiantionCollection = "destinations";
  static String transactionCollection = "transactions";
  static String userCollection = "users";

  static FirebaseAuth instanceAuth = FirebaseAuth.instance;
  static FirebaseFirestore instanceFirestore = FirebaseFirestore.instance;

  // static CollectionReference destinationReference =
  //     FirebaseFirestore.instance.collection('destinations');

  // static CollectionReference transactionReference =
  //     FirebaseFirestore.instance.collection('transactions');

  // static CollectionReference userReference =
  //     FirebaseFirestore.instance.collection('users');
}
