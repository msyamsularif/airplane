import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;
import 'presentation/cubits/auth/auth_cubit.dart';
import 'presentation/cubits/destination/destination_cubit.dart';
import 'presentation/cubits/page/page_cubit.dart';
import 'presentation/cubits/seat/seat_cubit.dart';
import 'presentation/cubits/transaction/transaction_cubit.dart';
import 'presentation/pages/bonus_page.dart';
import 'presentation/pages/get_started_page.dart';
import 'presentation/pages/main_page.dart';
import 'presentation/pages/sign_in_page.dart';
import 'presentation/pages/sign_up_page.dart';
import 'presentation/pages/splash_page.dart';
import 'presentation/pages/success_checkout_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PageCubit>(
          create: (_) => di.sl<PageCubit>(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>(),
        ),
        BlocProvider<DestinationCubit>(
          create: (_) => di.sl<DestinationCubit>()..fetchDestinations(),
        ),
        BlocProvider<SeatCubit>(
          create: (_) => di.sl<SeatCubit>(),
        ),
        BlocProvider<TransactionCubit>(
          create: (_) => di.sl<TransactionCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/get-started': (context) => const GetStartedPage(),
          '/sign-up': (context) => SignUpPage(),
          '/sign-in': (context) => SignInPage(),
          '/bonus': (context) => const BonusPage(),
          '/main': (context) => const MainPage(),
          '/success-checkout': (context) => const SuccessCheckoutPage(),
        },
      ),
    );
  }
}
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider(
//           create: (context) => UserRepositoryImpl(
//             userDataSource: UserDataSourceImpl(
//               userReference: GetIt.I.get<FirebaseFirestore>().collection(
//                     FirebaseHelper.userCollection,
//                   ),
//             ),
//           ),
//         ),
//         RepositoryProvider(
//           create: (context) => AuthRepositoryImpl(
//             authDataSource: AuthDataSourceImpl(
//               firebaseAuth: GetIt.I.get<FirebaseAuth>(),
//               userDataSource: UserDataSourceImpl(
//                 userReference: GetIt.I.get<FirebaseFirestore>().collection(
//                       FirebaseHelper.userCollection,
//                     ),
//               ),
//             ),
//           ),
//         ),
//         RepositoryProvider(
//           create: (context) => DestinationRepositoryImpl(
//             destinationDataSource: DestinationDataSourceImpl(
//               destinationReference: GetIt.I.get<FirebaseFirestore>().collection(
//                     FirebaseHelper.destiantionCollection,
//                   ),
//             ),
//           ),
//         ),
//         RepositoryProvider(
//           create: (context) => TransactionRepositoryImpl(
//             transactionDataSource: TransactionDataSourceImpl(
//               transactionReference: GetIt.I.get<FirebaseFirestore>().collection(
//                     FirebaseHelper.transactionCollection,
//                   ),
//             ),
//           ),
//         ),
//       ],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider<PageCubit>(
//             create: (context) => PageCubit(),
//           ),
//           BlocProvider<AuthCubit>(
//             create: (context) => AuthCubit(
//               authRepository: context.read<AuthRepositoryImpl>(),
//               userRepository: context.read<UserRepositoryImpl>(),
//             ),
//           ),
//           BlocProvider<DestinationCubit>(
//             create: (context) => DestinationCubit(
//               destinationRepository: context.read<DestinationRepositoryImpl>(),
//             )..fetchDestinations(),
//           ),
//           BlocProvider<SeatCubit>(
//             create: (context) => SeatCubit(),
//           ),
//           BlocProvider<TransactionCubit>(
//             create: (context) => TransactionCubit(
//               transactionRepository: context.read<TransactionRepositoryImpl>(),
//             ),
//           ),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           routes: {
//             '/': (context) => const SplashPage(),
//             '/get-started': (context) => const GetStartedPage(),
//             '/sign-up': (context) => SignUpPage(),
//             '/sign-in': (context) => SignInPage(),
//             '/bonus': (context) => const BonusPage(),
//             '/main': (context) => const MainPage(),
//             '/success-checkout': (context) => const SuccessCheckoutPage(),
//           },
//         ),
//       ),
//     );
//   }
// }
