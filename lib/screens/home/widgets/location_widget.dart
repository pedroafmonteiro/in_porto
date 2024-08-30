import 'package:flutter/material.dart';
import 'package:in_porto/notifiers/location_notifier.dart';

class LocationWidget extends StatefulWidget {
  final LocationNotifier locationNotifier;

  const LocationWidget({super.key, required this.locationNotifier});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.12,
            right: MediaQuery.of(context).size.width * 0.025,
          ),
          child: Material(
              color: Theme.of(context).primaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              elevation: 6,
              child: IconButton(
                onPressed: () async {
                  await widget.locationNotifier.locationService?.updateLocationStatus();
                },
                icon: _iconStatus(widget.locationNotifier.locationStatus),
                color: Theme.of(context).iconTheme.color,
              )),
        ),
      ),
    );
  }

  Icon _iconStatus(int status) {
    switch (status) {
      case 1:
        return Icon(Icons.location_disabled_rounded,
            color: Theme.of(context).colorScheme.error);
      case 2:
        return const Icon(Icons.location_searching_rounded,
            color: Colors.deepOrange);
      case 3:
        return const Icon(Icons.location_searching_rounded,
            color: Colors.deepOrange);
      case 4:
        return const Icon(Icons.my_location_rounded);
      default:
        return Icon(
          Icons.not_listed_location_outlined,
          color: Theme.of(context).colorScheme.error,
        );
    }
  }
}
