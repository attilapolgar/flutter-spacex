import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spacex/launch-details.dart';
import 'package:flutter_spacex/widgets/app-drawer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class LaunchList extends StatefulWidget {
  LaunchList({Key key}) : super(key: key);

  static const routeName = '/launchList';

  @override
  _LaunchListState createState() => _LaunchListState();
}

class _LaunchListState extends State<LaunchList> {
  List data;

  Future<void> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://api.spacexdata.com/v3/launches?tbd=false&order=desc"),
        headers: {"Accept": "Application/json"});

    setState(() {
      data = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Launches')),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.brown[300],
        child: data == null
            ? Center(child: CircularProgressIndicator())
            : Scrollbar(
                child: ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final launch = data[index];

                    return Card(
                      margin: EdgeInsets.all(8),
                      child: _launchListTile(
                          data: launch,
                          onTap: () => Navigator.pushNamed(
                              context, LaunchDetails.routeName,
                              arguments: ScreenArguments(launch))),
                    );
                  },
                ),
              ),
      ),
    );
  }

  Widget _launchListTile({dynamic data, GestureTapCallback onTap}) {
    final date = data['launch_date_unix'] * 1000;
    final launchDate = new DateTime.fromMillisecondsSinceEpoch(date);
    final formattedLaunchDate = new DateFormat('yMd').format(launchDate);

    return ListTile(
        contentPadding: EdgeInsets.all(8),
        leading: SizedBox(
            width: 50,
            child: data['links']['mission_patch'] != null
                ? Hero(
                    tag: data['flight_number'].toString() + 'patch-tag',
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: data['links']['mission_patch']),
                  )
                : Text('')),
        title: Text('#' +
            data['flight_number'].toString() +
            ' ' +
            data['mission_name']),
        subtitle: Column(
          children: <Widget>[
            _infoRow(
                "${formattedLaunchDate} (${timeago.format(launchDate, allowFromNow: true)})",
                Icons.calendar_today),
            _infoRow(
                data['launch_site']['site_name'] != null
                    ? data['launch_site']['site_name']
                    : 'TBD',
                Icons.pin_drop)
          ],
        ),
        isThreeLine: false,
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: onTap);
  }

  Widget _infoRow(String text, IconData icon) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 4),
          child: Icon(
            icon,
            size: 12,
          ),
        ),
        Text(text),
      ],
    );
  }
}
