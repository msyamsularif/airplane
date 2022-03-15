import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user_entities.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntities>> signIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntities>> signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  });
  Future<Either<Failure, void>> signOut();
}
