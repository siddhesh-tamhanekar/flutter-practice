import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  LatLng mapCenter = LatLng(37.43296265331129, -122.08832357078792);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap( 
        mapType: MapType.hybrid,
        mapToolbarEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (controller){
          mapController = controller;
        },

        initialCameraPosition: CameraPosition(
            target: mapCenter,
            zoom: 19.151926040649414),
      ),
    );
  }
}
