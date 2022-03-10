import 'package:airplane/core/values/values.dart';
import 'package:airplane/data/models/destination_model.dart';
import 'package:airplane/presentation/cubits/destination/destination_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDestinationRepository mockDestinationRepository;
  late DestinationCubit destinationCubit;

  setUp(() {
    mockDestinationRepository = MockDestinationRepository();
    destinationCubit =
        DestinationCubit(destinationRepository: mockDestinationRepository);
  });

  final List<DestinationModel> tDestinationList = [
    const DestinationModel(
      id: '1',
      name: 'name',
      city: 'city',
      imageUrl: 'imageUrl',
      rating: 1.0,
      price: 1,
    ),
    const DestinationModel(
      id: '2',
      name: 'name',
      city: 'city',
      imageUrl: 'imageUrl',
      rating: 2.0,
      price: 2,
    ),
  ];

  test('initial state should be empty', () {
    expect(destinationCubit.state, DestinationInitial());
  });

  group('fetch destination', () {
    blocTest<DestinationCubit, DestinationState>(
      'should emits [DestinationLoading, DestinationSuccess] when data is gotten successfully.',
      build: () {
        when(mockDestinationRepository.fetchDestinations())
            .thenAnswer((_) async => ApiReturnValue(value: tDestinationList));

        return destinationCubit;
      },
      act: (bloc) => bloc.fetchDestinations(),
      expect: () => <DestinationState>[
        DestinationLoading(),
        DestinationSuccess(destinations: tDestinationList),
      ],
    );

    blocTest<DestinationCubit, DestinationState>(
      'should emits [AuthFailed] when get data is unsuccessful.',
      build: () {
        when(mockDestinationRepository.fetchDestinations())
            .thenThrow(Exception('error'));

        return destinationCubit;
      },
      act: (bloc) => bloc.fetchDestinations(),
      expect: () => <DestinationState>[
        DestinationLoading(),
        DestinationFailed(errorMessage: Exception('error').toString()),
      ],
    );
  });
}
