//using haversine formular to calculate distance between two geo-coordinates
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

double coordinateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

double calucateTotalDistance(List<LatLng> polylineCoordinates) {
  double totalDistance = 0.0;

// Calculating the total distance by adding the distance
// between small segments
  for (int i = 0; i < polylineCoordinates.length - 1; i++) {
    totalDistance += coordinateDistance(
      polylineCoordinates[i].latitude,
      polylineCoordinates[i].longitude,
      polylineCoordinates[i + 1].latitude,
      polylineCoordinates[i + 1].longitude,
    );
  }
  return totalDistance;
}

LatLngBounds latLngBounds(LatLng p1, LatLng p2) {
  // Calculating to check that the position relative
// to the frame, and pan & zoom the camera accordingly.
  double miny = (p1.latitude <= p2.latitude) ? p1.latitude : p2.latitude;
  double minx = (p1.longitude <= p2.longitude) ? p1.longitude : p2.longitude;
  double maxy = (p1.latitude <= p2.latitude) ? p2.latitude : p1.latitude;
  double maxx = (p1.longitude <= p2.longitude) ? p2.longitude : p1.longitude;

  double southWestLatitude = miny;
  double southWestLongitude = minx;

  double northEastLatitude = maxy;
  double northEastLongitude = maxx;
  return LatLngBounds(
    northeast: LatLng(northEastLatitude, northEastLongitude),
    southwest: LatLng(southWestLatitude, southWestLongitude),
  );
}
