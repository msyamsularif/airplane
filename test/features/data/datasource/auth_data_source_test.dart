import 'package:airplane/data/datasource/auth_data_source.dart';
import 'package:airplane/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockUserCredential mockUserCredential;
  late MockUserDataSource mockUserDataSource;
  late MockUser mockUser;
  late AuthDataSourceImpl authDataSource;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUserDataSource = MockUserDataSource();
    mockUser = MockUser();
    authDataSource = AuthDataSourceImpl(
        firebaseAuth: mockAuth, userDataSource: mockUserDataSource);
  });

  const UserModel tUserModel = UserModel(
    id: '1',
    email: 'email@gmail.com',
    name: 'name',
    hobby: 'hobby',
    balance: 100,
  );

  group('sign in', () {
    test(
      'should sign in with a registered account',
      () async {
        // arrange
        when(mockAuth.signInWithEmailAndPassword(
                email: tUserModel.email, password: '123456'))
            .thenAnswer((_) async => mockUserCredential);

        when(mockUserCredential.user).thenReturn(mockUser);

        when(mockUser.uid).thenReturn(tUserModel.id);

        when(mockUserDataSource.getUserById(
                id: mockUserCredential.user?.uid ?? tUserModel.id))
            .thenAnswer((_) async => tUserModel);

        // act
        final result = await authDataSource.signIn(
            email: tUserModel.email, password: '123456');

        // assert
        verify(mockUserDataSource.getUserById(id: anyNamed('id')));
        expect(result, tUserModel);
      },
    );

    test(
      'should return type throw',
      () async {
        // arrange
        when(mockAuth.signInWithEmailAndPassword(
                email: tUserModel.email, password: '123456'))
            .thenThrow(Exception('error'));

        // act
        final result =
            authDataSource.signIn(email: tUserModel.email, password: '123456');

        // assert
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });
  group('sign out', () {
    test(
      'should end login session',
      () async {
        // act
        await authDataSource.signOut();

        // assert
        verify(mockAuth.signOut());
      },
    );

    test(
      'should return type throw',
      () async {
        // arrange
        when(mockAuth.signOut()).thenThrow(Exception('error'));

        // act
        final result = authDataSource.signOut();

        // assert
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });
  group('sign up', () {
    test(
      'should create new account',
      () async {
        // arrange
        when(mockAuth.createUserWithEmailAndPassword(
                email: tUserModel.email, password: '123456'))
            .thenAnswer((_) async => mockUserCredential);

        when(mockUserCredential.user).thenReturn(mockUser);

        when(mockUser.uid).thenReturn(tUserModel.id);

        // act
        final result = await authDataSource.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        );

        // assert
        verify(mockUserDataSource.setUser(user: anyNamed('user')));
        expect(result, tUserModel.copyWith(balance: 280000000).toModel());
      },
    );
    test(
      'should return type throw',
      () async {
        // arrange
        when(mockAuth.createUserWithEmailAndPassword(
                email: tUserModel.email, password: '123456'))
            .thenThrow(Exception('error'));

        // act
        final result = authDataSource.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        );

        // assert
        expect(() => result, throwsA(isA<Exception>()));
      },
    );
  });
}
