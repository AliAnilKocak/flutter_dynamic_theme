import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:programmerquotes/models/QuetoModel.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[buildHeader(context), buildBody()],
        ),
      ),
    );
  }

  buildBody() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: data.map((word) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: buildItem(word),
          );
        }).toList(),
      ),
    );
  }

  buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              blurRadius: 20.0,
              // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
            )
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(64),
              bottomRight: Radius.circular(64)),
          gradient: new LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor,
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
                _openFullMaterialColorPicker(Theme.of(context).primaryColor);
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

  buildItem(QuetoModel data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
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
          print(color.value.toString());
          var prefs = await SharedPreferences.getInstance();
          prefs.setInt('color', color.value);
          print(prefs.getInt('color'));
          setState(() {
            themeColor.setColor(color);
          });
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
