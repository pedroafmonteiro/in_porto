import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

import '../../../notifiers/location_notifier.dart';

class LocationSwitchWidget extends StatefulWidget {
  const LocationSwitchWidget({super.key});

  @override
  State<LocationSwitchWidget> createState() => _LocationSwitchWidgetState();
}

class _LocationSwitchWidgetState extends State<LocationSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    final locationNotifier = Provider.of<LocationNotifier>(context);
    final location = locationNotifier.locationFeatures;

    return ListTile(
      title: Text(
        'Location features',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      leading: Icon(
        Icons.location_on_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      trailing: Switch(
        value: location,
        onChanged: (bool value) {
          setState(() {
            if (!value) {
              _showWarningDialog(context, locationNotifier, value);
            } else {
              locationNotifier.setLocationFeatures(value);
            }
          });
        },
      ),
    );
  }

  void _showWarningDialog(
      BuildContext context, LocationNotifier locationNotifier, bool value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text(
            'Turning off location features will make the "My location" button unavailable on the home screen and turn off nearby places features.\n'
            'This option does not revoke the location permission for the app. You must manually do so if desired.\n'
            'The app will restart to apply the changes.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Proceed'),
              onPressed: () {
                setState(() {
                  locationNotifier.setLocationFeatures(value);
                  locationNotifier.resetLocationStatus();
                  Future.delayed(const Duration(seconds: 1), () {
                    Restart.restartApp();
                  });
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
