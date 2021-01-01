import 'package:book_logger/models/book.dart';
import 'package:book_logger/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookDetail extends StatefulWidget {
  final String appBarTitle;
  final Book book;
  BookDetail(this.book, this.appBarTitle);

  @override
  _BookDetailState createState() =>
      _BookDetailState(this.book, this.appBarTitle);
}

class _BookDetailState extends State<BookDetail> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  String appBarTitle;
  Book book;
  _BookDetailState(this.book, this.appBarTitle);

  TextEditingController bookTitle = TextEditingController();
  TextEditingController bookAuthor = TextEditingController();
  static const _statuses = ["Haven't started yet", "Currently In Progress", "Completed/Done"];

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2;

    bookTitle.text = book.title;
    bookAuthor.text = book.author;

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                    title: DropdownButton(
                  items: _statuses.map((String statusItem) {
                    return DropdownMenuItem<String>(
                      value: statusItem,
                      child: Text(statusItem),
                    );
                  }).toList(),
                  value: getStatusAsString(book.status),
                  style: textStyle,
                  onChanged: (valueSelected) {
                    setState(() {
                      debugPrint('User selected $valueSelected');
                      updateStatusAsInt(valueSelected);
                    });
                  },
                )),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: bookTitle,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something is being typed');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Book Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: bookAuthor,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something is being typed');
                      updateAuthor();
                    },
                    decoration: InputDecoration(
                        labelText: 'Book Author',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Save button clicked");
                            _save();
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete button clicked");
                            _delete();
                          });
                        },
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
        ));
  }

  void updateStatusAsInt(String value) {
    switch (value) {
      case "Haven't yet started":
        book.status = 1;
        break;
      case "In Progress":
        book.status = 2;
        break;
      case "Completed":
        book.status = 3;
        break;
    }
  }

  String getStatusAsString(int value) {
    String status = _statuses[0];
    switch (value) {
      case 1:
        status = _statuses[0];
        break;
      case 2:
        status = _statuses[1];
        break;
      case 3:
        status = _statuses[2];
        break;
    }
    return status;
  }

  void updateTitle() {
    book.title = bookTitle.text;
  }

  void updateAuthor() {
    book.author = bookAuthor.text;
  }

  void _delete() async {
    moveToLastScreen();

    if (book.id == null) {
      _showAlertDialog('Status', 'Book could not be deleted.');
      return;
    }

    int result = await databaseHelper.deleteBook(book.id);

    if (result != 0) {
      _showAlertDialog('Status', 'Book has been deleted successfully');
    } else {
      _showAlertDialog('Status', 'Oops! Book could not be deleted.');
    }
  }

  void _save() async {
    moveToLastScreen();

    book.dateAdded = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if (book.id != null) {
      result = await databaseHelper.updateBook(book);
    } else {
      result = await databaseHelper.insertBook(book);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Book has been saved successfully');
    } else {
      _showAlertDialog('Status', 'Oops! Book could not be saved.');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
