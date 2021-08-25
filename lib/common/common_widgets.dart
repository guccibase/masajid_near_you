import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(200, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "show more" : "show less",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        flag = !flag;
                      });
                    }
                  },
                ),
              ],
            ),
    );
  }
}

basmalah(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        child: Text(
          'Bismillāhir-Raḥmānir-Raḥīm (بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ)',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

header(String text, BuildContext context) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
    ),
  );
}

boldPoint(String text, BuildContext context) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10.0,
    ),
  );
}

description(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DescriptionTextWidget(text: text),
  );
}

Center noLocationDetected(onPressed) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          "Couldn't get current position. Please make sure your "
          "location services are turned on and give location access "
          "to Halal Places from your device settings",
          textAlign: TextAlign.center,
        ),
      ),
      MaterialButton(
        onPressed: onPressed,
        child: Text('Retry'),
      )
    ],
  ));
}
