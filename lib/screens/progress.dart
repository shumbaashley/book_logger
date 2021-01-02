import 'package:book_logger/models/book.dart';
import 'package:book_logger/utils/helper.dart';
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
    if (bookList == null || completedBookList == null) {
      bookList = List<Book>();
      completedBookList = List<Book>();
      updateListView();
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Progress"),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          new CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 13.0,
            header: new Text("Book Progress"),
            animationDuration: 1200,
            animation: true,
            percent: _decimal,
            center: new Text(
              "$_percentage%",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: new Text(
              "You have completed\n $completedCount of $count books \n on your reading list",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
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
