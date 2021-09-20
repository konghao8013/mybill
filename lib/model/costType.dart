class CostType {
  int id;
  String name;
  double moneyLimit;
  int parentId;
  bool isStart;
  String memo;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["moneyLimit"] = moneyLimit;
    map["parentId"] = parentId;
    map["isStart"] = isStart;
    map["memo"] = memo;
    return map;
  }

  static CostType fromMap(Map<String, dynamic> map) {
    var item = new CostType();
    item.id = map["id"];
    item.name = map["name"];
    item.moneyLimit = map["moneyLimit"];
    item.parentId = map["parentId"];
    item.isStart = map["isStart"];
    item.memo = map["memo"];
    return item;
  }
}
