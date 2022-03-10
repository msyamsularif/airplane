import 'package:airplane/core/values/values.dart';
import 'package:airplane/data/models/user_model.dart';
import 'package:airplane/data/repositories_impl/user_repositories_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockUserDataSource mocDataSource;
  late UserRepositoryImpl repository;

  setUp(() {
    mocDataSource = MockUserDataSource();
    repository = UserRepositoryImpl(userDataSource: mocDataSource);
  });

  const UserModel tUserModel = UserModel(
    id: '1',
    email: 'email@gmail.com',
    name: 'name',
    hobby: 'hobby',
    balance: 100,
  );
  group('get user by id', () {
    const tUseId = '1';
    test(
      'should return ApiReturnValue type User Model',
      () async {
        // arrange
        when(mocDataSource.getUserById(id: tUseId))
            .thenAnswer((_) async => tUserModel);

        // act
        final result = await repository.getUserById(id: tUseId);

        // assert
        verify(mocDataSource.getUserById(id: tUseId));
        expect(
            result, equals(const ApiReturnValue<UserModel>(value: tUserModel)));
      },
    );

    test(
      'should return ApiReturnValue type throw',
      () async {
        const tUseId = '1';

        // arrange
        when(mocDataSource.getUserById(id: tUseId))
            .thenThrow(Exception('error'));

        // act
        final result = await repository.getUserById(id: tUseId);

        // assert
        verify(mocDataSource.getUserById(id: tUseId));
        expect(
          result,
          equals(
            ApiReturnValue<UserModel>(message: Exception('error').toString()),
          ),
        );
      },
    );
  });

  group('set user', () {
    test(
      'should be able to add data to the database',
      () async {
        // arrange
        when(mocDataSource.setUser(user: tUserModel))
            .thenAnswer((_) async => tUserModel);

        // act
        await repository.setUser(user: tUserModel);

        // assert
        verify(mocDataSource.setUser(user: tUserModel));
      },
    );

    test(
      'should return ApiReturnValue type throw',
      () async {
        // arrange
        when(mocDataSource.setUser(user: tUserModel))
            .thenThrow(Exception('error'));

        // act
        final result = repository.setUser(user: tUserModel);

        // assert
        verify(mocDataSource.setUser(user: tUserModel));
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });

  group('update user', () {
    test(
      'should can make data changes',
      () async {
        // arrange
        when(mocDataSource.updateUser(user: tUserModel))
            .thenAnswer((_) async => tUserModel);

        // act
        await repository.updateUser(user: tUserModel);

        // assert
        verify(mocDataSource.updateUser(user: tUserModel));
      },
    );

    test(
      'should return ApiReturnValue type throw',
      () async {
        // arrange
        when(mocDataSource.setUser(user: tUserModel))
            .thenThrow(Exception('error'));

        // act
        final result = repository.setUser(user: tUserModel);

        // assert
        verify(mocDataSource.setUser(user: tUserModel));
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });
}
