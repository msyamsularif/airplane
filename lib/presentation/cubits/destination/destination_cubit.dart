import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/destination_entities.dart';
import '../../../domain/repositories/destination_repositories.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  final DestinationRepository _destinationRepository;

  DestinationCubit({required DestinationRepository destinationRepository})
      : _destinationRepository = destinationRepository,
        super(DestinationInitial());

  void fetchDestinations() async {
    // try {
    //   emit(DestinationLoading());
    //   final destinations = await _destinationRepository.fetchDestinations();
    //   emit(DestinationSuccess(destinations: destinations.value!));
    // } catch (e) {
    //   emit(DestinationFailed(errorMessage: e.toString()));
    // }
    emit(DestinationLoading());
    final destinationsOrFailure =
        await _destinationRepository.fetchDestinations();

    destinationsOrFailure.fold(
      (failure) => emit(
        DestinationFailed(errorMessage: failure.failureMessage()),
      ),
      (destinations) => emit(DestinationSuccess(destinations: destinations)),
    );
  }
}
