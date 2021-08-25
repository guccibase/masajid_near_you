import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masajid_near_you/screens/place_details_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: Color(0XFF002366),
          barBackgroundColor: Colors.white,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        bottomAppBarColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          focusColor: Colors.white70,
          backgroundColor: Colors.white70,
          splashColor: Colors.white70,
        ),
        primaryColor: Colors.white,
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.black,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            elevation: 0.0,
            shadowColor: Colors.white70,
            backgroundColor: Colors.white70,
            titleTextStyle:
                TextStyle(color: Color(0xff022b32), fontSize: 30.0)),
        fontFamily: 'Montserrat',
        accentColor: Color(0XFF002366),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white70,
          contentTextStyle: TextStyle(
            color: Color(0xff022b32),
          ),
          titleTextStyle: TextStyle(
            color: Colors.white70,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(
          bodyText2: TextStyle(
            color: Color(0xffecce6d),
          ),
          caption: TextStyle(
            color: Color(0xffecce6d),
          ),
          bodyText1: TextStyle(
            color: Color(0xffecce6d),
          ),
          button: TextStyle(
            color: Color(0xffecce6d),
          ),
          headline1: TextStyle(
            color: Color(0xffecce6d),
          ),
          subtitle1: TextStyle(
            color: Color(0xffecce6d),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        accentColor: Color(0xffecce6d),
        textTheme: TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/details": (context) => PlaceDetailScreen(),
      },
    );
  }
}
