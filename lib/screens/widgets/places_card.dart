import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

import '../../constants.dart';
import '../place_details_screen.dart';

class PlaceCard extends StatelessWidget {
  var place;
  PlaceCard(this.place);
  @override
  Widget build(BuildContext context) {
//    var place;

//    restaurant == null ? place = store : place = restaurant;
    // Showing Kilometers as distance if it's more than 1000 meters, meters otherwise
    var distanceString = "";
    if (place.distance < 1000) {
      distanceString = place.distance.toInt().toString() + " meters";
    } else {
      distanceString = (place.distance / 1609).toStringAsFixed(2) + " miles";
    }
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed("/details",
          arguments: DetailScreenArgs(
              LatLng(place.latLng.latitude, place.latLng.longitude),
              place.name,
              distanceString)),
      child: Card(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          child: Container(
            height: 100,
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(8),
                    child: FadeInImage.assetNetwork(
                      image: place.imageSrc,
                      placeholder: "assets/halal1.png",
                      height: 80,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (BuildContext context,
                          Object exception, StackTrace stackTrace) {
                        return Image.asset("assets/halal1.png");
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        place.name.length > 80
                            ? place.name.substring(0, 80) + '...'
                            : place.name,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(distanceString,
                                    style: TextStyle(
                                        color: Color(0XFF002366),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  place.vicinity.split(",").last.trim(),
                                  style: TextStyle(
                                      color: Color(0XFF002366), fontSize: 12),
                                  textAlign: TextAlign.end,
                                )),
                            Icon(
                              Icons.location_on,
                              color: kActiveIconColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
