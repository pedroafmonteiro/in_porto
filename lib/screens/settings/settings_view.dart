import 'package:flutter/material.dart';
import 'package:in_porto/screens/settings/widgets/location_switch_widget.dart';
import 'package:in_porto/screens/settings/widgets/theme_widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
        ),
        body: const Column(
          children: [
            ThemeWidget(),
            LocationSwitchWidget(),
          ],
        ));
  }
}
