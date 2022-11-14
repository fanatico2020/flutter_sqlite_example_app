import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqlite {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQLITE_EXAMPLE');

    print(databasePath);
    print(databaseFinalPath);
    return await openDatabase(databaseFinalPath, version: 2,
        onConfigure: (db) async {
      print('chamando OnConfigure');
      await db.execute('PRAGMA foreign_keys = on');
    }, onCreate: (Database db, int version) {
      print('OnCreate');
      final batch = db.batch();
      batch.execute('''
      create table teste(
        id Integer primary key autoincrement,
        nome varchar(200)
      )
    ''');
    }, onUpgrade: (Database db, int oldVersion, int version) {
      print('OnUpgrade');

      final batch = db.batch();
      if (oldVersion == 1) {
        batch.execute('''
        create table produto(
          id Integer primary key autoincrement,
          nome varchar(200)
        )
        ''');
      }
    }, onDowngrade: (Database db, int oldVersion, int version) {
      print('OnDowngrade');
      final batch = db.batch();

      if (oldVersion == 2) {
        batch.execute('''
        drop table produto
        ''');
      }
    });
  }
}
