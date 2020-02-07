import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:programmerquotes/models/queto_model.dart';
import 'package:programmerquotes/provider/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuetoModel> data = Data.data;

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            buildHeader(context, themeColor),
            buildBody(themeColor)
          ],
        ),
      ),
    );
  }

  buildBody(themeColor) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: data.map((word) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: buildItem(word, themeColor),
          );
        }).toList(),
      ),
    );
  }

  buildHeader(BuildContext context, themeColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: themeColor.getColor(),
              blurRadius: 20.0,
              spreadRadius: 1.0,
            )
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(64),
              bottomRight: Radius.circular(64)),
          gradient: new LinearGradient(colors: [
            themeColor.getColor(),
            themeColor.getColor(),
          ])),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Programming Quotes",
              style:
                  TextStyle(fontSize: 18, color: Colors.white.withAlpha(232)),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                _openFullMaterialColorPicker(themeColor);
              },
              child: Text(
                "Tema Değiştir",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildItem(QuetoModel data, themeColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: themeColor.getColor(),
            blurRadius: 5.0, // has the effect of softening the shadow
            spreadRadius: 0.5, // has the effect of extending the shadow
          )
        ],
      ),
      margin: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: themeColor.getColor(),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topLeft: Radius.circular(12),
                )),
            height: 136,
            width: 16,
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("\"" + data.en + "\""),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text("- " + data.author))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openFullMaterialColorPicker(themeColor) async {
    _openDialog(
      "Renk seç",
      MaterialColorPicker(
        colors: materialColors,
        onColorChange: (color) async {
          var prefs = await SharedPreferences.getInstance();
          prefs.setInt('color', color.value);
          themeColor.setColor(color);
        },
      ),
    );
  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('İptal'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('Kaydet'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
