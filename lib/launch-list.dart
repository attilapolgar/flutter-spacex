import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spacex/launch-details.dart';
import 'package:http/http.dart' as http;

class LaunchList extends StatefulWidget {
  LaunchList({Key key}) : super(key: key);

  @override
  _LaunchListState createState() => _LaunchListState();
}

class _LaunchListState extends State<LaunchList> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://api.spacexdata.com/v3/launches?order=desc"),
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
      body: Container(
        child: data == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  final launch = data[index];

                  return Card(
                    child: InkWell(
                      splashColor: Colors.blue[30],
                      onTap: () {
                        Navigator.pushNamed(context, LaunchDetails.routeName,
                            arguments: ScreenArguments(launch));
                      },
                      child: ListTile(
                        leading: SizedBox(
                            width: 50,
                            child: launch['links']['mission_patch_small'] !=
                                    null
                                ? Hero(
                                    tag: launch['flight_number'].toString() +
                                        'patch-tag',
                                    child: Image.network(
                                        launch['links']['mission_patch']),
                                  )
                                : Text('')),
                        title: Text('#' +
                            launch['flight_number'].toString() +
                            ' ' +
                            launch['mission_name']),
                        subtitle: Text(launch['launch_date_utc']),
                        isThreeLine: false,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
