import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  // var data;

  // Future<String> getData() async {
  //   var response = await http.get(
  //       Uri.encodeFull("https://api.spacexdata.com/v3/launches/80"),
  //       headers: {"Accept": "Application/json"});

  //   setState(() {
  //     data = jsonDecode(response.body);
  //   });
  // }

  // @override
  // void initState() {
  //   this.getData();
  // }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    final data = args.data;

    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Hero(
                  tag: data['flight_number'].toString() + 'patch-tag',
                  child: data['links']['mission_patch'] != null
                      ? Image.network(data['links']['mission_patch'])
                      : Text('')),
              Container(
                child: Text(
                  data['details'] != null ? data['details'] : 'no details yet',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                padding: EdgeInsets.only(top: 32),
              )
            ],
          )),
    );
  }
}
