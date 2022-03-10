import 'package:airplane/data/datasource/auth_data_source.dart';
import 'package:airplane/data/datasource/destination_data_source.dart';
import 'package:airplane/data/datasource/transaction_data_source.dart';
import 'package:airplane/data/datasource/user_data_source.dart';
import 'package:airplane/domain/repositories/auth_repositories.dart';
import 'package:airplane/domain/repositories/destination_repositories.dart';
import 'package:airplane/domain/repositories/transaction_repositories.dart';
import 'package:airplane/domain/repositories/user_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  UserDataSource,
  AuthDataSource,
  DestinationDataSource,
  TransactionDataSource,
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
  FirebaseAuth,
  UserCredential,
  User,
  QuerySnapshot,
  AuthRepository,
  UserRepository,
  DestinationRepository,
  TransactionRepository,
], customMocks: [
  MockSpec<QueryDocumentSnapshot<Map>>(as: #MockQueryDocumentSnapshot),
])
void main() {}
