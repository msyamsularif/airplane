import 'package:airplane/models/destination_model.dart';
import 'package:airplane/services/destination_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  DestinationCubit() : super(DestinationInitial());

  void fetchDestinations() async {
    try {
      emit(DestinationLoading());
      final List<DestinationModel> destinations =
          await DestinationService().fetchDestinations();
      emit(DestinationSuccess(destinations: destinations));
    } catch (e) {
      emit(DestinationFailed(errorMessage: e.toString()));
    }
  }
}
