import 'package:flutter/material.dart';
import 'package:in_porto/homepage/homepage_view.dart';
import 'package:in_porto/onboarding/onboarding_view.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color.fromRGBO(25, 25, 25, 1.0),
    statusBarColor: Color.fromRGBO(25, 25, 25, 1.0),
  ));
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("hasSeenOnboarding") ?? false;
  runApp(MainApp(onboarding: onboarding));
}

class MainApp extends StatelessWidget {
  final bool onboarding;
  const MainApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: onboarding ? const HomepageView() : const OnboardingView(),
    );
  }
}
