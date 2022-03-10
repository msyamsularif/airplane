import 'package:airplane/presentation/cubits/page/page_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PageCubit pageCubit;

  setUp(() {
    pageCubit = PageCubit();
  });

  test('initial state should be zero index', () {
    expect(pageCubit.state, 0);
  });

  blocTest<PageCubit, int>(
    'should emits [new page by index] when setPage on Tapped.',
    build: () => pageCubit,
    act: (bloc) => bloc.setPage(1),
    expect: () => const <int>[1],
  );
}
