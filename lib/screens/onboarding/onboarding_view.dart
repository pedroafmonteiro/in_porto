import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_porto/screens/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Color.fromRGBO(25, 25, 25, 1.0),
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      backgroundColor: const Color.fromRGBO(25, 25, 25, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
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
                const TextButton(
                  onPressed: null, // Does nothing for now
                  child: Text(
                    'Continue with Google\n(Not available)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF494949),
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    final currentContext = context;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool("hasSeenOnboarding", true);

                    if (!currentContext.mounted) return;
                    Navigator.pushReplacement(
                        currentContext,
                        MaterialPageRoute(
                            builder: (context) => const HomeView()));
                  },
                  child: const Text(
                    'Get started',
                    style: TextStyle(
                      color: Color(0xFFF8F8FF),
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      height: 0.09,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Optional spacing between text field and bottom
              ],
            ),
          ],
        ),
      ),
    );
  }
}
