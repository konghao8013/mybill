class StatBillInfo {
  double dayPrice = -1;
  double monthPrice = -1;
  double quarterPrice = -1;
  double yearPrice = -1;
  //monthPrice
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["dayPrice"] = dayPrice;
    map["monthPrice"] = monthPrice;
    map["quarterPrice"] = quarterPrice;
    map["yearPrice"] = yearPrice;
    return map;
  }

  static StatBillInfo fromMap(Map<String, dynamic> map) {
    var item = new StatBillInfo();
    item.dayPrice =map["dayPrice"];
    item.monthPrice = map["monthPrice"];
    item.quarterPrice = map["quarterPrice"];
    item.yearPrice = map["yearPrice"];
    return item;
  }
}
