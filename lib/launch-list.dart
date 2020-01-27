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
  List data = new List();
  int offset = 0;
  bool pending = false;

  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getData({int offset: 0}) async {
    setState(() {
      pending = true;
    });
    var response = await http.get(
        Uri.encodeFull(
            "https://api.spacexdata.com/v3/launches?limit=10&offset=${offset}&tbd=false&order=desc"),
        headers: {"Accept": "Application/json"});

    setState(() {
      data.addAll(jsonDecode(response.body));
      pending = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          offset = offset += 10;
        });
        this.getData(offset: offset);
      }
    });
  }

  Future<void> _handleRefresh() {
    setState(() {
      offset = 0;
      data = new List();
    });
    return this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Launches')),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.brown[100],
        child: data == null
            ? Center(child: CircularProgressIndicator())
            : Scrollbar(
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final launch = data[index];

                      return _launchListItem(
                          data: launch,
                          onTap: () => Navigator.pushNamed(
                              context, LaunchDetails.routeName,
                              arguments: ScreenArguments(launch)));
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Widget _launchListItem({dynamic data, GestureTapCallback onTap}) {
    final date = data['launch_date_unix'] * 1000;
    final launchDate = new DateTime.fromMillisecondsSinceEpoch(date);
    final formattedLaunchDate = new DateFormat('yMd').format(launchDate);

    var borderColor = Colors.grey;

    if (data['launch_success'] == true) {
      borderColor = Colors.green;
    }

    if (data['launch_success'] == false) {
      borderColor = Colors.red;
    }

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [borderColor, Colors.white, Colors.white],
            stops: [0, 0.02, 1]),
      ),
      child: InkWell(
          splashColor: Colors.blueGrey,
          onTap: onTap,
          child: Container(
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              SizedBox(
                  height: 100,
                  width: 100,
                  child: data['links']['mission_patch'] != null
                      ? Hero(
                          tag: data['flight_number'].toString() + 'patch-tag',
                          child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: data['links']['mission_patch']),
                        )
                      : Text('')),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          '#${data['flight_number'].toString()} ${data['mission_name']}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 28,
              )
            ]),
          )),
    );
  }

  Widget _infoRow(String text, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 4),
            child: Icon(
              icon,
              size: 14,
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}
