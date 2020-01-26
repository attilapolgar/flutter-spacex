import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spacex/launch-list.dart';
import 'package:flutter_spacex/layout-tutorial.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Colors.brown[900]),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
              icon: Icons.work,
              text: 'Dashboard',
              onTap: () => Navigator.pushReplacementNamed(
                  context, LayoutTutorial.routeName),
            ),
            _createDrawerItem(
              icon: Icons.calendar_today,
              text: 'Launches',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, LaunchList.routeName),
            ),
            _createDrawerItem(
              icon: Icons.verified_user,
              text: 'About',
            ),
          ],
        ),
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('images/earth.jpg'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.black54),
              child: Text('SpaceX unofficial',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500)),
            )),
      ]),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return Container(
      child: ListTile(
        leading: Icon(icon, size: 24, color: Colors.white70),
        title: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        onTap: onTap,
        enabled: onTap != null,
      ),
    );
  }
}
