import 'package:flutter/material.dart';
import 'package:in_porto/notifiers/theme_notifier.dart';
import 'package:provider/provider.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final String currentTheme =
        themeNotifier.themeMode.toString().split('.').last;

    return ListTile(
      title: Text(
        'Theme',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(currentTheme[0].toUpperCase() + currentTheme.substring(1)),
      leading: Icon(
        Icons.dark_mode_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ThemeDialog();
          },
        );
      },
    );
  }
}

class ThemeDialog extends StatefulWidget {
  const ThemeDialog({super.key});

  @override
  State<ThemeDialog> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final themeMode = themeNotifier.themeMode;

    return AlertDialog(
      title: Text(
        'Theme',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: themeMode,
            onChanged: (ThemeMode? value) {
              themeNotifier.setThemeMode(value!);
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: themeMode,
            onChanged: (ThemeMode? value) {
              themeNotifier.setThemeMode(value!);
              Navigator.of(context).pop();
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: themeMode,
            onChanged: (ThemeMode? value) {
              themeNotifier.setThemeMode(value!);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
