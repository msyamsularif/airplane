import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser({required UserModel user}) async {
    try {
      _userReference.doc(user.id).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser({required UserModel user}) async {
    try {
      await _userReference.doc(user.id).update(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById({required String id}) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      final userMap = snapshot.data() as Map<String, dynamic>;
      final user = UserModel.fromJson(id, userMap);

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
