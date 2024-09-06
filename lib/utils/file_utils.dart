import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';

class FileUtils {
  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> createFolder(String path) async {
    final directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }

  Future<void> unzipFile(File file, String destination) async {
    final bytes = file.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    await createFolder(destination);

    for (final file in archive) {
      if (file.isFile) {
        final filename = '$destination/${file.name.split('/').last}';
        final outFile = File(filename);
        await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content as List<int>);
      }
    }
  }

  Future<List<String>> listFilesInDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return _listFilesRecursively(directory);
  }

  Future<List<String>> _listFilesRecursively(Directory directory) async {
    final List<String> files = [];
    await for (var entity in directory.list(recursive: true, followLinks: false)) {
      if (entity is File) {
        files.add(entity.path);
      }
    }
    print('Files in documents directory: $files');
    return files;
  }
}
