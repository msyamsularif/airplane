import '../../core/values/values.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<ApiReturnValue<UserModel>> signIn({
    required String email,
    required String password,
  });
  Future<ApiReturnValue<UserModel>> signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  });
  Future<void> signOut();
}
