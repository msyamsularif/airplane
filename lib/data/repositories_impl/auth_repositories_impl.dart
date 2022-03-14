import '../../core/values/values.dart';
import '../../domain/entities/user_entities.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../datasource/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });

  @override
  Future<ApiReturnValue<UserEntities>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final valueSignIn =
          await authDataSource.signIn(email: email, password: password);
      return ApiReturnValue(value: valueSignIn.toEntity());
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await authDataSource.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiReturnValue<UserEntities>> signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  }) async {
    try {
      final valueSignUp = await authDataSource.signUp(
        email: email,
        password: password,
        name: name,
        hobby: hobby,
      );
      return ApiReturnValue(value: valueSignUp.toEntity());
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }
}
