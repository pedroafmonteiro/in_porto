import 'package:flutter/material.dart';
import 'package:in_porto/screens/debug/debug_view.dart';
import 'package:in_porto/screens/settings/widgets/location_switch_widget.dart';
import 'package:in_porto/screens/settings/widgets/theme_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DebugView(),
                  ),
                );
              },
              icon: const Icon(Icons.code_rounded),
            ),
          ],
        ),
        body: const Column(
          children: [
            ThemeWidget(),
            LocationSwitchWidget(),
          ],
        ));
  }
}
