import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// pages
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.grey, //or set color with: Color(0xFF0000FF)
    ));

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Store',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: new MyHomePage(title: 'Stores'),
    );
  }
}
