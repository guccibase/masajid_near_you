import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionChangeNotifier extends ChangeNotifier {
  Position position;

  Future<Null> updatePosition() async {
    var newPosition = await Geolocator.getCurrentPosition();
    position = newPosition;
    notifyListeners();
  }
}
