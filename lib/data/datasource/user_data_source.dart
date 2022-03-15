import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<void> setUser({required UserModel user});
  Future<void> updateUser({required UserModel user});
  Future<UserModel> getUserById({required String id});
}

class UserDataSourceImpl implements UserDataSource {
  final CollectionReference userReference;

  UserDataSourceImpl({
    required this.userReference,
  });

  @override
  Future<UserModel> getUserById({required String id}) async {
    try {
      DocumentSnapshot snapshot = await userReference.doc(id).get();
      final userMap = snapshot.data() as Map<String, dynamic>;
      final user = UserModel.fromJson(id, userMap);

      return user;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> setUser({required UserModel user}) async {
    try {
      userReference.doc(user.id).set(user.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateUser({required UserModel user}) async {
    try {
      await userReference.doc(user.id).update(user.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
