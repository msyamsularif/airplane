import 'package:airplane/cubits/destination/destination_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/auth/auth_cubit.dart';
import 'cubits/page/page_cubit.dart';
import 'ui/pages/bonus_page.dart';
import 'ui/pages/checkout_page.dart';
import 'ui/pages/choose_seat_page.dart';
import 'ui/pages/detail_page.dart';
import 'ui/pages/get_started_page.dart';
import 'ui/pages/main_page.dart';
import 'ui/pages/sign_in_page.dart';
import 'ui/pages/sign_up_page.dart';
import 'ui/pages/splash_page.dart';
import 'ui/pages/success_checkout_page.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<PageCubit>(
          create: (context) => PageCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<DestinationCubit>(
          create: (context) => DestinationCubit()..fetchDestinations(),
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
          '/detail-destination': (context) => const DetailPage(),
          '/choose-seat': (context) => const ChooseSeatPage(),
          '/checkout': (context) => const CheckoutPage(),
          '/success-checkout': (context) => const SuccessCheckoutPage(),
        },
      ),
    );
  }
}
