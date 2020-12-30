import 'package:flutter/material.dart';

class BookDetail extends StatefulWidget {
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  static const _indicators = ["Haven't yet started", "In Progress", "Completed"];
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2;

    TextEditingController bookTitle = TextEditingController();
    TextEditingController bookAuthor = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
                title: DropdownButton(
              items: _indicators.map((String indicatorItem) {
                return DropdownMenuItem<String>(
                  value: indicatorItem,
                  child: Text(indicatorItem),
                );
              }).toList(),
              value: "Haven't yet started",
              style: textStyle,
              onChanged: (valueSelected) {
                setState(() {
                  debugPrint('User selected $valueSelected');
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
                      });
                    },
                  ),
                ),

                Container(width: 5.0,),

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
                      });
                    },
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
