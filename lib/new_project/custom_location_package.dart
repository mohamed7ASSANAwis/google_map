import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomLocationPackage extends StatefulWidget {
  const CustomLocationPackage({super.key});

  @override
  State<CustomLocationPackage> createState() => _CustomLocationPackageState();
}

class _CustomLocationPackageState extends State<CustomLocationPackage> {
  late CameraPosition initialCameraPosition;
  late Location location;
  Set<Marker> markers = {};
  GoogleMapController? googleMapController;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
        zoom: 8, target: LatLng(29.34044382696969, 31.207237982889264));

    getUpDataLocation();
    location = Location();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        googleMapController = controller;
        location.onLocationChanged.listen((locationData) {});
      },
      markers: markers,
      initialCameraPosition: initialCameraPosition,
    );
  }

  Future<void> checkAndRequestLocationService() async {
    var isSeviceEnabled = await location.serviceEnabled();
    if (!isSeviceEnabled) {
      await location.requestService();
    }
    checkAndRequestLocationServicePermission();
  }

  Future<bool> checkAndRequestLocationServicePermission() async {
    var permissionStatue = await location.hasPermission();
    if (permissionStatue == await PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatue == await PermissionStatus.denied) {
      permissionStatue = await location.requestPermission();
    }
    if (permissionStatue != PermissionStatus.granted) {
      return false;
    }
    return true;
  }

  void getLocationData() {
    location.onLocationChanged.listen((locationDatal) async {
      var iconsBitMap = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), "assets/images/icon_location1.png");
      var myLocationMaker = Marker(
          icon: iconsBitMap,
          markerId: const MarkerId('my_location_marker'),
          position: LatLng(locationDatal.latitude!, locationDatal.longitude!));
      markers.add(myLocationMaker);
      setState(() {});
      var cameraPosition = CameraPosition(
          target: LatLng(locationDatal.latitude!, locationDatal.longitude!),
          zoom: 50);
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  void getUpDataLocation() async {
    await checkAndRequestLocationService();
    var hasPermission = await checkAndRequestLocationServicePermission();
    if (hasPermission) {
      getLocationData();
    } else {}
  }
}
