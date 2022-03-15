import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user_entities.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> setUser({required UserEntities user});
  Future<Either<Failure, void>> updateUser({required UserEntities user});
  Future<Either<Failure, UserEntities>> getUserById({required String id});
}
