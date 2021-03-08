import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class TestListing extends StatefulWidget {
  @override
  _TestListingState createState() => _TestListingState();
}

class _TestListingState extends State<TestListing> {
  List _items = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('books.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["results"]["lists"][0]["books"];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Test Listing',
        ),
      ),
      body: Padding(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Load Data'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _items.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(_items[index]["title"]),
                            subtitle: Text(_items[index]["author"]),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
