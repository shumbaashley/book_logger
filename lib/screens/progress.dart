import 'package:book_logger/style.dart';
import 'package:book_logger/widgets/navdrawer.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress')),
      drawer: NavbarDrawer(),
      body: Container(
        child: Text('Progress Page', style: BodyTextStyle,),
      ),
    );
  }
}
