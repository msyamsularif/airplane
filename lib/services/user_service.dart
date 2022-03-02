import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser({required UserModel user}) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'hobby': user.hobby,
        'balance': user.balance
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById({required String id}) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
        name: snapshot['name'],
        hobby: snapshot['hobby'],
        balance: snapshot['balance'],
      );
    } catch (e) {
      rethrow;
    }
  }
}
