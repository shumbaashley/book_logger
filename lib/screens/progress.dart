import 'package:book_logger/models/book.dart';
import 'package:book_logger/utils/helper.dart';
import 'package:book_logger/widgets/navdrawer.dart';
import 'package:book_logger/widgets/textsection.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Progress extends StatefulWidget {
  Progress({Key key}) : super(key: key);

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Book> bookList;
  List<Book> completedBookList;
  int count = 0;
  int completedCount = 0;
  double _decimal = 0.0;
  double _percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    TextStyle bodyText = Theme.of(context).textTheme.subtitle1;

    if (bookList == null || completedBookList == null) {
      bookList = List<Book>();
      completedBookList = List<Book>();
      updateListView();
    }

    return Scaffold(
      appBar:  AppBar(
        title:  Text("Progress"),
      ), 
      drawer: NavbarDrawer(),
      body: Center(
        child: ListView(children: <Widget>[
          SizedBox(height:30.0),
           CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 13.0,
            header:  Text("Book Progress"),
            animationDuration: 1200,
            animation: true,
            percent: _decimal,
            center:  Text(
              "$_percentage%",
              style: bodyText,
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.blue,
          ),
          SizedBox(height:10.0),
          TextSection("Summary ", "You have completed $completedCount of $count books in your reading list")
          
        ]),
      ),
    );
  }

  void updateListView() async {
    final Database db = await databaseHelper.initializeDatabase();
    List<Book> bookList = await databaseHelper.getBookList();
    List<Book> completedBookList = await databaseHelper.getCompletedBookList();

    setState(() {
      this.bookList = bookList;
      this.completedBookList = completedBookList;
      this.count = bookList.length;
      this.completedCount = completedBookList.length;
      if (bookList.length > 0) {
        // You have books on your reading list
        this._decimal = completedBookList.length / bookList.length;
        this._percentage = (completedBookList.length / bookList.length) * 100;
      }
    });
  }
}
