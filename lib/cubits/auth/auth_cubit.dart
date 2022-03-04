import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/transaction_model.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user =
          await AuthService().signIn(email: email, password: password);
      emit(AuthSuccess(user: user));
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

      UserModel user = await AuthService().signUp(
        email: email,
        password: password,
        name: name,
        hobby: hobby,
      );

      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailed(errorMessage: e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(errorMessage: e.toString()));
    }
  }

  void getCurrentUser({required String id}) async {
    try {
      emit(AuthLoading());
      UserModel user = await UserService().getUserById(id: id);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailed(errorMessage: e.toString()));
    }
  }

  void updateBalance({
    required TransactionModel transaction,
    bool topUpbalance = false,
  }) async {
    try {
      emit(AuthLoading());
      if (!topUpbalance) {}
      final int currentBalance = transaction.user.balance;
      final int grandTotalTransaction = transaction.grandTotal;

      if (currentBalance < grandTotalTransaction) {
        emit(const AuthFailed(errorMessage: 'Insufficient Balance'));
      } else {
        final int paid = currentBalance - grandTotalTransaction;
        final newValueUser = transaction.user.copyWith(balance: paid);
        await UserService().updateUser(user: newValueUser);
        emit(AuthSuccess(user: newValueUser));
      }
    } catch (e) {
      emit(AuthFailed(errorMessage: e.toString()));
    }
  }
}
