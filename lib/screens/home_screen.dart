import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masajid_near_you/screens/masajid_screen.dart';
import 'package:masajid_near_you/screens/setting_screen.dart';
import 'package:masajid_near_you/services/get_location.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabPosition = 0;

  List<Widget> _tabBodies = [MasajidScreen(), SettingScreen()];

  @override
  void initState() {
    getUserPosition();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: _currentTabPosition,
          onTap: (i) => setState(() => _currentTabPosition = i),
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home_outlined, size: 30),
            ),
            BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(Icons.settings_outlined, size: 30))
          ],
        ),
        // appBar: AppBar(
        //   title: Text(_tabTitles[_currentTabPosition]),
        // ),
        body: _tabBodies[_currentTabPosition]);
  }
}
