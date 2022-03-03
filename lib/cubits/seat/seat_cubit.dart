import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SeatCubit extends Cubit<List<String>> {
  SeatCubit() : super([]);

  void selectSeat({required String id}) {
    debugPrint('PREV : $state');
    if (!isSelected(id)) {
      state.add(id);
    } else {
      state.remove(id);
    }

    debugPrint('CURR : $state');
    emit(List.from(state));
  }

  bool isSelected(String id) {
    int index = state.indexOf(id);
    if (index == -1) {
      return false;
    } else {
      return true;
    }
    // return state.contains(id);
  }
}
