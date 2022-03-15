import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user_entities.dart';
import '../../domain/repositories/user_repositories.dart';
import '../datasource/user_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({
    required this.userDataSource,
  });

  @override
  Future<Either<Failure, UserEntities>> getUserById({
    required String id,
  }) async {
    try {
      final valueGetUser = await userDataSource.getUserById(id: id);
      return Right(valueGetUser);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> setUser({required UserEntities user}) async {
    try {
      final resultUser = UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        hobby: user.hobby,
        balance: user.balance,
      );

      await userDataSource.setUser(user: resultUser);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser({required UserEntities user}) async {
    try {
      final resultUser = UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        hobby: user.hobby,
        balance: user.balance,
      );

      await userDataSource.updateUser(user: resultUser);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
