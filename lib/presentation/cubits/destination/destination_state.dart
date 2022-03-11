part of 'destination_cubit.dart';

abstract class DestinationState extends Equatable {
  const DestinationState();

  @override
  List<Object> get props => [];
}

class DestinationInitial extends DestinationState {}

class DestinationLoading extends DestinationState {}

class DestinationSuccess extends DestinationState {
  final List<DestinationEntities> destinations;

  const DestinationSuccess({
    required this.destinations,
  });

  @override
  List<Object> get props => [destinations];
}

class DestinationFailed extends DestinationState {
  final String errorMessage;

  const DestinationFailed({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
