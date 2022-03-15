import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/destination_entities.dart';
import '../../domain/repositories/destination_repositories.dart';
import '../datasource/destination_data_source.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final DestinationDataSource destinationDataSource;

  DestinationRepositoryImpl({
    required this.destinationDataSource,
  });

  @override
  Future<Either<Failure, List<DestinationEntities>>> fetchDestinations() async {
    try {
      final valueDestination = await destinationDataSource.fetchDestinations();
      return Right(valueDestination);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
