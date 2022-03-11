part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntities user;

  const AuthSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthFailed extends AuthState {
  final String errorMessage;

  const AuthFailed({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
