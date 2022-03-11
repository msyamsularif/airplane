import '../../core/values/values.dart';
import '../entities/destination_entities.dart';

abstract class DestinationRepository {
  Future<ApiReturnValue<List<DestinationEntities>>> fetchDestinations();
}
