import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_porto/notifiers/location_notifier.dart';
import 'package:provider/provider.dart';

class LocationService {
  final LocationNotifier locationNotifier;
  final BuildContext context;
  StreamSubscription<ServiceStatus>? _serviceStatusSubscription;
  Timer? _permissionCheckTimer;
  bool _isCheckingPermission = false;

  LocationService(this.locationNotifier, this.context);

  Future<void> updateLocationStatus() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      locationNotifier.setLocationStatus(1);
      if (context.mounted) showLocationDisabledDialog(context);
      startMonitoringLocationServiceStatus();
    } else {
      if (locationNotifier.locationStatus == 4) return;
      locationNotifier.setLocationStatus(2);
      startMonitoringLocationServiceStatus();
      startMonitoringLocationPermissionStatus();
    }
  }

  void startMonitoringLocationServiceStatus() {
    _serviceStatusSubscription =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        locationNotifier.setLocationStatus(2);
        startMonitoringLocationPermissionStatus();
      } else {
        stopMonitoringLocationPermissionStatus();
        locationNotifier.setLocationStatus(1);
        if (context.mounted) showLocationDisabledDialog(context);
      }
    });
  }

  void stopMonitoringLocationServicesStatus() {
    _serviceStatusSubscription?.cancel();
    _serviceStatusSubscription = null;
  }

  void startMonitoringLocationPermissionStatus() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (locationNotifier.locationStatus == 2 && permission == LocationPermission.denied) {
      if (context.mounted) showLocationDeniedDialog(context);
    } else if (locationNotifier.locationStatus == 3 && permission == LocationPermission.denied) {
      if (context.mounted) showLocationDeniedDialog(context);
    } else {
      locationNotifier.setLocationStatus(4);
      _permissionCheckTimer = Timer.periodic(
        const Duration(seconds: 5),
        (timer) async {
          if (!_isCheckingPermission) {
            _isCheckingPermission = true;
            await checkPermission();
            _isCheckingPermission = false;
          }
        },
      );
    }
  }

  void stopMonitoringLocationPermissionStatus() {
    _permissionCheckTimer?.cancel();
    _permissionCheckTimer = null;
  }

  Future<void> checkPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied &&  context.mounted) {
        locationNotifier.setLocationStatus(2);
        stopMonitoringLocationPermissionStatus();
        showLocationDeniedDialog(context);
      } else if (permission == LocationPermission.deniedForever && context.mounted) {
        locationNotifier.setLocationStatus(3);
        stopMonitoringLocationPermissionStatus();
        showLocationDeniedDialog(context);
      }
    } catch (e) {
      print('error');
    }
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
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
            LocationService(
                    Provider.of<LocationNotifier>(context, listen: false),
                    context)
                .openLocationSettings();
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
            locationDeniedDialogLogic(context);
          },
          child: const Text('Enable'),
        ),
      ],
    );
  }
}

void locationDeniedDialogLogic(BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.deniedForever && context.mounted) {
    LocationService(
            Provider.of<LocationNotifier>(context, listen: false), context)
        .openAppSettings();
  }
  if (context.mounted) {
    LocationService(
        Provider.of<LocationNotifier>(context, listen: false), context)
        .startMonitoringLocationPermissionStatus();
    Navigator.of(context).pop();
  }
}

/*
void showLocationDeniedForeverDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const LocationDeniedForever(),
  );
}

class LocationDeniedForever extends StatelessWidget {
  const LocationDeniedForever({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location permissions are permanently denied'),
      content:
      const Text('Please enable location permissions in the app settings'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            locationDeniedForeverDialogLogic(context);
          },
          child: const Text('Enable'),
        ),
      ],
    );
  }
}

void locationDeniedForeverDialogLogic(BuildContext context) async {
  LocationPermission permission = await Geolocator.checkPermission();
  permission = await Geolocator.requestPermission();
  print(permission);
  if (permission == LocationPermission.deniedForever && context.mounted) {
    LocationService(
        Provider.of<LocationNotifier>(context, listen: false), context)
        .openAppSettings();
  }
  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    if (context.mounted) {
      Provider.of<LocationNotifier>(context, listen: false).setLocationStatus(4);
      LocationService(Provider.of<LocationNotifier>(context, listen: false), context).startMonitoringLocationPermissionStatus();
    }
  }
  if (context.mounted) Navigator.of(context).pop();
}*/
