import 'package:flutter/material.dart';
import 'package:google_map_project/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();

}
  
class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController changeLocationController;
  late GoogleMapController googleMapStyleController;
  Set<Marker> markers={};
  Set<Polyline> polyLines={};
  Set<Polygon> polygons={};
  Set<Circle> circles={};
  late Location location;

  @override
  void initState() {
    super.initState();
    initialCameraPosition=const CameraPosition(
        target: LatLng(31.22862207487429, 29.954252143930425),
        zoom: 11);
    //initMarkers();
    //initPolyLines();
    //initPolygon();
    //initCircles();
    location=Location();
   updateMyLocation();
  }
  @override
  void dispose() {
    changeLocationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPosition,
          cameraTargetBounds: CameraTargetBounds(
            LatLngBounds(
                southwest:const LatLng(31.080569617326795, 29.212345938519148),
                northeast:const LatLng(31.24741374628074, 30.15299239457197) ),),
          //mapType: MapType.normal ,   //default type
          onMapCreated:(controller){
            googleMapStyleController=controller;
            initMapStyle();
            //changeLocationController=controller;
          },
          //markers: markers,
          //polylines: polyLines,
          polygons: polygons,
          circles: circles,
          //zoomControlsEnabled: false,

        ),
        // Positioned(
        //    bottom: 16,
        //     right: 32,
        //     left: 32,
            // child: ElevatedButton(onPressed: (){
            //   changeLocationController.animateCamera(CameraUpdate.newLatLng(
            //      const LatLng(31.352676581272963, 32.21456098710738)));
            // },
            //   child:const Text("Change location"),))
      ],
    );
  }

  void  initMapStyle()async{
    var nightStyle= await DefaultAssetBundle.of(context).
    loadString('assets/google)map_styles/night_map_style.json');
    googleMapStyleController.setMapStyle(nightStyle);
  }

  void initMarkers() async{
    var customMarkerIcon=await BitmapDescriptor.fromAssetImage(const ImageConfiguration(),'assets/images/marker.png');
    var myMarker= places.map((PlaceModel) => Marker(
      markerId: MarkerId(PlaceModel.id.toString()),
      position: PlaceModel.latLong,
      infoWindow: InfoWindow(title: PlaceModel.name),
      icon: customMarkerIcon,
    )
    ).toSet();
    markers.addAll(myMarker);
    setState(() {});
  }

  void initPolyLines() {
    Polyline polyLine=const Polyline(polylineId: PolylineId('1'),
      width: 5,
      color: Colors.blue,
      startCap: Cap.roundCap,
      points: [
        LatLng(31.16511342578901, 29.894423547507312),
        LatLng(31.184646406129676, 29.906327659251936),
        LatLng(31.208576520878356, 29.90926611062312),
        LatLng(31.217228052822573, 29.93063012238412),
      ]);
    polyLines.add(polyLine);
  }

  void initPolygon() {
    Polygon polygon=Polygon(
      polygonId:const PolygonId("1"),
      fillColor: Colors.black.withOpacity(.5),
      strokeWidth: 3,
      points:const [
        LatLng(31.184785994931175, 29.906196132305343),
        LatLng(31.208017069552334, 29.909250071479867),
        LatLng(31.208576520878356, 29.90926611062312),
        LatLng(31.206540530734017, 29.939381934571955),
      ]
    );
    polygons.add(polygon);
  }

  void initCircles() {
    Circle kushariAboTarekCircle= Circle(circleId:const CircleId("1"),
      center:  const LatLng(30.050678384356267, 31.236686277815885),
      fillColor: Colors.black.withOpacity(.5),
      radius: 5000,

    );
    circles.add(kushariAboTarekCircle);
  }

  Future<void> checkAndRequestLocationService() async{
    var isServiceEnabled=await location.serviceEnabled();
    if(!isServiceEnabled){
      isServiceEnabled=await location.requestService();
      if(!isServiceEnabled){
        //ToDo:show error message
      }
    }
  }

  Future<bool> checkAndRequestPermission() async{
    var permissionStatus=await location.hasPermission();
    if(permissionStatus == PermissionStatus.deniedForever){
      return false;
    }
    if(permissionStatus == PermissionStatus.denied){
      permissionStatus=await location.requestPermission();
      if(permissionStatus !=PermissionStatus.granted){
        return false;
      }
    }
   return true;
  }

  void getLocationData(){
    location.onLocationChanged.listen((locationData) { });

  }

  void updateMyLocation() async{
    await checkAndRequestLocationService();
   var hasPermission= await checkAndRequestPermission();
   if(hasPermission){
     getLocationData();
   }
   else{}
  }
}


// zoom ranges levels
//World wide 0_3
//country  4_6
//City 10_12
//streets 13_17
//buildings 18_20

//Steps for the user location
//inquire about location service enabled or not from setting
//request permissions
//get user location
//display