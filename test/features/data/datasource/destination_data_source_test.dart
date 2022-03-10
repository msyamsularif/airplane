import 'dart:convert';

import 'package:airplane/data/datasource/destination_data_source.dart';
import 'package:airplane/data/models/destination_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFirebaseFirestore instance;
  late MockCollectionReference mockCollectionRef;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQueryDocumentSnapshot mockQueryDocumentSnapshot;
  late DestinationDataSourceImpl dataSource;
  late String messageCollection;

  setUp(() {
    instance = MockFirebaseFirestore();
    mockCollectionRef = MockCollectionReference();
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    dataSource =
        DestinationDataSourceImpl(destinationReference: mockCollectionRef);
    messageCollection = 'destinations';
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
  ];

  group('fetch destination', () {
    test(
      'should fetch destination data',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.get())
            .thenAnswer((_) async => mockQuerySnapshot);

        when(mockQuerySnapshot.docs)
            .thenAnswer((_) => [mockQueryDocumentSnapshot]);

        when(mockQueryDocumentSnapshot.id)
            .thenAnswer((_) => tDestinationList[0].id);

        when(mockQueryDocumentSnapshot.data())
            .thenAnswer((_) => json.decode(fixture('destination.json')));

        // act
        final result = await dataSource.fetchDestinations();

        // assert
        expect(result, tDestinationList);
      },
    );

    test(
      'should return type throw',
      () async {
        // arrange
        when(instance.collection(messageCollection)).thenAnswer((_) =>
            mockCollectionRef as MockCollectionReference<Map<String, dynamic>>);

        when(mockCollectionRef.get()).thenThrow(Exception('error'));

        // act
        final result = dataSource.fetchDestinations();

        // assert
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });
}
