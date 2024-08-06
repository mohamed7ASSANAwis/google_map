import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
        zoom: 10,
        target: LatLng(
          29.054357700053103,
          31.156642102513437,
        ));
    super.initState();
  }

  late GoogleMapController googleMapController;

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            //mapType: MapType.hybrid,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapstyle();
            },
            //  cameraTargetBounds: CameraTargetBounds(LatLngBounds(northeast:LatLng(31.335475153105723,31.277650507997336, ) ,southwest:LatLng(31.13000568395708, 30.97950683212612) )),
            initialCameraPosition: initialCameraPosition),
        Positioned(
          right: 16,
          left: 16,
          bottom: 16,
          child: ElevatedButton(
              onPressed: () {
                googleMapController.animateCamera(CameraUpdate.newLatLng(
                    LatLng(31.072308396346227, 29.933525474820893)));
              },
              child: Text("Change Location")),
        )
      ],
    );
  }

  void initMapstyle() async {
    var nightStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_style/map_style_night.json");
    googleMapController.setMapStyle(nightStyle);
  }
}

//zoom world view 0=>3
//zoom country  view 4=>6
//zoom city view 10=>12
//zoom street view 13=>17
//zoom builde view 18=>20
