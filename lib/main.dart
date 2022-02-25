import 'package:flutter/material.dart';

import 'ui/pages/bonus_page.dart';
import 'ui/pages/choose_seat_page.dart';
import 'ui/pages/detail_page.dart';
import 'ui/pages/get_started_page.dart';
import 'ui/pages/main_page.dart';
import 'ui/pages/sign_up_page.dart';
import 'ui/pages/splash_page.dart';

void main() {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/get-started': (context) => const GetStartedPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/bonus': (context) => const BonusPage(),
        '/main': (context) => const MainPage(),
        '/detail-destination': (context) => const DetailPage(),
        '/choose-seat': (context) => const ChooseSeatPage(),
      },
    );
  }
}
