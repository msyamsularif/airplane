import '../../core/values/values.dart';
import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<void> setUser({required UserModel user});
  Future<void> updateUser({required UserModel user});
  Future<ApiReturnValue<UserModel>> getUserById({required String id});
}
