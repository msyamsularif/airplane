import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/transaction_model.dart';
import '../../../data/models/user_model.dart';
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
    try {
      emit(AuthLoading());

      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );

      emit(AuthSuccess(user: user.value!));
    } catch (e) {
      emit(AuthFailed(errorMessage: e.toString()));
    }
  }

  void signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  }) async {
    try {
      emit(AuthLoading());

      final user = await _authRepository.signUp(
        email: email,
        password: password,
        name: name,
        hobby: hobby,
      );

      emit(AuthSuccess(user: user.value!));
    } catch (e) {
      emit(AuthFailed(errorMessage: e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await _authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(errorMessage: e.toString()));
    }
  }

  void getCurrentUser({required String id}) async {
    try {
      emit(AuthLoading());
      final user = await _userRepository.getUserById(id: id);
      emit(AuthSuccess(user: user.value!));
    } catch (e) {
      emit(AuthFailed(errorMessage: e.toString()));
    }
  }

  void updateBalance({required TransactionModel transaction}) async {
    try {
      emit(AuthLoading());

      final int currentBalance = transaction.user.balance;
      final int grandTotalTransaction = transaction.grandTotal;

      if (currentBalance < grandTotalTransaction) {
        emit(const AuthFailed(errorMessage: 'Insufficient Balance'));
      } else {
        final int paid = currentBalance - grandTotalTransaction;
        final newValueUser = transaction.user.copyWith(balance: paid);
        await _userRepository.updateUser(user: newValueUser);
        emit(AuthSuccess(user: newValueUser));
      }
    } catch (e) {
      emit(AuthFailed(errorMessage: e.toString()));
    }
  }
}
