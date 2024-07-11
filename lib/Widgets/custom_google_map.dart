import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();

}
  
class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  @override
  void initState() {
    super.initState();
    initialCameraPosition=const CameraPosition(
        target: LatLng(31.22862207487429, 29.954252143930425),
        zoom: 10);
  }
  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        GoogleMap(
          onMapCreated:(controller){
            googleMapController=controller;
          },
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                  southwest:const LatLng(30.84251633919994, 28.988978487685046),
                  northeast:const LatLng(35.096699046946114, 39.400997145628594) ),),
            initialCameraPosition: initialCameraPosition),
        Positioned(
           bottom: 16,
            right: 32,
            left: 32,
            child: ElevatedButton(onPressed: (){
              googleMapController.animateCamera(CameraUpdate.newLatLng(
                 const LatLng(27.43553057321461, 33.88746908761552)));
            },
              child:const Text("Change location"),))
      ],
    );
  }
}
// zoom ranges levels
//World wide 0_3
//country  4_6
//City 10_12
//streets 13_17
//buildings 18_20