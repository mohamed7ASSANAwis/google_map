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

class PolyLine{
  final int Polylineid;
  final String Polylinename;
  final LatLng PolylinelatLng;

  PolyLine(this.Polylineid, this.Polylinename, this.PolylinelatLng);

}
List<PolyLine> PolyLineplace=[
  PolyLine(1, "صيدلية الدكتور عمرو عبد التواب", LatLng(29.9026430088765, 29.920074565430372)),
  PolyLine(2, "ملعب عائله داوود", LatLng(29.366625458915525, 31.87115774919671)),
  PolyLine(3, "الهرم", LatLng(28.86753928363977, 30.406928559361596))
];