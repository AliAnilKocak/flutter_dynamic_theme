import 'package:flutter/material.dart';
import 'package:programmerquotes/provider/theme_notifier.dart';
import 'package:programmerquotes/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.getInstance().then((prefs) {
    Color color = Color(0xFF56D4F9); //default renk
    if (prefs.getInt('color') != null) { //sharedPreferences'ta kayıtlı ise
      color = Color(prefs.getInt('color'));
    }
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(color), //kayıtlı olan rengi uygula
        child: MyApp(),
      ),
    );
  });
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
