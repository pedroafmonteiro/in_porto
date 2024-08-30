import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:in_porto/notifiers/location_notifier.dart';

import 'dialogs/location_dialogs.dart';

class LocationService {
  final LocationNotifier locationNotifier;
  final BuildContext context;
  Timer? _locationPermissionStatusTimer;
  bool _isCheckingPermission = false;

  LocationService(this.locationNotifier, this.context);

  GoogleMapController? mapController;

  void onMapCreated(GoogleMapController? controller) {
    mapController = controller;
    if (locationNotifier.locationStatus != 0) updateLocationStatus();
  }

  Future<void> updateLocationStatus() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _handleLocationDisabled();
    } else if (locationNotifier.locationStatus != 4) {
      _handleLocationEnabled();
    } else if (locationNotifier.locationStatus == 4) {
      Position position = await Geolocator.getCurrentPosition();
      print('test 1');
      if (mapController != null) {
        print('test 2');
        mapController!.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude), 17));
      }
    }
  }

  void _handleLocationDisabled() {
    locationNotifier.setLocationStatus(1);
    if (context.mounted) showLocationDisabledDialog(this, context);
    stopMonitoringLocationPermissionStatus();
  }

  void _handleLocationEnabled() {
    locationNotifier.setLocationStatus(2);
    startMonitoringLocationPermissionStatus();
  }

  void startMonitoringLocationPermissionStatus() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      _handlePermissionDenied();
    } else {
      locationNotifier.setLocationStatus(4);
      _startPermissionCheckTimer();
    }
  }

  void _handlePermissionDenied() {
    if (context.mounted) showLocationDeniedDialog(this, context);
  }

  void _startPermissionCheckTimer() {
    _locationPermissionStatusTimer =
        Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (!_isCheckingPermission) {
        _isCheckingPermission = true;
        await checkPermission();
        _isCheckingPermission = false;
      }
    });
  }

  void stopMonitoringLocationPermissionStatus() {
    _locationPermissionStatusTimer?.cancel();
    _locationPermissionStatusTimer = null;
  }

  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _handlePermissionDenied();
      locationNotifier
          .setLocationStatus(permission == LocationPermission.denied ? 2 : 3);
      stopMonitoringLocationPermissionStatus();
    }
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  /*void rebuildMapController() {
    if (mapController != null) {
      mapController!.dispose();
      mapController = null;
    }
    locationNotifier.notifyListeners();
  }*/
}
