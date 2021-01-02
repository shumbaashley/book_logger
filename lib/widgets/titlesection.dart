import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  final String _title;

  TitleSection(this._title);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 4.0),
            child: Text(_title, style: Theme.of(context).textTheme.headline5,),
          ),
        ]);
  }
}
