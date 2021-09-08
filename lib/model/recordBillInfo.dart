import 'package:intl/intl.dart';
class RecordBillInfo {
  int id;
  String name;
  int typeId;
  double price;
  DateTime createTime;
  String memo;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["memo"] = memo;
    map["typeId"] = typeId;
    map["price"] = price;
    map["createTime"] =DateFormat('yyyy-MM-dd – kk:mm').format(createTime);
    return map;
  }

  static RecordBillInfo fromMap(Map<String, dynamic> map) {
    var record = new RecordBillInfo();
    record.id = map["id"];
    record.name = map["name"];
    record.memo = map["memo"];
    record.typeId = map["typeId"];
    record.price = map["price"];
    if (map["createTime"] != null) {
      record.createTime = DateFormat('yyyy-MM-dd – kk:mm').parse(map["createTime"]);
    }

    return record;
  }
}
