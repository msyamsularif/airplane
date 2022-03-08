import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasource/auth_data_source.dart';
import 'data/datasource/destination_data_source.dart';
import 'data/datasource/transaction_data_source.dart';
import 'data/datasource/user_data_source.dart';
import 'data/repositories_impl/auth_repositories_impl.dart';
import 'data/repositories_impl/destination_repositories_impl.dart';
import 'data/repositories_impl/transaction_repositories_impl.dart';
import 'data/repositories_impl/user_repositories_impl.dart';
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(
            authDataSource: AuthDataSourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => DestinationRepositoryImpl(
            destinationDataSource: DestinationDataSourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => TransactionRepositoryImpl(
            transactionDataSource: TransactionDataSourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => DestinationRepositoryImpl(
            destinationDataSource: DestinationDataSourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepositoryImpl(
            userDataSource: UserDataSourceImpl(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PageCubit>(
            create: (context) => PageCubit(),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepositoryImpl>(),
              userRepository: context.read<UserRepositoryImpl>(),
            ),
          ),
          BlocProvider<DestinationCubit>(
            create: (context) => DestinationCubit(
              destinationRepository: context.read<DestinationRepositoryImpl>(),
            )..fetchDestinations(),
          ),
          BlocProvider<SeatCubit>(
            create: (context) => SeatCubit(),
          ),
          BlocProvider<TransactionCubit>(
            create: (context) => TransactionCubit(
              transactionRepository: context.read<TransactionRepositoryImpl>(),
            ),
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
      ),
    );
  }
}
