import '../../core/values/values.dart';
import '../../data/models/destination_model.dart';

abstract class DestinationRepository {
  Future<ApiReturnValue<List<DestinationModel>>> fetchDestinations();
}
