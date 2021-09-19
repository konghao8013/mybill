import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text("About"),
    ));
  }
}
