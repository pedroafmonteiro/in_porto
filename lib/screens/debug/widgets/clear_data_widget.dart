import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/markers_provider.dart';

class ClearDataWidget extends StatelessWidget {
  const ClearDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final markersProvider = Provider.of<MarkersProvider>(context);

    return ListTile(
      title: Text(
        'Clear data',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      leading: Icon(
        Icons.delete_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: markersProvider.clearMarkers,
    );
  }
}
