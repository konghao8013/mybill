import 'package:flutter/material.dart';
import 'package:mybill/views/MainHomePage.dart';
import 'package:mybill/views/about.dart';
import 'package:mybill/views/typeManager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> lists = List();
  // 设置定义颜色变量
  final _Color = Colors.lightBlue;
  @override
  void initState() {
    lists.add(MainHomePage());
    lists.add(TypeManagerPage());
    lists.add(AboutPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lists[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Container(), icon: Icon(Icons.pie_chart)),
          BottomNavigationBarItem(title: Container(), icon: Icon(Icons.games)),
          BottomNavigationBarItem(
              title: Container(), icon: Icon(Icons.error_outline)),
        ],
        currentIndex: _currentIndex,
        onTap: (tabIdx) {
          setState(() {
            _currentIndex = tabIdx;
          });
        },
      ),
    );
  }
}
