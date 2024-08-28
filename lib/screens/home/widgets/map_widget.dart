import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:in_porto/values.dart';
import 'package:provider/provider.dart';

import '../../../notifiers/location_notifier.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.1585561, -8.6125248);

  @override
  void initState() {
    super.initState();
    final locationNotifier = Provider.of<LocationNotifier>(context, listen: false);
    locationNotifier.addListener(_onLocationChanged);
  }

  @override
  void dispose() {
    final locationNotifier = Provider.of<LocationNotifier>(context, listen: false);
    locationNotifier.removeListener(_onLocationChanged);
    super.dispose();
  }

  void _onLocationChanged() {
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final locationNotifier = Provider.of<LocationNotifier>(context);
    final bool location;
    if (locationNotifier.locationStatus == 4) {
      location = true;
    } else {
      location = false;
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        style: Theme.of(context).brightness == Brightness.dark
            ? googleMapsDark
            : googleMapsLight,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.13,
          left: MediaQuery.of(context).size.width * 0.025,
        ),
        myLocationEnabled: location,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        rotateGesturesEnabled: false,
      ),
    );
  }
}
