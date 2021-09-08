import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Msgbox {
  static Future<bool> Confirm(BuildContext context, String message,
      {String title = "提醒"}) {
    var completer = Completer<bool>();

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text(
              title,
            ),
            content: new Text(message),
            actions: <Widget>[
              new Container(
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.grey[300], width: 1.0),
                        top: BorderSide(color: Colors.grey[300], width: 1.0))),
                child: FlatButton(
                  child: new Text("确定"),
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(true);
                  },
                ),
              ),
              new Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey[300], width: 1.0))),
                child: FlatButton(
                  child: new Text("取消"),
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(false);
                  },
                ),
              )
            ],
          );
        });

    return completer.future;
  }
}
