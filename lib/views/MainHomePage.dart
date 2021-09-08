import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybill/db/dbHelper.dart';
import 'package:mybill/helper/DateTimeHelper.dart';
import 'package:mybill/model/statBillInfo.dart';
import 'package:mybill/plugins/toast.dart';
import 'package:mybill/service/billService.dart';
import 'package:sqflite/sqflite.dart';

import 'billdetails.dart';
import 'diglog/inputBill.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  BillService service = new BillService();
  _MainHomePageState() {}
  void onAddItem() async {
    // showDialog<Null>(
    //   context: context,
    //   barrierDismissible: false,
    //   child: InputBillDiglogPage()
    // ).then((val) {
    //   print(val);
    // });
    var b = await Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new InputBillDiglogPage()));
    this.initState();
  }

  // @override
  initState() {
    service.getStatInfo().then((rel) {
      setState(() {
        this.currentBillInfo = rel;
      });
    });
  }

  refreshInfo() async {
    var rel = await service.getStatInfo();
    setState(() {
      this.currentBillInfo = rel;
    });
  }

  StatBillInfo currentBillInfo = new StatBillInfo();
  @override
  Widget build(BuildContext context) {
    print("MainHomePage/build");
    //StatBillInfo
    return Scaffold(
      appBar: AppBar(
        title: Text("我的记账"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        alignment: Alignment(0, 1),
        margin: EdgeInsets.only(bottom: 80),
        child: Container(
          decoration: BoxDecoration(color: Colors.yellow),
          height: 300,
          child: Row(children: [
            Column(children: [
              FlatButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text(
                    "今日开销:${currentBillInfo.dayPrice?.toStringAsFixed(2)}"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                onPressed: () {
                  var range = DateTimeHelper.getToDayRange();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new BillDetailPage(range[0], range[1])));
                },
              ),
              FlatButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text(
                    "本月开销:${currentBillInfo.monthPrice?.toStringAsFixed(2)}"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                onPressed: () {
                  Toast.toast(
                    context,
                    msg: '我还没做哈哈',
                  );
                },
              ),
              FlatButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text("当季开销:${currentBillInfo.quarterPrice}"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                onPressed: () {
                  Toast.toast(
                    context,
                    msg: '我还没做哈哈',
                  );
                },
              ),
              FlatButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text("今年开销:${currentBillInfo.yearPrice}"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                onPressed: () {
                  Toast.toast(
                    context,
                    msg: '我还没做哈哈',
                  );
                },
              ),
              FlatButton(
                color: Colors.red,
                highlightColor: Colors.red[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text("刷新"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                onPressed: () async {
                  await refreshInfo();
                },
              ),
            ])
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddItem,
        tooltip: "记一笔",
        child: Icon(Icons.add),
      ),
    );
  }
}
