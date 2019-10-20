import 'package:coding_task/bloc/map_bloc.dart';
import 'package:coding_task/models.dart';
import 'package:coding_task/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  MapBloc mapBloc = new MapBloc();
  LatLng mapCenter = LatLng(37.43296265331129, -122.08832357078792);
  int route = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<Object>(
          stream: mapBloc.response,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return new Loader();

            LatLng
                currentLocation; 
            if (snapshot.data is CurrentLocationResponse) {
              currentLocation = (snapshot.data as CurrentLocationResponse).loc;
            }
            LatLngBounds bbox;
            var polylines;
            if (snapshot.data is RouteResponse) {
              currentLocation = (snapshot.data as RouteResponse).current;
              polylines = Set<Polyline>();
              polylines.add((snapshot.data as RouteResponse).line);
              bbox =null; // will come in the response in real (snapshot.data as RouteResponse).box;
            }

            return Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  mapToolbarEnabled: true,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  cameraTargetBounds:
                      CameraTargetBounds.unbounded, //CameraTargetBounds(bbox),
                  polylines: polylines,
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                    zoom: 19.151926040649414,
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: RaisedButton(
                    onPressed: () =>
                        mapBloc.action.add(PlotRouteEvent(currentLocation)),
                    child: Text("Draw a route"),
                  ),
                )
              ],
            );
          }),
    );
  }
}
