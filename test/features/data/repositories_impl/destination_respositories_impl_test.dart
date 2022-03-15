import 'package:airplane/core/error/exceptions.dart';
import 'package:airplane/core/error/failures.dart';
import 'package:airplane/data/models/destination_model.dart';
import 'package:airplane/data/repositories_impl/destination_repositories_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDestinationDataSource mocDataSource;
  late DestinationRepositoryImpl repository;

  setUp(() {
    mocDataSource = MockDestinationDataSource();
    repository =
        DestinationRepositoryImpl(destinationDataSource: mocDataSource);
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

  group('fetch destinaton', () {
    test(
      'should fetch destination data',
      () async {
        // arrange
        when(mocDataSource.fetchDestinations())
            .thenAnswer((_) async => tDestinationList);
        // act
        final result = await repository.fetchDestinations();
        // assert
        verify(mocDataSource.fetchDestinations());
        expect(result, equals(Right(tDestinationList)));
      },
    );

    test(
      'should return ServerFailure type throw',
      () async {
        // arrange
        when(mocDataSource.fetchDestinations()).thenThrow(ServerException());

        // act
        final result = await repository.fetchDestinations();

        // assert
        verify(mocDataSource.fetchDestinations());
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });
}
