import 'package:airplane/data/models/user_model.dart';

import '../../core/values/values.dart';
import '../../domain/entities/user_entities.dart';
import '../../domain/repositories/user_repositories.dart';
import '../datasource/user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({
    required this.userDataSource,
  });

  @override
  Future<ApiReturnValue<UserEntities>> getUserById({required String id}) async {
    try {
      final valueGetUser = await userDataSource.getUserById(id: id);
      return ApiReturnValue(value: valueGetUser);
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  @override
  Future<void> setUser({required UserEntities user}) async {
    try {
      final resultUser = UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        hobby: user.hobby,
        balance: user.balance,
      );

      await userDataSource.setUser(user: resultUser);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser({required UserEntities user}) async {
    try {
      final resultUser = UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        hobby: user.hobby,
        balance: user.balance,
      );

      await userDataSource.updateUser(user: resultUser);
    } catch (e) {
      rethrow;
    }
  }
}
