import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();

}
  
class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController changeLocationController;
  late GoogleMapController googleMapStyleController;
  @override
  void initState() {
    super.initState();
    initialCameraPosition=const CameraPosition(
        target: LatLng(31.22862207487429, 29.954252143930425),
        zoom: 10);
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
          //mapType: MapType.normal ,   //default type
          onMapCreated:(controller){
            googleMapStyleController=controller;
            initMapStyle();
            changeLocationController=controller;
          },
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                  southwest:const LatLng(17.72947819541444, 9.212345938519148),
                  northeast:const LatLng(35.24741374628074, 39.15299239457197) ),),
            initialCameraPosition: initialCameraPosition),
        Positioned(
           bottom: 16,
            right: 32,
            left: 32,
            child: ElevatedButton(onPressed: (){
              changeLocationController.animateCamera(CameraUpdate.newLatLng(
                 const LatLng(31.352676581272963, 32.21456098710738)));
            },
              child:const Text("Change location"),))
      ],
    );
  }

  void  initMapStyle()async{
    var nightStyle= await DefaultAssetBundle.of(context).
    loadString('assets/google)map_styles/night_map_style.json');
    googleMapStyleController.setMapStyle(nightStyle);
  }

}


// zoom ranges levels
//World wide 0_3
//country  4_6
//City 10_12
//streets 13_17
//buildings 18_20