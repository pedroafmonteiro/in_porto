import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../parsers/gtfs_parser.dart';
import '../../../providers/markers_provider.dart';
import '../../../utils/file_utils.dart';

class ParseDataWidget extends StatelessWidget {
  const ParseDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final markersProvider = Provider.of<MarkersProvider>(context);

    return ListTile(
      title: Text(
        'Parse data',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      leading: Icon(
        Icons.code_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () {
        _parseData(markersProvider);
      },
    );
  }

  void _parseData(MarkersProvider markersProvider) async {
    final fileUtils = FileUtils();
    final folderPath = await fileUtils.getLocalPath();

    final parser = GTFSParser('$folderPath/metro_do_porto');

    final stops = await parser.parseStops();
    markersProvider.updateMarkersWithStops(stops);

    print('Stops: $stops');
  }
}
