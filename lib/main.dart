import 'package:flutter/material.dart';
import 'package:redshop/views/home_page.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          fontFamily: 'Georgia',
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          appBarTheme: AppBarTheme(
              color: Colors.red, brightness: Brightness.light, elevation: 1)),
      home: Scaffold(body: MainPage())));
}
