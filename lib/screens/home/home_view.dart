import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_porto/screens/home/widgets/bottom_widget.dart';
import 'package:in_porto/screens/home/widgets/location_widget.dart';
import 'package:in_porto/screens/home/widgets/map_widget.dart';
import 'package:provider/provider.dart';

import '../../notifiers/location_notifier.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final locationNotifier = Provider.of<LocationNotifier>(context);
    final locationFeatures = locationNotifier.locationFeatures;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle!
              .systemNavigationBarColor,
          statusBarColor:
              Theme.of(context).appBarTheme.systemOverlayStyle!.statusBarColor,
          statusBarBrightness: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle!
              .statusBarBrightness,
          statusBarIconBrightness: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle!
              .statusBarIconBrightness,
        ),
      ),
      body: Stack(
        children: [
          const MapWidget(),
          if (locationFeatures)
            const LocationWidget(),
          const BottomWidget()
        ],
      ),
    );
  }
}
