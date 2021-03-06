import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/error/exceptions.dart';
import '../models/destination_model.dart';

abstract class DestinationDataSource {
  Future<List<DestinationModel>> fetchDestinations();
}

class DestinationDataSourceImpl implements DestinationDataSource {
  final CollectionReference destinationReference;
  DestinationDataSourceImpl({
    required this.destinationReference,
  });

  @override
  Future<List<DestinationModel>> fetchDestinations() async {
    try {
      QuerySnapshot result = await destinationReference.get();

      List<DestinationModel> destinations = result.docs
          .map(
            (e) => DestinationModel.fromJson(
                e.id, e.data() as Map<String, dynamic>),
          )
          .toList();

      return destinations;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
