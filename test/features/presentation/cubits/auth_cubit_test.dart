import 'package:airplane/core/constanta/constanta.dart';
import 'package:airplane/core/error/failures.dart';
import 'package:airplane/data/models/destination_model.dart';
import 'package:airplane/data/models/transaction_model.dart';
import 'package:airplane/data/models/user_model.dart';
import 'package:airplane/presentation/cubits/auth/auth_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;
  late AuthCubit authCubit;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    authCubit = AuthCubit(
      authRepository: mockAuthRepository,
      userRepository: mockUserRepository,
    );
  });

  const UserModel tUserModel = UserModel(
    id: '1',
    email: 'email@gmail.com',
    name: 'name',
    hobby: 'hobby',
    balance: 280000000,
  );

  const TransactionModel tTransactionModel = TransactionModel(
    id: '1',
    user: UserModel(
      id: '1',
      email: 'email@gmail.com',
      name: 'name',
      hobby: 'hobby',
      balance: 280000000,
    ),
    destination: DestinationModel(
      id: '1',
      name: "name",
      city: "city",
      imageUrl: "imageUrl",
      rating: 1.0,
      price: 1,
    ),
    amountOfTravelers: 1,
    selectedSeats: 'A1',
    insurance: true,
    refundable: true,
    vit: 0.5,
    price: 100,
    grandTotal: 1000000,
    createdAt: 1646795474440000,
  );

  test('Initial state should be empty', () {
    expect(authCubit.state, AuthInitial());
  });

  group('sign in auth cubit', () {
    blocTest<AuthCubit, AuthState>(
      'should emits [AuthLoading, AuthSuccess] when data is gotten successfully.',
      build: () {
        when(mockAuthRepository.signIn(
          email: tUserModel.email,
          password: '123456',
        )).thenAnswer((_) async => const Right(tUserModel));

        return authCubit;
      },
      act: (bloc) => bloc.signIn(email: tUserModel.email, password: '123456'),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthSuccess(user: tUserModel),
      ],
      verify: (bloc) {
        verify(mockAuthRepository.signIn(
          email: tUserModel.email,
          password: '123456',
        ));
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emits [AuthFailed] when get data is unsuccessful.',
      build: () {
        when(mockAuthRepository.signIn(
          email: tUserModel.email,
          password: '123456',
        )).thenAnswer((_) async => Left(ServerFailure()));

        return authCubit;
      },
      act: (bloc) => bloc.signIn(email: tUserModel.email, password: '123456'),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthFailed(
          errorMessage: serverFailureMessage,
        ),
      ],
    );
  });

  group('sign up auth cubit', () {
    blocTest<AuthCubit, AuthState>(
      'should emits [AuthLoading, AuthSuccess] when data is gotten successfully.',
      build: () {
        when(mockAuthRepository.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        )).thenAnswer((_) async => const Right(tUserModel));

        return authCubit;
      },
      act: (bloc) => bloc.signUp(
        email: tUserModel.email,
        password: '123456',
        name: tUserModel.name,
        hobby: tUserModel.hobby,
      ),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthSuccess(user: tUserModel),
      ],
      verify: (bloc) {
        verify(mockAuthRepository.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        ));
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emits [AuthFailed] when get data is unsuccessful.',
      build: () {
        when(mockAuthRepository.signUp(
          email: tUserModel.email,
          password: '123456',
          name: tUserModel.name,
          hobby: tUserModel.hobby,
        )).thenAnswer((_) async => Left(ServerFailure()));

        return authCubit;
      },
      act: (bloc) => bloc.signUp(
        email: tUserModel.email,
        password: '123456',
        name: tUserModel.name,
        hobby: tUserModel.hobby,
      ),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthFailed(
          errorMessage: serverFailureMessage,
        ),
      ],
    );
  });

  group('sign out auth cubit', () {
    blocTest<AuthCubit, AuthState>(
      'should emits [AuthLoading, AuthInitial] when data is gotten successfully.',
      build: () {
        when(mockAuthRepository.signOut())
            .thenAnswer((_) async => const Right(null));
        return authCubit;
      },
      act: (bloc) => bloc.signOut(),
      expect: () => <AuthState>[AuthLoading(), AuthInitial()],
      verify: (bloc) {
        verify(mockAuthRepository.signOut());
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emits [AuthFailed] when get data is unsuccessful.',
      build: () {
        when(mockAuthRepository.signOut())
            .thenAnswer((_) async => Left(ServerFailure()));

        return authCubit;
      },
      act: (bloc) => bloc.signOut(),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthFailed(
          errorMessage: serverFailureMessage,
        ),
      ],
    );
  });

  group('get current user auth cubit', () {
    blocTest<AuthCubit, AuthState>(
      'should emits [AuthLoading, AuthSuccess] when data is gotten successfully.',
      build: () {
        when(mockUserRepository.getUserById(id: tUserModel.id))
            .thenAnswer((_) async => const Right(tUserModel));

        return authCubit;
      },
      act: (bloc) => bloc.getCurrentUser(id: tUserModel.id),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthSuccess(user: tUserModel),
      ],
      verify: (bloc) {
        verify(mockUserRepository.getUserById(id: tUserModel.id));
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emits [AuthFailed] when get data is unsuccessful.',
      build: () {
        when(mockUserRepository.getUserById(id: tUserModel.id))
            .thenAnswer((_) async => Left(ServerFailure()));

        return authCubit;
      },
      act: (bloc) => bloc.getCurrentUser(id: tUserModel.id),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthFailed(errorMessage: serverFailureMessage)
      ],
    );
  });

  group('update balance auth cubit', () {
    final int paid =
        tTransactionModel.user.balance - tTransactionModel.grandTotal;
    final tNewUserModel = tTransactionModel.user.copyWith(balance: paid);
    blocTest<AuthCubit, AuthState>(
      'should emits [AuthLoading, AuthSuccess] when current balance user not less than grand total transaction.',
      build: () {
        when(mockUserRepository.updateUser(user: tNewUserModel))
            .thenAnswer((realInvocation) async => const Right(null));

        return authCubit;
      },
      act: (bloc) => bloc.updateBalance(transaction: tTransactionModel),
      expect: () => <AuthState>[
        AuthLoading(),
        AuthSuccess(user: tNewUserModel),
      ],
      verify: (bloc) {
        verify(mockUserRepository.updateUser(user: tNewUserModel));
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoading, AuthFailed] when current balance user smaller than garand total transaction.',
      build: () => authCubit,
      act: (bloc) => bloc.updateBalance(
        transaction: tTransactionModel.copyWith(
          user: tNewUserModel.copyWith(balance: 0),
        ),
      ),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthFailed(errorMessage: 'Insufficient Balance'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'should emits [AuthFailed] when get data is unsuccessful.',
      build: () {
        when(mockUserRepository.updateUser(user: tNewUserModel))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authCubit;
      },
      act: (bloc) => bloc.updateBalance(transaction: tTransactionModel),
      expect: () => <AuthState>[
        AuthLoading(),
        const AuthFailed(errorMessage: serverFailureMessage)
      ],
    );
  });
}
