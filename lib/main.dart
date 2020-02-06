import 'package:flutter/material.dart';
import 'package:programmerquotes/screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programming Quotes',
      theme: ThemeData(
        primaryColor: Color(0xFF56D4F9),
      ),
      home: HomePage(),
    );
  }
}
