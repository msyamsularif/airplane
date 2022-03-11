import '../../core/values/values.dart';
import '../entities/user_entities.dart';

abstract class UserRepository {
  Future<void> setUser({required UserEntities user});
  Future<void> updateUser({required UserEntities user});
  Future<ApiReturnValue<UserEntities>> getUserById({required String id});
}
