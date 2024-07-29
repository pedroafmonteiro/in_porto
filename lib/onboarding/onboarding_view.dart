import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(25, 25, 25, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome to\n',
                          style: TextStyle(
                            color: Color(0xFFF8F8FF),
                            fontSize: 20,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w800,
                            height: 0.15,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(height: 70), // Add spacing here
                        ),
                        TextSpan(
                          text: 'In Porto',
                          style: TextStyle(
                            color: Color(0xFFF8F8FF),
                            fontSize: 48,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w800,
                            height: 0.03,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 70), // Add spacing here
                ],
              ),
            ),
            Column(
              children: [
                TextButton(
                  onPressed: null, // Does nothing for now
                  child: Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: Color(0xFFF8F8FF),
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Use without an account',
                  style: TextStyle(
                    color: Color(0xFFF8F8FF),
                    fontSize: 16,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                    height: 0.09,
                  ),
                ),
                SizedBox(height: 50), // Optional spacing between text field and bottom
              ],
            ),
          ],
        ),
      ),
    );
  }
}
