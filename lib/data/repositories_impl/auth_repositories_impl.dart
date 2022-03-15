import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user_entities.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../datasource/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });

  @override
  Future<Either<Failure, UserEntities>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final valueSignIn =
          await authDataSource.signIn(email: email, password: password);
      return Right(valueSignIn.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final valueSignOut = await authDataSource.signOut();
      return Right(valueSignOut);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntities>> signUp({
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
      return Right(valueSignUp.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
