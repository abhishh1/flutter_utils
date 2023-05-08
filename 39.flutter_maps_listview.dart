import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class MapData {
  final int index;
  final String title;
  final String descripton;
  final LatLng latLng;

  const MapData(
      {required this.index,
      required this.title,
      required this.descripton,
      required this.latLng});
}

class MapCameraListviewAnimationNotifier extends ChangeNotifier {
  MapData? selectedMapData;

  Marker? _selectedPlaceData;
  Marker? get selectedPlaceData => _selectedPlaceData;

  void setMarker({required LatLng latLng}) {
    MarkerId markerId = MarkerId(latLng.toString());
    Marker marker = Marker(markerId: markerId, position: latLng);
    _selectedPlaceData = marker;
    notifyListeners();
  }

  setListData({required MapData mapData}) {
    selectedMapData = mapData;
    notifyListeners();
  }
}

class FlutterListviewAnimationOnMapView extends StatefulWidget {
  const FlutterListviewAnimationOnMapView({super.key});

  @override
  State<FlutterListviewAnimationOnMapView> createState() =>
      _FlutterListviewAnimationOnMapViewState();
}

class _FlutterListviewAnimationOnMapViewState
    extends State<FlutterListviewAnimationOnMapView> {
  final Completer<GoogleMapController> _controller = Completer();

  MapCameraListviewAnimationNotifier markerNotifier({required bool renderUI}) =>
      Provider.of<MapCameraListviewAnimationNotifier>(context,
          listen: renderUI);

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    List<MapData> data = [
      MapData(
          index: 0,
          title: "Haldirams",
          descripton: "Some demo description",
          latLng: LatLng(12.9721, 77.5961)),
      MapData(
          index: 1,
          title: "Kotha Kachori",
          descripton: "Some demo description",
          latLng: LatLng(12.9621, 77.6012)),
      MapData(
          index: 2,
          title: "Burger King",
          descripton: "Some demo description",
          latLng: LatLng(12.85, 77.57)),
    ];

    showList() {
      return SizedBox(
        height: 100,
        width: 500,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            MapData mapData = data[index];
            bool isSelectedData =
                markerNotifier(renderUI: true).selectedMapData == mapData;
            return GestureDetector(
              onTap: () {
                markerNotifier(renderUI: false).setListData(mapData: mapData);
                markerNotifier(renderUI: false)
                    .setMarker(latLng: mapData.latLng);
                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                        CameraPosition(target: mapData.latLng, zoom: 14)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: KConstantColors.bgColor,
                      borderRadius: BorderRadius.circular(12)),
                  height: isSelectedData ? 100 : 120,
                  width: 300,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 100,
                            child: Center(child: Icon(Icons.food_bank_sharp)),
                            width: 100,
                            decoration: BoxDecoration(
                                color: KConstantColors.depthWiteColor,
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(mapData.title,
                              style: KConstantTextstyles.bold(fontSize: 12)),
                          Text(mapData.descripton,
                              style: KConstantTextstyles.light(fontSize: 10)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showList(),
        backgroundColor: KConstantColors.bgColor,
        body: Container(
          child: GoogleMap(
              onTap: (latLng) {
                markerNotifier(renderUI: false).setMarker(latLng: latLng);
                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                        CameraPosition(target: latLng, zoom: 12)));
              },
              myLocationEnabled: true,
              markers: Set.from(
                  markerNotifier(renderUI: true).selectedPlaceData != null
                      ? [markerNotifier(renderUI: true).selectedPlaceData]
                      : []),
              mapToolbarEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: LatLng(12.9716, 77.5946), zoom: 12),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                googleMapController = controller;
              }),
        ));
  }
}
