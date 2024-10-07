import 'package:flutter/material.dart';
import 'package:voopoler/views/module/auth/forgot/otp.dart';
import 'package:voopoler/views/module/auth/signin.dart';
import 'package:voopoler/views/module/auth/signup.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      onUnknownRoute: (_) {
        const HomeView();
      },
      routes: {
        'home': (context) => const HomeView(),
        'signin': (context) => const SignIn(),
        'signup': (context) => const SignUp(),
        'verify': (context) => const OtpViews(resendCode: ''),
      },
      home: const Scaffold(
        body: Center(
          child: Text("home"),
        ),
      ),
    );
  }
}
