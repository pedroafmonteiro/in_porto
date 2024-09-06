import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DownloadService {
  Future<File> downloadFile(String url, String filename) async {
    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();
    final file =  File('${directory.path}/$filename');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}