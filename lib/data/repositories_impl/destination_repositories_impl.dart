import '../../core/values/values.dart';
import '../../domain/entities/destination_entities.dart';
import '../../domain/repositories/destination_repositories.dart';
import '../datasource/destination_data_source.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final DestinationDataSource destinationDataSource;

  DestinationRepositoryImpl({
    required this.destinationDataSource,
  });

  @override
  Future<ApiReturnValue<List<DestinationEntities>>> fetchDestinations() async {
    try {
      final valueDestination = await destinationDataSource.fetchDestinations();
      return ApiReturnValue(value: valueDestination);
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }
}
