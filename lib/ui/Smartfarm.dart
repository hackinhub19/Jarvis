import 'package:flutter/material.dart';
import 'package:smartfarmland/ui/profile.dart';
import 'package:smartfarmland/ui/sensor.dart';
import 'package:smartfarmland/utils/sign_in.dart';

import '../main.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class Smartfarm extends StatefulWidget {
//  get drawerItems => null;
  final drawerItems = [
    new DrawerItem("Profile", Icons.add_circle),
    new DrawerItem("Sensor", Icons.account_box),
    new DrawerItem("Irrigation Control", Icons.account_box),

    new DrawerItem("Sign Out",Icons.backspace)
  ];

  //initializing drawer
  @override
  _SmartfarmState createState() => _SmartfarmState();
}

class _SmartfarmState extends State<Smartfarm> {


  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Profile();
      case 1:
        return sensor();
      case 2:
        return Text("Irrigation Control");
      case 3:

        signOutGoogle();
        return Signin();
      default:
        return new Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    _onSelectItem(int index) {
      setState(() => _selectedDrawerIndex = index);
      Navigator.of(context).pop(); // close the drawer
    }
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),

      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(

              accountName: new Text("Tony Stark"), accountEmail: null,),
            new Column(children: drawerOptions),


          ],
        ),
      ),
      body:_getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
