import 'package:airplane/presentation/cubits/seat/seat_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SeatCubit seatCubit;

  setUp(() {
    seatCubit = SeatCubit();
  });

  test('initial state should be list empty', () {
    expect(seatCubit.state, []);
  });

  List<String> tSeat = ['A1', 'A2', 'A3'];

  blocTest<SeatCubit, List<String>>(
    'should emits [id seat] to list when id seat no contains in List seat',
    build: () => seatCubit,
    act: (bloc) => bloc.selectSeat(id: 'A1'),
    expect: () => <List<String>>[
      ['A1'],
    ],
  );

  test('should return true if id seat contains in List seat', () {
    // arrange
    seatCubit.emit(tSeat);

    // act
    final bool result = seatCubit.isSelected('A1');

    // assert
    expect(result, true);
  });

  test('should return false if id seat no contains in List seat', () {
    // arrange
    seatCubit.emit(tSeat);

    // act
    final bool result = seatCubit.isSelected('A4');

    // assert
    expect(result, false);
  });

  blocTest<SeatCubit, List<String>>(
    'should unselected or remove from list when id seat contains in list seat.',
    build: () {
      seatCubit.emit(tSeat);
      return seatCubit;
    },
    act: (bloc) => bloc.selectSeat(id: 'A1'),
    expect: () => const <List<String>>[
      ['A2', 'A3']
    ],
  );
}
