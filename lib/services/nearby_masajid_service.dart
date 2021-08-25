import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:masajid_near_you/models/store.dart';

import '../constants.dart';

class NearbyMasajidService {
  final double lat;
  final double lng;
  final int radius;

  NearbyMasajidService(this.lat, this.lng, this.radius);

  Future<List<PlaceModel>> getNearbyMasajid() async {
    final places = GoogleMapsPlaces(apiKey: googleMapsApiKey);

    PlacesSearchResponse response = await places.searchNearbyWithRadius(
      Location(lat: lat, lng: lng),
      radius * 1609, // radius in meters
      type: "mosque",
    );

    List<PlaceModel> masajidList = [];

    response.results.forEach((element) {
      var masjidLocation =
          LatLng(element.geometry.location.lat, element.geometry.location.lng);
      try {
        masajidList.add(
          PlaceModel(
            name: element.name,
            vicinity: element.vicinity,
            imageSrc: element.photos == null
                ? ""
                : "https://maps.googleapis.com/maps/api/place/photo?photoreference=${element.photos.first.photoReference}&sensor=false&maxheight=1000&maxwidth=1000&key=$googleMapsApiKey",
            latLng: LatLng(masjidLocation.latitude, masjidLocation.longitude),
            distance: Geolocator.distanceBetween(
              lat,
              lng,
              masjidLocation.latitude,
              masjidLocation.longitude,
            ),
          ),
        );
      } catch (e) {
        masajidList.add(
          PlaceModel(
            name: element.name,
            vicinity: element.vicinity,
            imageSrc: '',
            latLng: LatLng(masjidLocation.latitude, masjidLocation.longitude),
            distance: Geolocator.distanceBetween(
              lat,
              lng,
              masjidLocation.latitude,
              masjidLocation.longitude,
            ),
          ),
        );
      }
    });

    // For showing masajid closer to user's location on top
    masajidList.sort((a, b) => a.distance.compareTo(b.distance));

    return masajidList;
  }
}
