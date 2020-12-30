import 'package:book_logger/screens/book_detail.dart';
import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookListState();
  }
}

class BookListState extends State<BookList> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Books')),
      body: getBookListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Button Tapped");
          goToDetail('Add Book');
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
              backgroundColor: Colors.yellow,
              child: Icon(Icons.book),
            ),
            title: Text(
              'The 4 Hour Work Week',
              style: titleStyle,
            ),
            subtitle: Text('Timothy Ferriss'),
            trailing: Icon(
              Icons.edit,
              color: Colors.grey,
            ),
            onTap: () {
              print('Card Tapped');
              goToDetail('Edit Book');
            },
          ),
        );
      },
    );
  }

  void goToDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BookDetail(title);
    }));
  }
}
