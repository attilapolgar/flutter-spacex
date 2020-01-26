import 'package:flutter/material.dart';
import 'package:flutter_spacex/launch-details.dart';
import 'package:flutter_spacex/launch-list.dart';
import 'package:flutter_spacex/layout-tutorial.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SpaceX Unofficial',
        theme: ThemeData(primaryColor: Colors.brown),
        initialRoute: LaunchList.routeName,
        routes: {
          LaunchList.routeName: (context) => LaunchList(),
          LaunchDetails.routeName: (context) => LaunchDetails(),
          LayoutTutorial.routeName: (context) => LayoutTutorial(),
        });
  }
}
