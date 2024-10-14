import 'dart:convert';
import 'package:http/http.dart' as http;

class CKANService {
  final String _baseUrl = 'https://opendata.porto.digital';

  CKANService();

  Future<String> fetchGTFSUrls(String datasetId) async {
    final response = await http.get(
        Uri.parse('$_baseUrl/api/3/action/package_show?id=$datasetId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final resources = data['result']['resources'] as List;
      resources.sort((a, b) {
        if (a['last_modified'] == null) return 1;
        if (b['last_modified'] == null) return -1;
        return b['last_modified'].compareTo(a['last_modified']);
      });
      final latestURL = resources.firstWhere((resource) => resource['format'] == 'GTFS')['url'] as String;
      print('Latest GTFS URL: $latestURL');
      return latestURL;
    } else {
      throw Exception('Failed to load dataset');
    }
  }
}