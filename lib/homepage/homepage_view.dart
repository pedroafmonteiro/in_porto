import 'package:flutter/material.dart';
import 'package:in_porto/onboarding/onboarding_view.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 25, 25, 1.0),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OnboardingView()));
          },
          child: const Text('Hello')
          ),
        ),
    );
  }
}