import 'package:flutter/material.dart';

import '../../../parsers/gtfs_parser.dart';
import '../../../utils/file_utils.dart';

class ParseDataWidget extends StatelessWidget {
  const ParseDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        _parseData();
      },
    );
  }

  void _parseData() async {
    final fileUtils = FileUtils();
    final folderPath = await fileUtils.getLocalPath();

    final parser = GTFSParser('$folderPath/metro_do_porto');

    final agency = await parser.parseAgency();

    print('Agency: $agency');
  }
}
