import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';


// NOTES : 
// 1. DM ME FOR FULL PROJECT CODE
// 2. YOU NEED TO HAVE BILLING ACCOUNT ON GOOGLE PLATFORM
// 3. STAR THIS REPOSITORY
// 4. FOLLOW ME ON INSTAGRAM : [https://www.instagram.com/abhishvek/]

class ShowRoutesView extends StatefulWidget {
  @override
  State<ShowRoutesView> createState() => _ShowRoutesViewState();
}

class _ShowRoutesViewState extends State<ShowRoutesView> {
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  final Set<Polyline> _polylines = <Polyline>{};
  GoogleMapController? googleMapController;

  Location? location;

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    location = Location();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ZOOM = 12;

    LatLng? currentLatLong =
        Provider.of<LocationNotifier>(context, listen: true).currentLatLng;
    String API_KEY = "API_KEY";

    void setPolylines() async {
      LatLng desLatLng = "SOME_LATLNG";

      LatLng myLocationLatLng = "SOME_LATLNG";

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          API_KEY,
          PointLatLng(desLatLng.latitude, desLatLng.longitude),
          PointLatLng(myLocationLatLng.latitude, myLocationLatLng.longitude));

      if (result.status == 'OK') {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        setState(() {
          _polylines.add(Polyline(
              polylineId: const PolylineId('id'),
              points: polylineCoordinates));
        });
      }
    }

    LatLng desLatLng = "SOME_LATLNG";
    
    Marker desMarker = Marker(
        infoWindow: const InfoWindow(title: "Destination point"),
        markerId: MarkerId(YOUR_OBJECT.toString()),
        position: desLatLng);
    Marker myLocationMarker = Marker(
        infoWindow: const InfoWindow(title: "My location"),
        markerId: MarkerId(currentLatLong.toString()),
        position: currentLatLong!);
    
    Set<Marker> marker = {desMarker, myLocationMarker};

    Completer<GoogleMapController> _controller = Completer();

    return Scaffold(
        body: Expanded(child: Consumer2<LocationNotifier, YourCustomNotifier>(
                builder: ((context, locationNotifier, kNotifier, child) {
                  return GoogleMap(
                    scrollGesturesEnabled: true,
                    buildingsEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    onTap: (latLng) {
                      _polylines.clear();
                      polylineCoordinates.clear();
                      setPolylines();
                      locationNotifier.animateToCamera(
                          isCurrent: false,
                          zoom: 12,
                          otherLatLng: latLng,
                          controller: googleMapController!);
                    },
                    polylines: _polylines,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: marker,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target: currentLatLong,
                        zoom: ZOOM),
                    onMapCreated: (GoogleMapController mainController) {
                      _controller.complete(mainController);
                      googleMapController = mainController;
                      setPolylines();
                    },
                  );
                }),
              ))
  }
}
