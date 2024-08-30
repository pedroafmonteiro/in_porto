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
          title: Text(
            'Warning',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: const <TextSpan>[
                TextSpan(
                  text:
                      'Disabling location features will prevent the app from accessing your location. '
                      'This will affect the app\'s functionality: \n\n',
                ),
                TextSpan(
                  text:
                      '• The "My Location" button on the home screen will be hidden, and your current location will no longer be displayed on the map.\n'
                      '• The Nearby Places feature will be disabled.\n\n',
                ),
                TextSpan(
                  text: 'Note: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Disabling location features in this app does not revoke location permissions. To fully disable location access, please adjust the app\'s permissions manually in your device settings.\n\n',
                ),
                TextSpan(
                  text: 'The app will restart to apply these changes.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
