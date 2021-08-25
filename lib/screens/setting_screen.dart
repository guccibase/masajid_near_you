import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

enum Availability { LOADING, AVAILABLE, UNAVAILABLE }

extension on Availability {
  String stringify() => this.toString().split('.').last;
}

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int masajidRadius = 20;
  int foodPlacesRadius = 20;

  List<int> milesList = [5, 10, 15, 20, 25, 30];
  final InAppReview _inAppReview = InAppReview.instance;
  String _appStoreId = '1548627340';
  String _microsoftStoreId = '';
  Availability _availability = Availability.LOADING;

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
        microsoftStoreId: _microsoftStoreId,
      );

  void _onShare(BuildContext context) async {
    String appLink = Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=com.umratech.places"
        : "https://apps.apple.com/us/app/halal-places/id1548627340";
    String subject =
        "Assalaamu Alaikum, checkout this app. It's ads free and privacy focused";
    final box = context.findRenderObject() as RenderBox;

    await Share.share(appLink,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    super.initState();
    setPreExistingData();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          _availability = isAvailable && Platform.isAndroid
              ? Availability.AVAILABLE
              : Availability.UNAVAILABLE;
        });
      } catch (e) {
        setState(() => _availability = Availability.UNAVAILABLE);
      }
    });
  }

  setPreExistingData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int masajidRadiusInStorage = pref.getInt("masajidRadius") ?? 20;
    setState(() {
      masajidRadius = masajidRadiusInStorage;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(
              height: height / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/6.png'), fit: BoxFit.cover)),
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text("Masjid Radius (Miles)"),
            leading: SvgPicture.asset(
              "assets/masjid_icon.svg",
              height: 20,
              color: Colors.grey,
            ),
            trailing: DropdownButton<int>(
              value: masajidRadius,
              items: milesList.map((value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: _changeMasajidRadius,
            ),
          ),
          Divider(height: 1),
        ],
      ),
    );
  }

  void _changeMasajidRadius(int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(keyMasajidRadius, value);
    setState(() {
      masajidRadius = value;
    });
  }
}
