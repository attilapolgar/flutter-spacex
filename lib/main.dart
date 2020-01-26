import 'package:flutter/material.dart';
import 'package:flutter_spacex/launch-details.dart';
import 'package:flutter_spacex/launch-list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Learn Flutter!',
        theme: ThemeData(primaryColor: Colors.white),
        initialRoute: '/',
        routes: {
          '/': (context) => LaunchList(),
          LaunchDetails.routeName: (context) => LaunchDetails(),
        });
  }
}
