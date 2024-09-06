import 'package:flutter/material.dart';
import '../services/download_service.dart';
import '../services/ckan_service.dart';
import '../utils/file_utils.dart';

class GTFSProvider extends ChangeNotifier {
  final CKANService _ckanService;
  final DownloadService _downloadService;
  final FileUtils _fileUtils;

  GTFSProvider(this._ckanService, this._downloadService, this._fileUtils);

  Future<void> fetchGTFSData(String datasetId, String folderName) async {
    final url = await _ckanService.fetchGTFSUrls(datasetId);
    final fileName = url.split('/').last;
    final file = await _downloadService.downloadFile(url, fileName);
    final localPath = await _fileUtils.getLocalPath();
    final folderPath = '$localPath/$folderName';
    await _fileUtils.createFolder(folderPath);
    await _fileUtils.unzipFile(file, folderPath);
    notifyListeners();
  }
}