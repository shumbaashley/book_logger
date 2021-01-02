import 'package:book_logger/style.dart';
import 'package:book_logger/widgets/navdrawer.dart';
import 'package:book_logger/widgets/textsection.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Info')),
      drawer: NavbarDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            constraints: BoxConstraints.expand(height: 200.0),
            decoration: BoxDecoration(color: Colors.grey),
            child: Image.asset(
              'images/about_image.jpg',
              fit: BoxFit.cover
            ),
          ),
          TextSection('About Us', 'Book Logger is your friendly reading companion which helps you keep track of your book reading progress. You get to add books to your reading list and marked each stage of the book you are at. Our app will assist you in developing good reading habits as well as meet your completion targets.')
        ]
    ));
  }
}
