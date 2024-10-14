import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersProvider extends ChangeNotifier {
  Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

  void addMarker(Marker marker) {
    _markers.add(marker);
    notifyListeners();
  }

  void removeMarker(Marker marker) {
    _markers.remove(marker);
    notifyListeners();
  }

  void updateMarkersWithStops(List<Map<String, String>> stops) async {
    final markers = await Future.wait(stops.map((stop) async {
      return Marker(
        markerId: MarkerId(stop['stop_id']!),
        position: LatLng(
            double.parse(stop['stop_lat']!), double.parse(stop['stop_lon']!)),
        infoWindow: InfoWindow(title: stop['stop_name']),
        flat: true,
        icon: await BitmapDescriptor.asset(
            const ImageConfiguration(size: Size(16, 16)),
            'assets/agencies/metrodoporto.png'),
      );
    }).toList());

    _markers = markers.toSet();
    notifyListeners();
  }

  void clearMarkers() {
    _markers.clear();
    notifyListeners();
  }
}
