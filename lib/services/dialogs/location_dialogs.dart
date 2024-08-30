import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_porto/services/location_service.dart';

void showLocationDisabledDialog(LocationService locationService, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => LocationDisabled(locationService: locationService),
  );
}

class LocationDisabled extends StatelessWidget {
  final LocationService locationService;

  const LocationDisabled({super.key, required this.locationService});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location services are disabled'),
      content:
      const Text('Please enable location services to use this feature'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            locationService.openLocationSettings();
            Navigator.of(context).pop();
          },
          child: const Text('Enable'),
        ),
      ],
    );
  }
}

void showLocationDeniedDialog(LocationService locationService, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => LocationDenied(locationService: locationService),
  );
}

class LocationDenied extends StatelessWidget {
  final LocationService locationService;

  const LocationDenied({super.key, required this.locationService});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location permissions are denied'),
      content: const Text('Please enable location permissions'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            locationDeniedDialogLogic(locationService, context);
          },
          child: const Text('Enable'),
        ),
      ],
    );
  }
}

void locationDeniedDialogLogic(LocationService locationService, BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.deniedForever && context.mounted) {
    locationService.openAppSettings();
  }
  if (context.mounted) {
    locationService.startMonitoringLocationPermissionStatus();
    locationService.updateLocationStatus();
    Navigator.of(context).pop();
  }
}