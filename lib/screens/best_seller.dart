import 'dart:convert';
import 'package:book_logger/utils/api.dart';
import 'package:book_logger/models/user.dart';
import 'package:flutter/material.dart';


class BestSellerList extends StatefulWidget {
  @override
  createState() => _BestSellerListState();
}

class _BestSellerListState extends State {
  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
        TextStyle bodyText = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
        appBar: AppBar(
          title: Text("Best Sellers List"),
        ),
        body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  title: Text(
                    users[position].name,
                    style: bodyText,
                  ),
                  subtitle: Text("subtitle"),
                ),
              );
            },
          ));
  }
}