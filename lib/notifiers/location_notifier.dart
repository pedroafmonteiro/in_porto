import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationNotifier extends ChangeNotifier {
  int _locationStatus = 0;
  final String _locationStatusKey = 'locationStatus';
  bool _locationFeatures = true;
  final String _locationFeaturesKey = 'locationFeatures';

  LocationNotifier() {
    _loadLocationStatus();
    _loadLocationFeatures();
    if (locationFeatures == false) {
      resetLocationStatus();
    }
  }

  int get locationStatus => _locationStatus;

  void setLocationStatus(int locationStatus) {
    _locationStatus = locationStatus;
    _saveLocationStatus(locationStatus);
    notifyListeners();
  }

  void _loadLocationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final locationStatusInt = prefs.getInt(_locationStatusKey) ?? 0;
    _locationStatus = locationStatusInt;
    notifyListeners();
  }

  void _saveLocationStatus(int locationStatus) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_locationStatusKey, locationStatus);
  }

  void resetLocationStatus() {
    _locationStatus = 0;
    _saveLocationStatus(0);
    notifyListeners();
  }

  bool get locationFeatures => _locationFeatures;

  void setLocationFeatures(bool locationFeatures) {
    _locationFeatures = locationFeatures;
    _saveLocationFeatures(locationFeatures);
    notifyListeners();
  }

  void _loadLocationFeatures() async {
    final prefs = await SharedPreferences.getInstance();
    final locationFeaturesBool = prefs.getBool(_locationFeaturesKey) ?? true;
    _locationFeatures = locationFeaturesBool;
    notifyListeners();
  }

  void _saveLocationFeatures(bool locationFeatures) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_locationFeaturesKey, locationFeatures);
  }
}