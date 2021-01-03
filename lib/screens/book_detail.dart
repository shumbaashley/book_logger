import 'package:book_logger/models/book.dart';
import 'package:book_logger/style.dart';
import 'package:book_logger/utils/helper.dart';
import 'package:book_logger/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

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

  List<ListItem> _dropdownItems = [
    ListItem(1, "Haven't started reading it yet"),
    ListItem(2, "Currently reading it..."),
    ListItem(3, "Finished reading!"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  String appBarTitle;
  Book book;
  _BookDetailState(this.book, this.appBarTitle);
  var _formKey = GlobalKey<FormState>();

  TextEditingController bookTitle = TextEditingController();
  TextEditingController bookAuthor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2;

    bookTitle.text = book.title;
    bookAuthor.text = book.author;
    if (book.status != null) {
      _selectedItem = _dropdownMenuItems[book.status - 1].value;
    }

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
          drawer: NavbarDrawer(),
          body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the book title";
                          }
                        },
                        controller: bookTitle,
                        style: textStyle,
                        onChanged: (value) {
                          updateTitle();
                        },
                        decoration: InputDecoration(
                            labelText: 'Book Title',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14.0,
                                color: Colors.red),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter the book author";
                          }
                        },
                        controller: bookAuthor,
                        style: textStyle,
                        onChanged: (value) {
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
                            padding: EdgeInsets.all(8.0),
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text(
                              'Save',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  _save();
                                }
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Expanded(
                          child: RaisedButton(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.red,
                            textColor: Colors.white,
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
              )),
        ));
  }

  void updateStatus() {
    book.status = _selectedItem.value;
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
      title: Text(
        title,
        style: TitleTextStyle,
      ),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
}
