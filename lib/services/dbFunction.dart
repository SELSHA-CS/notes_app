import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
class SQHelper{
  static Future<sql.Database> openOrCreateDb() async{
    return await sql.openDatabase(
        "notes",
      version: 1,
      onCreate: (db, version) async{
        await createTable(db);
      },
    );
  }
  
  static Future<void> createTable(sql.Database db) async{
    await db.execute(
      'CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, content TEXT)'
    );
  }

  static Future<int> create(String tsk, String dsc) async{
    final dataBase = await SQHelper.openOrCreateDb();
    var data = {'title' : tsk, 'content' : dsc};
    final id = await dataBase.insert('task', data);
    return id;
  }

  static Future<List<Map<String, dynamic>>> readTask() async{
    final dataBase = await SQHelper.openOrCreateDb();
    return dataBase.query('task', orderBy: 'id');
  }
}