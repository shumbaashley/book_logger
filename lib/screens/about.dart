import 'package:book_logger/style.dart';
import 'package:book_logger/widgets/navdrawer.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      drawer: NavbarDrawer(),
      body: Container(
        child: Text('About Page', style: BodyTextStyle,),
      ),
    );
  }
}
