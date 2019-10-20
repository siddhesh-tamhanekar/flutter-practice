import 'dart:math';

import 'package:coding_task/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapService {
  
  static Future<Response> getCurrentLocation() async {
    var location = new Location();
    try {
      LocationData loc = await location.getLocation();
      return CurrentLocationResponse(LatLng(loc.latitude, loc.longitude));
    } catch (e) {
      print(e);
      if (e.code == "PERMISSION_DENIED")
        return ErrorResponse("User Denied Permission");
      return ErrorResponse(e.code);
    }
  }

  static Future<Response> getRoute(PlotRouteEvent event) async {
    // implement google directions api could not able to used as no more free.
    List<LatLng> routes = [
      event.current,
      MapService.getRandomLocation(event.current, 100)
    ];

    LatLngBounds bounds;

    return RouteResponse(
        Polyline(polylineId: PolylineId("route"), points: routes),
        bounds,
        event.current);
  }

  // function referenced from https://stackoverflow.com/questions/33976732/generate-random-latlng-given-device-location-and-radius
  static LatLng getRandomLocation(LatLng latlng, int radius) {
    double radiusToDegrees = radius / 111000;
    double u = Random().nextDouble();
    double v = Random().nextDouble();
    double w = radiusToDegrees * sqrt(u);
    double t = pi * v;
    double x = w * cos(t);
    double y = w * sin(t);
    double newX = x / cos(latlng.longitude);

    return LatLng(newX + latlng.latitude, y + latlng.longitude);
  }
}
