import 'package:equatable/equatable.dart';

import '../constanta/constanta.dart';

abstract class Failure extends Equatable {
  String failureMessage();

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String? message;

  ServerFailure({
    this.message,
  });
  
  @override
  String failureMessage() {
    return message ?? serverFailureMessage;
  }
}

class CacheFailure extends Failure {
  @override
  String failureMessage() {
    return cacheFailurMessage;
  }
}
