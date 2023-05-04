import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class MarkerNotifier extends ChangeNotifier {
  bool _singletonMarker = false;
  bool get singletonMarker => _singletonMarker;

  List<Marker> _markers = [];
  List<Marker> get markers => _markers;

  void setMarkerOnMap({required LatLng latLng}) {
    if (_singletonMarker) {
      _markers.clear();
    }

    MarkerId markerId = MarkerId(latLng.toString());
    Marker marker = Marker(markerId: markerId, position: latLng);
    _markers.add(marker);
    notifyListeners();
  }

  void toggleMarkerMode() {
    _singletonMarker = !_singletonMarker;
    notifyListeners();
  }
}

class FlutterMapsMarkerView extends StatefulWidget {
  @override
  State<FlutterMapsMarkerView> createState() => _FlutterMapsMarkerViewState();
}

class _FlutterMapsMarkerViewState extends State<FlutterMapsMarkerView> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController googleMapController;

  MarkerNotifier markerNotifier({required bool renderUI}) =>
      Provider.of<MarkerNotifier>(context, listen: renderUI);

  @override
  Widget build(BuildContext context) {
    bool isSingleMarkerMode = markerNotifier(renderUI: true).singletonMarker;

    return Scaffold(
      appBar: CustomAppBar(title: "Advanced markers"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ActionChip(
          backgroundColor: isSingleMarkerMode
              ? KConstantColors.blueColor
              : KConstantColors.purpleColor,
          label: Text(
            !isSingleMarkerMode ? "Multiple mode" : "Single mode",
            style: KConstantTextstyles.light(fontSize: 12),
          ),
          onPressed: () {
            markerNotifier(renderUI: false).toggleMarkerMode();
          }),
      backgroundColor: KConstantColors.bgColor,
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            child: Container(
              child: GoogleMap(
                  onTap: (latLng) {
                    markerNotifier(renderUI: false)
                        .setMarkerOnMap(latLng: latLng);
                  },
                  myLocationEnabled: true,
                  markers: Set.from(markerNotifier(renderUI: true).markers),
                  mapToolbarEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(12.9716, 77.5946), zoom: 16),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    googleMapController = controller;
                  }),
            ),
          )),
    );
  }
}
