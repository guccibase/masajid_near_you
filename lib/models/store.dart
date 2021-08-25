import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final String name;
  final String vicinity;
  final double distance;
  final String imageSrc;
  final LatLng latLng;

  PlaceModel(
      {this.name, this.vicinity, this.distance, this.imageSrc, this.latLng});
}
