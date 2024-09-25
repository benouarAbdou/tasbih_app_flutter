import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> _initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'recipes.db');
    Database myDb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
    );
    return myDb;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("onUpgrade =====================================");
  }

  Future<void> _onOpen(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("PRAGMA foreign_keys = ON");

    await db.execute(
        '''
CREATE TABLE "dikr" (
  "dikrId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "dikr" TEXT NOT NULL,
  "todayCount" INTEGER DEFAULT 0,
  "goalValue" INTEGER
)''');

    // Add initial rows
    await db.execute(
        '''
INSERT INTO "dikr" ("dikr") VALUES
  ('أستغفر الله'),
  ('سبحان الله'),
  ('الله أكبر'),
  ('لا حول ولا قوة إلا بالله'),
  ('اللهم صل وسلم على سيدنا محمد'),
  ('الحمد لله')
  ''');

    print("Tables created: dikr");
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database? myDb = await db;
    List<Map<String, dynamic>> response = await myDb!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
}
