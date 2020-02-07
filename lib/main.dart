import 'package:flutter/material.dart';
import 'package:programmerquotes/provider/theme_notifier.dart';
import 'package:programmerquotes/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(Color(0xFF56D4F9)),
      child: MyApp(),
    ),
  );
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
