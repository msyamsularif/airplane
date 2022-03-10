import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'core/helper/firebase_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // service locator firebase collection
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseHelper.instanceAuth);
  sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseHelper.instanceFirestore);

  // service locator cubit
  // sl.registerFactory(() => PageCubit());
  // sl.registerFactory(
  //     () => AuthCubit(authRepository: sl(), userRepository: sl()));
  // sl.registerFactory(() => DestinationCubit(destinationRepository: sl()));
  // sl.registerFactory(() => SeatCubit());
  // sl.registerFactory(() => TransactionCubit(transactionRepository: sl()));
}
