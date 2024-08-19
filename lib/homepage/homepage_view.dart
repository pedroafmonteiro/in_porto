import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.1585561, -8.6125248);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _initializeMapRenderer();
  }

  void _initializeMapRenderer() {
    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.0,
            ),
            zoomControlsEnabled: false,
            compassEnabled: false,
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.2,
              maxChildSize: 0.95,
              snap: true,
              snapSizes: const [0.2, 0.95],
              snapAnimationDuration: Durations.short2,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 5,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Good morning!",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.manrope(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.settings),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search for lines, stops, or routes",
                                  hintStyle: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  prefixIcon: const Icon(Icons.search),
                                ),
                              ),),
                          const Text(""),
                        ],
                      ),
                    ));
              })
        ],
      ),
    );
  }
}
