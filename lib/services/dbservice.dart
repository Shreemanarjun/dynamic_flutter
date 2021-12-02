import 'package:dynamic_flutter/data/model/userinfo.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService extends GetxService {
  late Database db;
  late String dbpath;
  final usertable = "User";
  @override
  void onInit() async {
    await init();
    super.onInit();
  }

  Future<DBService> init() async {
    dbpath = await getDatabasesPath();

    String path = join(dbpath, 'user.db');
    // await deleteDatabase(path);
    // open the database
    db = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table

      await db.execute(
          '''CREATE TABLE IF NOT EXISTs User ( id INTEGER PRIMARY KEY AUTOINCREMENT, 
          name TEXT,
          dob TEXT,
          mark TEXT,
          nationality TEXT,
       	  gender TEXT,
          image BLOB
          )
          '''
              .trim());
    });
    return this;
  }

  Future<int> insertUser({required User user}) async {
    var id = 0;

    try {
      await db.transaction((txn) async {
        id = await txn.rawInsert(
            'INSERT INTO $usertable (name,dob,mark,nationality,gender,image) VALUES(?, ?, ?, ?, ?,?)',
            [
              user.name,
              user.dob,
              user.mark,
              user.nationality,
              user.gender,
              user.image
            ]);

        return id;
      });
    } catch (e) {
      print(e);
    }

    return id;
  }

  Future<List<User>> getAllUser() async {
    List<User> users = [];
    List<Map> maps =
        await db.query(usertable, columns: null, where: null, whereArgs: []);
    if (maps.isNotEmpty) {
      users = maps.map((e) => User.fromMap(e as Map<String, dynamic>)).toList();
    }
    return users;
  }

  Future<List<User>> getSearchByName({required String name}) async {
    List<User> users = [];
    List<Map> maps = await db.query(usertable,
        columns: null,
        where: '(name || dob || mark ||nationality || gender ||image) LIKE ?',
        whereArgs: ['%$name%']);
    if (maps.isNotEmpty) {
      users = maps.map((e) => User.fromMap(e as Map<String, dynamic>)).toList();
    }
    return users;
  }

  Future<bool> updateUser({required User user}) async {
    var isupdated = false;
    await db.transaction((txn) async {
      var count = await txn.update(usertable, user.toMap(),
          where: 'id = ?', whereArgs: [user.id]);
      if (count > 0) {
        isupdated = true;
      }
    });
    return isupdated;
  }

  Future<bool> deleteUser({required User user}) async {
    var isdeleted = false;
    await db.transaction((txn) async {
      var count =
          await txn.delete(usertable, where: 'id = ?', whereArgs: [user.id]);
      if (count > 0) {
        isdeleted = true;
      }
    });
    return isdeleted;
  }
}
