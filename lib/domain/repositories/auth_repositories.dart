import '../../core/values/values.dart';
import '../entities/user_entities.dart';

abstract class AuthRepository {
  Future<ApiReturnValue<UserEntities>> signIn({
    required String email,
    required String password,
  });
  Future<ApiReturnValue<UserEntities>> signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  });
  Future<void> signOut();
}
