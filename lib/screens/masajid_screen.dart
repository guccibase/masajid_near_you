import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:masajid_near_you/common/common_widgets.dart';
import 'package:masajid_near_you/models/store.dart';
import 'package:masajid_near_you/screens/widgets/common.dart';
import 'package:masajid_near_you/screens/widgets/places_card.dart';
import 'package:masajid_near_you/services/nearby_masajid_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class MasajidScreen extends StatefulWidget {
  @override
  _MasajidScreenState createState() => _MasajidScreenState();
}

class _MasajidScreenState extends State<MasajidScreen> {
  double lat;
  double lng;
  int radius = 20;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masajid near you'),
      ),
      body: ProxyProvider0<NearbyMasajidService>(
        update: (context, _) => NearbyMasajidService(lat, lng, radius),
        child: FutureBuilder<Position>(
          future: Geolocator.getCurrentPosition(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color(0XFF002366),
              ));
            } else {
              if (snapshot.hasError) {
                return noLocationDetected(() => setState(() => {}));
              } else {
                var position = snapshot.data;
                return position == null
                    ? Container()
                    : Container(
                        child: FutureProvider(
                          create: (_) async => context
                              .read<NearbyMasajidService>()
                              .getNearbyMasajid(),
                          catchError: (_, error) {
                            print(error);
                          },
                          child: Consumer<List<PlaceModel>>(
                              builder: (_, masajid, child) {
                            return masajid == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: Color(0XFF002366),
                                  ))
                                : (masajid.isEmpty)
                                    ? noResultsWidget()
                                    : RefreshIndicator(
                                        color: Color(0XFF002366),
                                        onRefresh: _getCurrentPosition,
                                        child: ListView.builder(
                                          itemCount: masajid.length,
                                          itemBuilder: (context, index) {
                                            final masjid = masajid[index];
                                            return PlaceCard(masjid);
                                          },
                                        ),
                                      );
                          }),
                        ),
                      );
              }
            }
          },
        ),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    var position = await Geolocator.getCurrentPosition();
    var pref = await SharedPreferences.getInstance();
    var storedRadius = pref.getInt(keyMasajidRadius) ?? 20;
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
      radius = storedRadius;
    });
  }
}
