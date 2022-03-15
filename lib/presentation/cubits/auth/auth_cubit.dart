import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/transaction_entities.dart';
import '../../../domain/entities/user_entities.dart';
import '../../../domain/repositories/auth_repositories.dart';
import '../../../domain/repositories/user_repositories.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(AuthInitial());

  void signIn({required String email, required String password}) async {
    emit(AuthLoading());

    final userOrFailure = await _authRepository.signIn(
      email: email,
      password: password,
    );

    emit(userOrFailure.fold(
      (failure) => AuthFailed(
        errorMessage: failure.failureMessage(),
      ),
      (user) => AuthSuccess(user: user),
    ));

    debugPrint('CURRENT STATE : $state');
  }

  void signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  }) async {
    emit(AuthLoading());

    final userOrFailure = await _authRepository.signUp(
      email: email,
      password: password,
      name: name,
      hobby: hobby,
    );

    emit(userOrFailure.fold(
      (failure) => AuthFailed(errorMessage: failure.failureMessage()),
      (user) => AuthSuccess(user: user),
    ));
  }

  void signOut() async {
    emit(AuthLoading());

    final signOutOrFailure = await _authRepository.signOut();

    emit(signOutOrFailure.fold(
      (failure) => AuthFailed(errorMessage: failure.failureMessage()),
      (_) => AuthInitial(),
    ));
  }

  void getCurrentUser({required String id}) async {
    emit(AuthLoading());
    final userOrFailure = await _userRepository.getUserById(id: id);

    userOrFailure.fold(
      (failure) => emit(AuthFailed(errorMessage: failure.failureMessage())),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  void updateBalance({required TransactionEntities transaction}) async {
    emit(AuthLoading());

    final int currentBalance = transaction.user.balance;
    final int grandTotalTransaction = transaction.grandTotal;

    if (currentBalance < grandTotalTransaction) {
      emit(const AuthFailed(errorMessage: 'Insufficient Balance'));
    } else {
      final int paid = currentBalance - grandTotalTransaction;
      final newValueUser = transaction.user.copyWith(balance: paid);
      final updateOrFailure =
          await _userRepository.updateUser(user: newValueUser);
      updateOrFailure.fold(
        (failure) => emit(AuthFailed(errorMessage: failure.failureMessage())),
        (_) => emit(AuthSuccess(user: newValueUser)),
      );
    }
  }
}
