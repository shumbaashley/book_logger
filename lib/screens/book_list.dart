import 'package:book_logger/models/book.dart';
import 'package:book_logger/utils/helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:book_logger/screens/book_detail.dart';
import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookListState();
  }
}

class BookListState extends State<BookList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Book> bookList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (bookList == null) {
      bookList = List<Book>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Book Reading List')),
      body: getBookListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Button Tapped");
          goToDetail(Book(3, '', ''), 'Add Book');
        },
        tooltip: 'Add Book',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getBookListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: getStatusColor(this.bookList[position].status),
                child: getStatusIcon(this.bookList[position].status)),
            title: Text(
              this.bookList[position].title,
              style: titleStyle,
            ),
            subtitle: Text(this.bookList[position].dateAdded),
            trailing: GestureDetector(
                child: Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
                onTap: () {
                  print(this.bookList[position].id);
                  goToDetail(this.bookList[position], 'Edit Book');
                }),
            onTap: () {
              print('Card Tapped');
              goToDetail(this.bookList[position], 'Edit Book');
            },
          ),
        );
      },
    );
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.deepPurple;
        break;
      case 2:
        return Colors.yellowAccent;
        break;
      case 3:
        return Colors.lightGreenAccent;
        break;
      default:
        return Colors.deepPurple;
        break;
    }
  }

  Icon getStatusIcon(int status) {
    switch (status) {
      case 1:
        return Icon(Icons.book);
        break;
      case 2:
        return Icon(Icons.local_library);
        break;
      case 3:
        return Icon(Icons.check_circle);
        break;
      default:
        return Icon(Icons.book);
        break;
    }
  }

  void _delete(BuildContext context, Book book) async {
    int result = await databaseHelper.deleteBook(book.id);
    if (result != 0) {
      _showSnackBar(context, 'Note successfully deleted');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() async {
    final Database db = await databaseHelper.initializeDatabase();
    List<Book> bookList = await databaseHelper.getBookList();

    setState(() {
      this.bookList = bookList;
      this.count = bookList.length;
    });
  }

  void goToDetail(Book book, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BookDetail(book, title);
    }));

    if (result == true) {
      updateListView();
    }
  }
}
