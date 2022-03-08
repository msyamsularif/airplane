import '../../core/values/values.dart';
import '../../domain/repositories/user_repositories.dart';
import '../datasource/user_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({
    required this.userDataSource,
  });

  @override
  Future<ApiReturnValue<UserModel>> getUserById({required String id}) async {
    try {
      final valueGetUser = await userDataSource.getUserById(id: id);
      return ApiReturnValue(value: valueGetUser);
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  @override
  Future<void> setUser({required UserModel user}) async {
    try {
      await userDataSource.setUser(user: user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser({required UserModel user}) async {
    try {
      await userDataSource.updateUser(user: user);
    } catch (e) {
      rethrow;
    }
  }
}
