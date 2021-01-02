import 'package:book_logger/screens/about.dart';
import 'package:book_logger/screens/book_list.dart';
import 'package:book_logger/screens/progress.dart';
import 'package:flutter/material.dart';
import '../style.dart';

class NavbarDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'Book Logger',
            style: NavBarTextStyle,
          ),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/navbar_cover.jpg')),
          ),
        ),
        ListTile(
          leading: Icon(Icons.list_alt),
          title: Text('Reading List'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BookList()));
          },
        ),
        ListTile(
          leading: Icon(Icons.border_color),
          title: Text('Progress'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Progress()));
          },
        ),
        ListTile(
          leading: Icon(Icons.input),
          title: Text('Info'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
          },
        ),
      ],
    ));
  }
}
