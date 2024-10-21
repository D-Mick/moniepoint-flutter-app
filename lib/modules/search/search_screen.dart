import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moniepointflutterapp/config/app_constants.dart';
import 'package:moniepointflutterapp/shared/res/themes/light.dart';
import 'package:moniepointflutterapp/shared/widgets/map/animated_map_marker.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'dart:async';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final _googleMapController = Completer<GoogleMapController>(); // Manages Google Map Controller
  String _customMapStyle = ''; // Stores the JSON map style
  bool _areMarkersVisible = false; // Controls visibility of markers and UI animations
  bool _isOptionsMenuVisible = false; // Controls visibility of the options menu

  /// Loads the custom map style from a local JSON file
  Future<void> _loadCustomMapStyle() async {
    final String style =
    await rootBundle.loadString('assets/files/map_style.json');
    setState(() {
      _customMapStyle = style;
    });
  }

  // Initial camera position focused on a specific coordinate with zoom level 16
  final CameraPosition _defaultCameraPosition = const CameraPosition(
    target: LatLng(6.6025926099405226, 3.2849539756822987),
    zoom: 16,
  );

  final Set<Marker> _mapMarkers = {}; // Holds all map markers

  /// Adds markers to the map with a slight delay for animation effect
  Future<void> _populateMarkers() async {
    await Future.delayed(const Duration(milliseconds: 600));
    _mapMarkers.addAll({
      Marker(
        markerId: const MarkerId('marker_1'),
        position: const LatLng(6.607354, 3.282811),
        icon: await const CustomMapMarker(title: '10,3 mn P').toBitmapDescriptor(),
      ),
      Marker(
        markerId: const MarkerId('marker_2'),
        position: const LatLng(6.605701, 3.283308),
        icon: await const CustomMapMarker(title: '11 mn P').toBitmapDescriptor(),
      ),
      Marker(
        markerId: const MarkerId('marker_3'),
        position: const LatLng(6.604992, 3.287754),
        icon: await const CustomMapMarker(title: '7,8 mn P').toBitmapDescriptor(),
      ),
      Marker(
        markerId: const MarkerId('marker_4'),
        position: const LatLng(6.602455, 3.287775),
        icon: await const CustomMapMarker(title: '8,5 mn P').toBitmapDescriptor(),
      ),
      Marker(
        markerId: const MarkerId('marker_5'),
        position: const LatLng(6.600324, 3.283097),
        icon: await const CustomMapMarker(title: '13,3 mn P').toBitmapDescriptor(),
      ),
      Marker(
        markerId: const MarkerId('marker_6'),
        position: const LatLng(6.597686, 3.286839),
        icon: await const CustomMapMarker(title: '6,95 mn P').toBitmapDescriptor(),
      ),
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCustomMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map widget displaying the map with markers and style
          GoogleMap(
            initialCameraPosition: _defaultCameraPosition,
            markers: _mapMarkers,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) async {
              _googleMapController.complete(controller);

              // Delay to animate marker visibility after the map is created
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Future.delayed(const Duration(milliseconds: 1000));
                if (mounted) {
                  setState(() => _areMarkersVisible = true);
                }
              });

              // Populate markers on the map with animation
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await _populateMarkers();
                if (mounted) {
                  setState(() {});
                }
              });
            },
          ),

          // Overlay UI containing search bar and buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar with a toggle button next to it
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedScale(
                          scale: _areMarkersVisible ? 1 : 0,
                          duration: const Duration(milliseconds: 700),
                          child: Container(
                            decoration: BoxDecoration(
                              color: lightTheme.colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Saint Petersburg',
                                hintStyle: TextStyle(
                                    color: lightTheme.colorScheme.surface),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: lightTheme.colorScheme.surface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      AnimatedScale(
                        scale: _areMarkersVisible ? 1 : 0,
                        duration: const Duration(milliseconds: 700),
                        child: Container(
                          decoration: BoxDecoration(
                              color: lightTheme.colorScheme.onPrimary,
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.swap_horiz_rounded,
                              color: lightTheme.colorScheme.surface,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  const Spacer(),

                  // Floating layer button with an animated menu
                  Stack(
                    children: [
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: AnimatedScale(
                          scale: _areMarkersVisible ? 1 : 0,
                          duration: const Duration(milliseconds: 700),
                          child: GestureDetector(
                            onTap: () => setState(() {
                              _isOptionsMenuVisible = true;
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                color: lightTheme.colorScheme.secondaryFixed
                                    .withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(Icons.layers,
                                    color: lightTheme.colorScheme.onPrimary),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          _isOptionsMenuVisible = false;
                        }),
                        child: AnimatedScale(
                          alignment: Alignment.bottomLeft,
                          scale: _isOptionsMenuVisible ? 1 : 0,
                          duration: const Duration(milliseconds: 700),
                          child: Container(
                            decoration: BoxDecoration(
                              color: lightTheme.colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: Constants.menuItems.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          item.icon,
                                          color: item.index == 1
                                              ? lightTheme.colorScheme.primary
                                              : lightTheme.colorScheme.secondaryFixed,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                            color: item.index == 1
                                                ? lightTheme.colorScheme.primary
                                                : lightTheme.colorScheme.secondaryFixed,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: kBottomNavigationBarHeight * 1.4),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
