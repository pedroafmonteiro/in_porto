import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_porto/parsers/gtfs_parser.dart';
import 'package:provider/provider.dart';
import '../../providers/gtfs_provider.dart';
import '../../providers/location_provider.dart';
import '../../services/location_service.dart';
import '../../services/ckan_service.dart';
import '../../services/download_service.dart';
import '../../utils/file_utils.dart';
import 'widgets/map_widget.dart';
import 'widgets/location_widget.dart';
import 'widgets/bottom_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    _fetchData();
    _parseData();
  }

  void _fetchData() async {
    final ckanService = CKANService();
    final downloadService = DownloadService();
    final fileUtils = FileUtils();
    final gtfsProvider = GTFSProvider(ckanService, downloadService, fileUtils);
    await gtfsProvider.fetchGTFSData('horarios-paragens-e-rotas-em-formato-gtfs', 'metro_do_porto');
  }

  void _parseData() async {
    final fileUtils = FileUtils();
    final folderPath = await fileUtils.getLocalPath();

    final parser = GTFSParser('$folderPath/metro_do_porto');

    final agency = await parser.parseAgency();

    print('Agency: $agency');
  }

  @override
  Widget build(BuildContext context) {
    final locationNotifier = Provider.of<LocationNotifier>(context);
    final locationService = LocationService(locationNotifier, context);
    locationNotifier.setLocationService(locationService);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle!
              .systemNavigationBarColor,
          statusBarColor:
              Theme.of(context).appBarTheme.systemOverlayStyle!.statusBarColor,
          statusBarBrightness: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle!
              .statusBarBrightness,
          statusBarIconBrightness: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle!
              .statusBarIconBrightness,
        ),
      ),
      body: Stack(
        children: [
          MapWidget(locationNotifier: locationNotifier),
          Center(child: TextButton(onPressed: _parseData, child: const Text('Parse Data'))),
          if (locationNotifier.locationFeatures)
            LocationWidget(locationNotifier: locationNotifier),
          const BottomWidget()
        ],
      ),
    );
  }
}
