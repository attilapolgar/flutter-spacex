import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LayoutTutorial extends StatefulWidget {
  LayoutTutorial({Key key}) : super(key: key);

  @override
  _LayoutTutorialState createState() => _LayoutTutorialState();
}

class _LayoutTutorialState extends State<LayoutTutorial> {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Row(children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('Oeschinen Lake Campground',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Text('Kandersteg, Switzerland',
                  style: TextStyle(color: Colors.grey[500]))
            ],
          )),
          FavoriteWidget()
        ]));

    Color color = Theme.of(context).primaryColorDark;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE')
        ],
      ),
    );

    Widget textSection = Container(
        padding: const EdgeInsets.all(32),
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          style: TextStyle(
            fontSize: 16,
          ),
          softWrap: true,
        ));

    return Scaffold(
        appBar: AppBar(title: Text('Flutter layout demo')),
        body: ListView(
          children: <Widget>[
            Image.asset('images/lake.jpg',
                width: 600, height: 240, fit: BoxFit.cover),
            titleSection,
            buttonSection,
            textSection
          ],
        ));
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400, color: color)),
        )
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({Key key}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavored = true;
  int _favouriteCount = 41;

  @override
  Widget build(BuildContext context) {
    void _toggleFavorite() {
      setState(() {
        if (_isFavored) {
          _favouriteCount -= 1;
          _isFavored = false;
        } else {
          _favouriteCount += 1;
          _isFavored = true;
        }
      });
    }

    return Row(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(0),
            child: IconButton(
              icon: (_isFavored ? Icon(Icons.star) : Icon(Icons.star_border)),
              color: Colors.red[500],
              onPressed: _toggleFavorite,
            )),
        SizedBox(width: 18, child: Text('$_favouriteCount'))
      ],
    );
  }
}
