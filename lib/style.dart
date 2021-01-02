import 'package:flutter/material.dart';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const SmallTextSize = 16.0;
const String FontFamily = 'Roboto';

class App {
static Color get primaryColor => Color(0xff191927);

}

const AppBarTextStyle = TextStyle(
    fontFamily: FontFamily,
    fontWeight: FontWeight.w300,
    fontSize: MediumTextSize,
    color: Colors.white);

const NavBarTextStyle = TextStyle(
    fontFamily: FontFamily,
    fontWeight: FontWeight.w300,
    fontSize: LargeTextSize,
    color: Colors.white);

const TitleTextStyle = TextStyle(
    fontFamily: FontFamily,
    fontWeight: FontWeight.w300,
    fontSize: LargeTextSize,
    color: Colors.black);

const BodyTextStyle = TextStyle(
    fontFamily: FontFamily,
    fontWeight: FontWeight.w300,
    fontSize: SmallTextSize,
    color: Colors.black);
