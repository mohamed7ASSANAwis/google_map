import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel{
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel(this.id, this.name, this.latLng);

}
List<PlaceModel> place=[
  PlaceModel(1, "صيدلية الدكتور عمرو عبد التواب", LatLng(29.318965521372764, 31.197362132504512)),
  PlaceModel(2, "ملعب عائله داوود", LatLng(29.323729534873728, 31.20217089930743)),
  PlaceModel(3, "الهرم", LatLng(29.40570310241425, 31.17299377531956))
];