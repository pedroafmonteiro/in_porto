import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<int> checkLocationServices() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return 0;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 1;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 2;
    }

    return 3;
  }

  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}

void showLocationDisabledDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const LocationDisabled(),
  );
}

class LocationDisabled extends StatelessWidget {
  const LocationDisabled({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location services are disabled'),
      content: const Text('Please enable location services to use this feature'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Geolocator.openLocationSettings();
            Navigator.of(context).pop();
          },
          child: const Text('Enable'),
        ),
      ],
    );
  }
}

void showLocationDeniedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const LocationDenied(),
  );
}

class LocationDenied extends StatelessWidget {
  const LocationDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location permissions are denied'),
      content: const Text('Please enable location permissions in the app settings'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Geolocator.openAppSettings();
            Navigator.of(context).pop();
          },
          child: const Text('Enable'),
        ),
      ],
    );
  }
}

