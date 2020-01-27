import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class ScreenArguments {
  final dynamic data;

  ScreenArguments(this.data);
}

class LaunchDetails extends StatefulWidget {
  LaunchDetails({Key key}) : super(key: key);

  static const routeName = '/launchDetails';

  @override
  _LaunchDetailsState createState() => _LaunchDetailsState();
}

class _LaunchDetailsState extends State<LaunchDetails> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    final data = args.data;

    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Hero(
                  tag: data['flight_number'].toString() + 'patch-tag',
                  child: data['links']['mission_patch'] != null
                      ? FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: data['links']['mission_patch'])
                      : Text('')),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data['mission_name'],
                      style: TextStyle(fontSize: 28),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      data['details'] != null
                          ? data['details']
                          : 'no details yet',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(top: 32),
              )
            ],
          )),
    );
  }
}
