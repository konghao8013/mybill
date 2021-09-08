import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static getDBPath() async {
    var path = await _createDatabaseFile();
    print("数据库：$path");
    return path;
  }

  ///1.检查数据库文件是否存在
  ///如果不存在就将assets中的文件拷贝到 指定的数据库位置
  static _createDatabaseFile() async {
    var dirPath = await _createDatabaseDirectory();
    var dbPath = '$dirPath/database.db';
    var file = File(dbPath);
    var existsFile = await file.exists();
    if (!existsFile) {
      print("不存在数据库文件:$dbPath");
      //var originDbFile = File('assets/db/database.db');
      var originDbFile = await rootBundle.load("assets/db/database.db");
      var list = originDbFile.buffer.asUint8List();
      var len = list.length;
      await File(dbPath).writeAsBytes(list);
      print("重新拷贝数据库文件：$len");
    }
    return dbPath;
  }

  ///1.检查数据库文件夹是否存在
  ///如果不存在就在android/.data.comxx/创建数据库文件夹
  static _createDatabaseDirectory() async {
    final dirInfo = await getExternalStorageDirectory();
    var filepath = dirInfo.path;
    var dirPath = "$filepath/database";
    var file = Directory(dirPath);

    try {
      bool exists = await file.exists();
      if (!exists) {
        await file.create();
      }
      print(file.path);
    } catch (e) {
      print(e);
    }
    return dirPath;
  }
}
