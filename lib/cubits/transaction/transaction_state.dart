part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final TransactionModel transaction;

  const TransactionSuccess({
    required this.transaction,
  });

  @override
  List<Object> get props => [transaction];
}

class TransactionFailed extends TransactionState {
  final String errorMessage;

  const TransactionFailed({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
