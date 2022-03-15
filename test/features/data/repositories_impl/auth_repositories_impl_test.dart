import 'package:airplane/core/error/exceptions.dart';
import 'package:airplane/core/error/failures.dart';
import 'package:airplane/data/models/user_model.dart';
import 'package:airplane/data/repositories_impl/auth_repositories_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthDataSource mocDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    mocDataSource = MockAuthDataSource();
    repository = AuthRepositoryImpl(authDataSource: mocDataSource);
  });

  const UserModel tUserModel = UserModel(
    id: '1',
    email: 'email@gmail.com',
    name: 'name',
    hobby: 'hobby',
    balance: 100,
  );

  group('Sign In', () {
    test(
      'should sign in with a registered account',
      () async {
        // arrange
        when(mocDataSource.signIn(email: tUserModel.email, password: '123456'))
            .thenAnswer((_) async => tUserModel);

        // act
        final result = await repository.signIn(
            email: tUserModel.email, password: '123456');

        // assert
        verify(
            mocDataSource.signIn(email: tUserModel.email, password: '123456'));
        expect(result, equals(Right(tUserModel.toEntity())));
      },
    );

    test(
      'should return ServerFailure type throw',
      () async {
        // arrange
        when(mocDataSource.signIn(email: tUserModel.email, password: '123456'))
            .thenThrow(ServerException());

        // act
        final result = await repository.signIn(
          email: tUserModel.email,
          password: '123456',
        );

        // assert
        verify(
          mocDataSource.signIn(email: tUserModel.email, password: '123456'),
        );
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('sign out', () {
    test('should end login session', () async {
      // act
      await repository.signOut();

      // assert
      verify(mocDataSource.signOut());
    });

    test(
      'should return ApiReturnValue type throw',
      () async {
        // arrange
        when(mocDataSource.signOut()).thenThrow(Exception('error'));

        // act
        final result = repository.signOut();

        // assert
        verify(mocDataSource.signOut());
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });

  group('sign up', () {
    test(
      'should create new account',
      () async {
        // arrange
        when(mocDataSource.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        )).thenAnswer((_) async => tUserModel);

        // act
        final result = await repository.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        );

        // assert
        verify(mocDataSource.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        ));
        expect(result, equals(Right(tUserModel.toEntity())));
      },
    );

    test(
      'should return ServerFailure type throw',
      () async {
        // arrange
        when(mocDataSource.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        )).thenThrow(ServerException());

        // act
        final result = await repository.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        );

        // assert
        verify(mocDataSource.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        ));
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });
}
