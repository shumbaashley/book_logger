import 'package:book_logger/screens/splash.dart';
import 'package:book_logger/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Logger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: AppBarTextStyle
          ),
        ),
        textTheme: TextTheme(
          headline6: AppBarTextStyle,
          headline5: TitleTextStyle,
          bodyText2 : BodyTextStyle,
          subtitle1 : BodyTextStyle,
          subtitle2: BodyText2Style
        )
      ),
      home: SplashWidget(),
    );
  }
}
