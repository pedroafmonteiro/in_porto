import 'package:flutter/material.dart';
import 'package:in_porto/permissions/location.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.21,
              right: MediaQuery.of(context).size.width * 0.02),
          child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: _checkLocationServices,
              child: Icon(Icons.my_location_rounded,
                  color: Theme.of(context).iconTheme.color))),
    );
  }

  void _checkLocationServices() async {
    int serviceStatus = await LocationService().checkLocationServices();
    if (serviceStatus == 0 && mounted) {
      showLocationDisabledDialog(context);
    } else if (serviceStatus == 1 && mounted) {
      showLocationDeniedDialog(context);
    } else if (serviceStatus == 2 && mounted) {
      showLocationDeniedDialog(context);
    } else if (serviceStatus == 3 && mounted) {
      LocationService().getLocation();
    }
  }

}