import 'package:ctreate_google_map/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class CustomsCameraPosition extends StatefulWidget {
  const CustomsCameraPosition({super.key});

  @override
  State<CustomsCameraPosition> createState() => _CustomsCameraPositionState();
}

class _CustomsCameraPositionState extends State<CustomsCameraPosition> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
        zoom: 8,
        target: LatLng(
            29.34044382696969, 31.207237982889264
        ));
    initMarkers();
    initPolyLine();
   // initPolyGonse();
    super.initState();
  }

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polyLine = {};

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  // Future<Uint8List>getImageFromRawData(String image,double widget)async{
  //   var imageData=await rootBundle.load(image);
  //   var imageCode=await ui.instantiateImageCodec(
  //     imageData.buffer.asUint8List(),
  //     targetWidth: widget.round(),
  //
  //   );
  //   var imageFrame=await imageCode.getNextFrame();
  //   var imageByteData=await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
  //   return imageByteData!.buffer.asUint8List();
  // }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polylines: polyLine,
            markers: markers,
            //mapType: MapType.hybrid,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapstyle();
            },
            //  cameraTargetBounds: CameraTargetBounds(LatLngBounds(northeast:LatLng(31.335475153105723,31.277650507997336, ) ,southwest:LatLng(31.13000568395708, 30.97950683212612) )),
            initialCameraPosition: initialCameraPosition),
        // Positioned(
        //   right: 16,
        //   left: 16,
        //   bottom: 16,
        //   child: ElevatedButton(
        //       onPressed: () {
        //         googleMapController.animateCamera(CameraUpdate.newLatLng(
        //             LatLng(31.072308396346227, 29.933525474820893)));
        //       },
        //       child: Text("Change Location")),
        // )
      ],
    );
  }

  void initMapstyle() async {
    var nightStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_style/map_style_night.json");
    googleMapController.setMapStyle(nightStyle);
  }

  void initMarkers() async {
    // var customMarkerIcon=BitmapDescriptor.fromBytes(
    //
    //   await getImageFromRawData("assets/images/location-icon.jpg", 100)
    // );
    var iconsBitMap = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/icon_location1.png");
    var myMarkers = await place
        .map((placeModel) => Marker(
            icon: iconsBitMap,
            infoWindow: InfoWindow(title: placeModel.name.toString()),
            markerId: MarkerId(placeModel.id.toString()),
            position: placeModel.latLng))
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }

  void initPolyLine() {
    var polyline= Polyline(
      visible: true,
      endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        width: 5,
        geodesic: true,
        zIndex: 5,
        color: Colors.red,
        polylineId: PolylineId("1"),
    
    points: [
      LatLng(30.00809441992408, 31.236445320751628),
      LatLng(29.34530526191757, 31.19633184021425),
      LatLng(29.31912731024233, 30.840243604224472),
    ]
    );
    var polyline1= Polyline(
        zIndex: 1,
        polylineId: PolylineId("2"),

        points: [
          LatLng(29.97787260473582, 30.718191971012264),
          LatLng(28.9930620676505, 31.58073567737086),

        ]
    );
    polyLine.add(polyline);
    polyLine.add(polyline1);
  }

  // void initPolyGonse() {}
}

//zoom world view 0=>3
//zoom country  view 4=>6
//zoom city view 10=>12
//zoom street view 13=>17
//zoom builde view 18=>20
