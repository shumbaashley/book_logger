import 'package:book_logger/style.dart';
import 'package:book_logger/widgets/navdrawer.dart';
import 'package:book_logger/widgets/textsection.dart';
import 'package:book_logger/widgets/titlesection.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('About Us')),
        drawer: NavbarDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                constraints: BoxConstraints.expand(height: 200.0),
                decoration: BoxDecoration(color: Colors.grey),
                child: Image.asset('images/about_image.jpg', fit: BoxFit.cover),
              ),
              TextSection(
                'About',
                'Book Logger is a user friendly reading app which acts as your companion to help you keep track of your book reading progress. You get to add books to your reading list and marked each stage of the book you are at. Our app will assist you in developing good reading habits as well as meet your completion targets.'
              ),

              TextSection(
                'Contact',
                'Feel free to provide any useful feedback via the following contacts channels'
              ),

              TitleSection("WhatsApp"),
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                child: GestureDetector(
                child: Text(
                  "https://wa.me/263787382522",
                  style: LinkTextStyle,
                ),
                onTap: () async {
                      final String url = 'https://wa.me/263787382522';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                })),  
              TitleSection("Email"),
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                child: GestureDetector(
                child: Text(
                  "ashleytshumba@gmail.com",
                  style: LinkTextStyle,
                ),
                onTap: () async {
                      final Uri params = Uri(
                          scheme: 'mailto',
                          path: 'ashleytshumba@gmail.com',
                          queryParameters: {
                            'subject': 'Book Logger Application Feedback'
                          });
                      final String url = params.toString();
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                  
                })),
            ])));                       
  }
}
