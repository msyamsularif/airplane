import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/destination_entities.dart';

abstract class DestinationRepository {
  Future<Either<Failure, List<DestinationEntities>>> fetchDestinations();
}
