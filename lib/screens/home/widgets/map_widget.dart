import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:in_porto/values.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.1585561, -8.6125248);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _initializeMapRenderer();
  }

  void _initializeMapRenderer() {
    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      style: Theme.of(context).brightness == Brightness.dark
          ? googleMapsDark
          : googleMapsLight,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 12.0,
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.02),
      zoomControlsEnabled: false,
      compassEnabled: false,
      rotateGesturesEnabled: false,
    );
  }
}
