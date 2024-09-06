import 'dart:io';

class GTFSParser {
  final String folderPath;

  GTFSParser(this.folderPath);

  Future<List<Map<String, String>>> _parseFile(String fileName) async {
    final file = File('$folderPath/$fileName');
    final lines = await file.readAsLines();
    final headers = lines.first.split(',');

    return lines.skip(1).map((line) {
      final values = line.split(',');
      return Map.fromIterables(headers, values);
    }).toList();
  }

  Future<List<Map<String, String>>> parseAgency() async {
    return _parseFile('agency.txt');
  }

  Future<List<Map<String, String>>> parseCalendar() async {
    return _parseFile('calendar.txt');
  }

  Future<List<Map<String, String>>> parseRoutes() async {
    return _parseFile('routes.txt');
  }

  Future<List<Map<String, String>>> parseShapes() async {
    return _parseFile('shapes.txt');
  }

  Future<List<Map<String, String>>> parseStopTimes() async {
    return _parseFile('stop_times.txt');
  }

  Future<List<Map<String, String>>> parseStops() async {
    return _parseFile('stops.txt');
  }

  Future<List<Map<String, String>>> parseTrips() async {
    return _parseFile('trips.txt');
  }
}