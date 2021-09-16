import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook/UI/bottom_nav_bar.dart';
import 'package:flutter_ebook/UI/home/home_screen.dart';
import 'package:flutter_ebook/utils/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        barBackgroundColor: kBackgroundColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: kWhiteColor,
          textStyle: TextStyle(color: kWhiteColor),
        ),
      ),
      home: BottomNavBar(),
    );
  }
}
