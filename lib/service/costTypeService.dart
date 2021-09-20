import 'package:mybill/db/dbHelper.dart';
import 'package:mybill/model/costType.dart';

class CostTypeService {
  Future<CostType> getCostTypeById(int id) async {
    var sql = "select * from costType where id=?";
    var list = await DBHelper.rawQuery(sql, [id]);
    var rel = list.map((e) => CostType.fromMap(e)).toList();
    if (rel.length > 0) {
      return rel[0];
    }
    return null;
  }

  Future<int> removeCostTypeById(int id) async {
    var children = await queryChildrenByParentId(id);
    for (var i = 0; i < children.length; i++) {
      // await removeCostTypeById(children[i].id);
    }
    var sql = "delete from costType where id=?";
    return await DBHelper.rawDelete(sql, [id]);
  }

  Future<List<CostType>> queryChildrenByParentId(int id) async {
    var sql = "select * from costType where parentId=?";
    var list = await DBHelper.rawQuery(sql, [id]);
    return list.map((e) => CostType.fromMap(e)).toList();
  }

  saveCostType(CostType type) async {
    var data = await getCostTypeById(type.id);
    if (data == null) {
      data = new CostType();
      data.id = type.id;
    }
    data.name = type.name;
    data.moneyLimit = type.moneyLimit;
    data.parentId = type.parentId;
    data.isStart = type.isStart;
    data.memo = type.memo;
    return await DBHelper.insert('costType', data.toMap());
  }
}
