import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_porto/providers/markers_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'providers/theme_provider.dart';
import 'screens/home/home_view.dart';
import 'screens/onboarding/onboarding_view.dart';
import 'theme.dart';
import 'providers/location_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("hasSeenOnboarding") ?? false;

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  _initializeMapRenderer();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationNotifier(),
        ),
        ChangeNotifierProvider(create: (context) => MarkersProvider()),
      ],
      child: MainApp(onboarding: onboarding),
    ),
  );
}

void _initializeMapRenderer() {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
}

class MainApp extends StatelessWidget {
  final bool onboarding;

  const MainApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: notifier.themeMode,
          home: onboarding ? const HomeView() : const OnboardingView(),
        );
      },
    );
  }
}
