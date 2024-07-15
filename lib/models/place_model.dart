import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel{

 final int id;
 final String name;
 final LatLng latLong;

  PlaceModel({required this.id, required this.name, required this.latLong});

}

List<PlaceModel> places=[
  PlaceModel(id: 1, name:'نادي الاتحاد السكندري', latLong:const LatLng(31.20757846499209, 29.91985050938153)),
  PlaceModel(id: 2, name:"الابراهيمية", latLong:const LatLng(31.211981022403258, 29.92680691280794) ),
  PlaceModel(id: 3, name:'سموحة', latLong:const LatLng(31.215782024809478, 29.941547964917735))
];

