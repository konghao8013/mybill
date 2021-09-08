import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mybill/plugins/toast.dart';
import 'package:mybill/service/billService.dart';

class InputBillDiglogPage extends StatefulWidget {
  @override
  _InputBillDiglogState createState() => _InputBillDiglogState();
}

class _InputBillDiglogState extends State<InputBillDiglogPage> {
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtPrice = new TextEditingController();
  TextEditingController txtMemo = new TextEditingController();
  bool isOther = false;

  BillService service = new BillService();
  void btnSave() async {
    //Navigator.pop(context);
    Toast.toast(
      context,
      msg: '数据保存成功！',
    );

    if (txtName.text.length == 0) {
      Toast.toast(context, msg: "请输入类型名称！");
      return;
    }
    service.saveBill(txtName.text, txtPrice.text, txtMemo.text);
    txtPrice.text = null;
    txtName.text = null;
    txtMemo.text = null;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("记一笔"),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              tooltip: '保存',
              onPressed: btnSave,
            )
          ],
        ),
        body: Scrollbar(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: Column(children: [
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment(1, 0),
                        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        height: 50,
                        child: Text("名称："),
                      ),
                      Expanded(
                        child: TextField(
                          controller: txtName,
                        ),
                      ),
                      Container(
                        width: 50,
                        margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "￥0.00",
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(231, 75, 60, 1),
                              )),
                          controller: txtPrice,
                          inputFormatters: [
                            FilteringTextInputFormatter(RegExp("[0-9.]"),
                                allow: true)
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                height: 180,
                color: Colors.white,
                child: Row(),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                color: Colors.white,
                child: Row(children: [
                  Expanded(
                    child: Text(""),
                  ),
                  Row(children: [
                    Checkbox(
                      value: isOther,
                      onChanged: (b) {
                        setState(() {
                          isOther = !isOther;
                        });
                      },
                    ),
                    Text("固定开支")
                  ])
                ]),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment(1, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                          height: 50,
                          child: Text("备注"),
                        ),
                        Expanded(
                            child: TextField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                    hintText: "请输入备注信息（最多140字）"),
                                //style: TextStyle(height: 5, color: Colors.black),
                                controller: txtMemo,
                                keyboardType: TextInputType.multiline)),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
