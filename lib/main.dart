import 'package:flutter/material.dart';
import 'package:scihub/screens/homepage.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SciHub Downloader',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
