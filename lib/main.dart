import 'package:flutter/material.dart';
import 'package:in_porto/onboarding/onboarding_view.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color.fromRGBO(25, 25, 25, 1.0),
    statusBarColor: Color.fromRGBO(25, 25, 25, 1.0),
  ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const OnboardingView(),
    );
  }
}
