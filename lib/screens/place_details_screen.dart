import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailScreenArgs args =
        ModalRoute.of(context).settings.arguments as DetailScreenArgs;
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PlatformMap(
              initialCameraPosition: CameraPosition(
                target: args.userPosition,
                zoom: 16.0,
              ),
              markers: Set<Marker>.of(
                [
                  Marker(
                    markerId: MarkerId('marker_1'),
                    position: args.userPosition,
                    consumeTapEvents: true,
                    infoWindow: InfoWindow(
                      title: args.placeName,
                    ),
                    onTap: () {
                      print("Marker tapped");
                    },
                  ),
                ],
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: (location) => print('onTap: $location'),
              onCameraMove: (cameraUpdate) =>
                  print('onCameraMove: $cameraUpdate'),
              compassEnabled: true,
              onMapCreated: (controller) {
                Future.delayed(Duration(seconds: 2)).then(
                  (_) {
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          bearing: 270.0,
                          target: args.userPosition,
                          tilt: 30.0,
                          zoom: 18,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    args.placeName,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Intro",
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        args.distanceString,
                        style: TextStyle(
                            color: Color(0XFF002366),
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      RaisedButton.icon(
                        color: Color(0XFF002366),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        icon: Icon(
                          Icons.near_me,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Get Directions",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          if (Platform.isIOS) {
                            MapsLauncher.launchQuery(
                                "comgooglemaps://?saddr=&daddr=${args.userPosition.latitude},${args.userPosition.longitude}&directionsmode=driving");
                          } else if (Platform.isAndroid) {
                            MapsLauncher.launchCoordinates(
                                args.userPosition.latitude,
                                args.userPosition.longitude);
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailScreenArgs {
  final LatLng userPosition;
  final String placeName;
  final String distanceString;

  DetailScreenArgs(this.userPosition, this.placeName, this.distanceString);
}
