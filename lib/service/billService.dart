import 'package:mybill/db/dbHelper.dart';
import 'package:mybill/model/recordBillInfo.dart';
import 'package:mybill/model/statBillInfo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class BillService {
  getStatInfo() async {
    var rel = new StatBillInfo();
    rel.monthPrice = 0;
    rel.dayPrice = 0;
    rel.yearPrice = 0;
    rel.quarterPrice = 0;
    var dbPath = await DBHelper.getDBPath();
    var db = await openDatabase(dbPath);

    var sql = '''
select (
SELECT SUM(price)  monthPrice FROM "recordBillInfo" where createTime>date('now','localtime') and createTime<date('now','+1 day','localtime')
) dayPrice,(
SELECT SUM(price)  monthPrice FROM "recordBillInfo" where createTime>date('now','start of month') and createTime<date('now','start of month','+1 month','-1 day'))monthPrice
''';
    print(sql);
    var relQuery = await db.rawQuery(sql);
    var list = relQuery.toList();
    if (list.length > 0) {
      print("查询到结果数据！");
      rel = StatBillInfo.fromMap(list[0]);
    }

    db.close();
    return rel;
  }

  getBillsByTime(DateTime beginTime, DateTime endTime) async {
    var sql =
        "select * from recordBillInfo where createTime>=? and createTime<?";
    var dbPath = await DBHelper.getDBPath();
    var db = await openDatabase(dbPath);
    var dataQuery = await db.rawQuery(sql, [
      DateFormat("yyyy-MM-dd").format(beginTime),
      DateFormat("yyyy-MM-dd").format(endTime)
    ]);
    var list = dataQuery.map((e) => RecordBillInfo.fromMap(e)).toList();
    db.close();
    return list;
  }

/**
 * 保存账单
 */
  saveBill(String name, String price, String memo) async {
    var dbPath = await DBHelper.getDBPath();

    var db = await openDatabase(dbPath);
    var record = new RecordBillInfo();
    record.createTime = DateTime.now();
    record.name = name;
    record.price = double.parse(price);
    record.memo = memo;
    record.typeId = null;
    var res = await db.insert("recordBillInfo", record.toMap());
    db.close();
  }

  removeBill(int id) async {
    var dbPath = await DBHelper.getDBPath();
    var db = await openDatabase(dbPath);
    var rel = await db.rawDelete('delete from recordBillInfo where id=?', [id]);
    db.close();
  }
}
