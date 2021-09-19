import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mybill/helper/msgbox.dart';
import 'package:mybill/model/recordBillInfo.dart';
import 'package:mybill/plugins/toast.dart';
import 'package:mybill/service/billService.dart';
import 'package:intl/intl.dart';

import 'diglog/inputBill.dart';

class BillDetailPage extends StatefulWidget {
  DateTime _beginTime;
  DateTime _endTime;
  String title = "账单明细";
  BillDetailPage(String title, DateTime beginTime, DateTime endTime) {
    this._beginTime = beginTime;
    this._endTime = endTime;
    this.title = title;
  }
  @override
  _BillDetailState createState() =>
      _BillDetailState(title, _beginTime, _endTime);
}

class _BillDetailState extends State<BillDetailPage> {
  DateTime _beginTime;
  DateTime _endTime;
  String title;
  BillService service = new BillService();
  _BillDetailState(String title, DateTime beginTime, DateTime endTime) {
    this._beginTime = beginTime;
    this._endTime = endTime;
    this.title = title;
  }
  @override
  void initState() {
    // TODO: implement initState
    service.getBillsByTime(_beginTime, _endTime).then((rel) {
      setState(() {
        this.billdetailList = rel;
      });
    });
  }

  List<RecordBillInfo> billdetailList = new List<RecordBillInfo>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              tooltip: '+',
              onPressed: () async {
                var b = await Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new InputBillDiglogPage()));
                this.initState();
              },
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: new CustomScrollView(
              shrinkWrap: true,
              // 内容
              slivers: <Widget>[
                new SliverPadding(
                  padding: const EdgeInsets.all(0.0),
                  sliver: new SliverList(
                    delegate: new SliverChildListDelegate(
                      billdetailList.map((item) {
                        //根据备注是否有值决定展示
                        var leftCol = new List<Widget>();
                        leftCol.add(Container(
                          child: Text("${item.name}"),
                        ));
                        if (item.memo != null && item.memo.length > 0) {
                          leftCol.add(Text(
                            "${item.memo}",
                            style: TextStyle(color: Colors.grey),
                          ));
                        }

                        var rel = Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: '删除',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () async {
                                var bit = await Msgbox.Confirm(
                                    context, "确认删除该笔账单吗？删除后无法恢复。",
                                    title: "警告");
                                if (bit) {
                                  service.removeBill(item.id);
                                  Toast.toast(context,
                                      msg: '删除成功！',
                                      bgColor: Color.fromRGBO(42, 127, 184, 0),
                                      textColor: Colors.white);
                                  this.initState();
                                } else {
                                  print("取消删除账单");
                                }
                              },
                            ),
                          ],
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: leftCol),
                                ),
                                Expanded(
                                  child: Text(""),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("￥${item.price}",
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(192, 56, 42, 1),
                                          )),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                                        child: Text(
                                            "${DateFormat('yyyy-MM-dd  kk:mm:ss').format(item.createTime)}"),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                        return rel;
                      }).toList(),
                    ),
                  ),
                ),
              ],
            )));
  }
}
