import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import 'user_data_source.dart';

abstract class AuthDataSource {
  Future<UserModel> signIn({
    required String email,
    required String password,
  });
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  });
  Future<void> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final UserDataSource userDataSource;

  AuthDataSourceImpl({
    required this.firebaseAuth,
    required this.userDataSource,
  });

  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user =
          await userDataSource.getUserById(id: userCredential.user!.uid);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  }) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        hobby: hobby,
        balance: 280000000,
      );

      await userDataSource.setUser(user: user);

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
