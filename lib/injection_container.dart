import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'core/helper/firebase_helper.dart';
import 'data/datasource/auth_data_source.dart';
import 'data/datasource/destination_data_source.dart';
import 'data/datasource/transaction_data_source.dart';
import 'data/datasource/user_data_source.dart';
import 'data/repositories_impl/auth_repositories_impl.dart';
import 'data/repositories_impl/destination_repositories_impl.dart';
import 'data/repositories_impl/transaction_repositories_impl.dart';
import 'data/repositories_impl/user_repositories_impl.dart';
import 'domain/repositories/auth_repositories.dart';
import 'domain/repositories/destination_repositories.dart';
import 'domain/repositories/transaction_repositories.dart';
import 'domain/repositories/user_repositories.dart';
import 'presentation/cubits/auth/auth_cubit.dart';
import 'presentation/cubits/destination/destination_cubit.dart';
import 'presentation/cubits/page/page_cubit.dart';
import 'presentation/cubits/seat/seat_cubit.dart';
import 'presentation/cubits/transaction/transaction_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // service locator firebase collection
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseHelper.instanceAuth);
  sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseHelper.instanceFirestore);

  // service locator data source
  sl.registerLazySingleton<UserDataSource>(
    () => UserDataSourceImpl(
      userReference:
          sl<FirebaseFirestore>().collection(FirebaseHelper.userCollection),
    ),
  );
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
        firebaseAuth: sl(), userDataSource: sl<UserDataSource>()),
  );
  sl.registerLazySingleton<DestinationDataSource>(
    () => DestinationDataSourceImpl(
      destinationReference: sl<FirebaseFirestore>()
          .collection(FirebaseHelper.destiantionCollection),
    ),
  );
  sl.registerLazySingleton<TransactionDataSource>(
    () => TransactionDataSourceImpl(
      transactionReference: sl<FirebaseFirestore>()
          .collection(FirebaseHelper.transactionCollection),
    ),
  );

  // service locator repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: sl()));
  sl.registerLazySingleton<DestinationRepository>(
      () => DestinationRepositoryImpl(destinationDataSource: sl()));
  sl.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(transactionDataSource: sl()));

  // service locator cubit
  sl.registerFactory<PageCubit>(() => PageCubit());
  sl.registerFactory<AuthCubit>(
      () => AuthCubit(authRepository: sl(), userRepository: sl()));
  sl.registerFactory<DestinationCubit>(
      () => DestinationCubit(destinationRepository: sl()));
  sl.registerFactory<SeatCubit>(() => SeatCubit());
  sl.registerFactory<TransactionCubit>(
      () => TransactionCubit(transactionRepository: sl()));
}
