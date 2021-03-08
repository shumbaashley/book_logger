import 'dart:convert';
import 'package:book_logger/models/nytbook.dart';
import 'package:book_logger/utils/api.dart';
import 'package:flutter/material.dart';


class BestSellerList extends StatefulWidget {
  @override
  createState() => _BestSellerListState();
}

class _BestSellerListState extends State {
  var books = new List<NYTBook>();

  _getBooks() {
    API.getBooks().then((response) {
      setState(() {
        var res = json.decode(response.body);
        Iterable list = res["results"]["lists"][0]["books"];
        books = list.map((model) => NYTBook.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getBooks();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    TextStyle bodyText = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
        appBar: AppBar(
          title: Text("NYT Best Sellers"),
        ),
        body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(
                  books[position].title,
                  style: bodyText,
                ),
                subtitle: Text(books[position].author),
              ),
            );
          },
        ));
  }
}
