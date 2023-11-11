import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';


class GoogleMapsLocationNotifier extends ChangeNotifier {
  int currentLocation = 1;
  GoogleMapController? googleMapController;
  Marker marker = const Marker(
      markerId: MarkerId("marker"), position: LatLng(28.706534, 77.114825));

  setCurrentLocation({required int kId}) {
    currentLocation = kId;
    notifyListeners();
  }

  animateMapToLocation({required LatLng otherLatLng}) async {
    final pos = CameraPosition(
        target: LatLng(otherLatLng.latitude, otherLatLng.longitude), zoom: 12);
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(pos));
    notifyListeners();
  }

  setMarker({required LatLng latLng}) {
    marker = Marker(markerId: MarkerId(latLng.toString()), position: latLng);
    notifyListeners();
  }
}

class CustomLocation {
  final int locationId;
  final double latitude;
  final double longitude;
  final String locationTitle;

  const CustomLocation({
    required this.latitude,
    required this.longitude,
    required this.locationTitle,
    required this.locationId,
  });
}

class GoogleMapsLocationAnimatorView extends StatelessWidget {
  const GoogleMapsLocationAnimatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemScrollController itemScrollController = ItemScrollController();
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();

    GoogleMapsLocationNotifier googleMapsLocationNotifier(
            {required bool renderUI}) =>
        Provider.of<GoogleMapsLocationNotifier>(context, listen: renderUI);

    Completer<GoogleMapController> _controller = Completer();

    List<CustomLocation> _locations = const [
      CustomLocation(
          latitude: 28.706534,
          longitude: 77.114825,
          locationTitle: "The Red Fort",
          locationId: 1),
      CustomLocation(
          latitude: 28.699608,
          longitude: 77.121696,
          locationTitle: "Qutub Minar",
          locationId: 2),
      CustomLocation(
          latitude: 28.686056,
          longitude: 77.111733,
          locationTitle: "Lodi Gardens",
          locationId: 3),
      CustomLocation(
          latitude: 28.686357,
          longitude: 77.079440,
          locationTitle: "The Lotus Temple",
          locationId: 4)
    ];

    Widget horizontaList() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 400,
          height: 100,
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: _locations.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              CustomLocation customLocation = _locations[index];
              return GestureDetector(
                onTap: () {
                  LatLng newLocation =
                      LatLng(customLocation.latitude, customLocation.longitude);
                  googleMapsLocationNotifier(renderUI: false)
                      .animateMapToLocation(otherLatLng: newLocation);
                  googleMapsLocationNotifier(renderUI: false)
                      .setCurrentLocation(kId: customLocation.locationId);
                  googleMapsLocationNotifier(renderUI: false)
                      .setMarker(latLng: newLocation);
                  itemScrollController.scrollTo(
                      curve: Curves.easeInCubic,
                      index: index,
                      duration: const Duration(milliseconds: 100));
                },
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: googleMapsLocationNotifier(renderUI: true)
                                    .currentLocation ==
                                customLocation.locationId
                            ? KConstantColors.blueColor
                            : KConstantColors.bgColorFaint,
                        borderRadius: BorderRadius.circular(16)),
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(customLocation.locationTitle,
                            style: KCustomTextStyle.kBold(context, 14)),
                        const CircleAvatar(
                          backgroundColor: KConstantColors.bgColor,
                          radius: 16,
                          child: Icon(FontAwesomeIcons.locationArrow, size: 12),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: KConstantColors.bgColorFaint,
              title: Text("Google maps location animator 🚀",
                  style: KCustomTextStyle.kBold(context, 14)),
            ),
            backgroundColor: KConstantColors.bgColor,
            body: Stack(
              children: [
                GoogleMap(
                  markers: <Marker>{
                    googleMapsLocationNotifier(renderUI: false).marker
                  },
                  mapType: MapType.terrain,
                  initialCameraPosition: const CameraPosition(
                      target: LatLng(28.7041, 77.1025), zoom: 16),
                  onMapCreated: (GoogleMapController mainController) {
                    _controller.complete(mainController);
                    googleMapsLocationNotifier(renderUI: false)
                        .googleMapController = mainController;
                  },
                ),
                horizontaList(),
              ],
            )));
  }
}
