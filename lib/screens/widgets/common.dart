import 'package:flutter/material.dart';

import '../../constants.dart';

Center noResultsWidget() {
  return Center(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(kNoResults),
  ));
}
