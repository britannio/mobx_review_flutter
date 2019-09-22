import 'package:flutter/material.dart';
import 'package:mobx_review/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Review App',
      theme: ThemeData.dark(),
      home: HomePage()
    );
  }
}


