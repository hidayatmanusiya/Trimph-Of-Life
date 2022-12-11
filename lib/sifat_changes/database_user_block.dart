import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:triumph_life_ui/sifat_changes/model_user_block.dart';

final String tableUserBlock = 'table_user_block';
final int version_code = 1;
final String Id = 'id';
final String UserId = 'user_id';

class DatabaseUserBlock {
  static Database _database;
  static DatabaseUserBlock _databaseblock;

  DatabaseUserBlock._createInstance();

  factory DatabaseUserBlock() {
    if (_databaseblock == null) {
      _databaseblock = DatabaseUserBlock._createInstance();
    }
    return _databaseblock;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  //===================================================
  Future<Database> initializeDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      p.join(path, 'example.db'),
      onCreate: (Database database, version) async {
        await database.execute(
          'CREATE TABLE $tableUserBlock($Id INTEGER PRIMARY KEY AUTOINCREMENT, $UserId TEXT NOT NULL)',
        );
        // print("HelloDatabase ffff--dd $ffff");
      },
      version: 17,
    );
  }

  Future<int> AddPrayerTimeToLocal(ModelUserBlock data) async {
    int result = 0;
    var db = await this.database;
    result = await db.insert(tableUserBlock, data.toMap());
    print("HelloDatabase result--dd $result");

    return result;
  }

  Future<List<Map<String, Object>>> retrieveUsers() async {
    final Database db = await initializeDatabase();
    final List<Map<String, Object>> queryResult =
        await db.query('$tableUserBlock');
    return queryResult;
  }
  //===================================================

  Future<Database> initializeDatabase2() async {
    String query =
        '''CREATE TABLE registerUser (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT)''';
    // '''create table $tableUserBlock($Id INTEGER PRIMARY KEY AUTOINCREMENT, $UserId text not null)''';
    // print("HelloDatabase query $query");
    try {
      var databasesPath = await getDatabasesPath();

      String path = p.join(databasesPath, 'user_block.db');
      Database database = await openDatabase(
        path,
        version: version_code,
        onCreate: (db, version) {
          print("HelloDatabase onCreate  version--dd $version");
          db.execute(query);
        },
      );
      print("HelloDatabase database1 ${database}");
      return database;
    } catch (e) {
      print("HelloDatabase initializeDatabase error $e");
    }
  }

  void AddPrayerTimeToLocal2(ModelUserBlock user_info) async {
    var db = await this.database;
    var result = await db.insert(tableUserBlock, user_info.toMap());
    print("HelloDatabase AddPrayerTimeToLocal111 $result");
  }

  void UpdatePrayerTimeToLocal(ModelUserBlock user_info) async {
    var db = await this.database;
    var result = await db.update(tableUserBlock, user_info.toMap());
  }

  Future<int> delete(String id) async {
    var db = await this.database;
    return await db.delete(tableUserBlock, where: '$Id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllPrayerTimeRecord() async {
    var db = await this.database;
    return await db.delete(tableUserBlock);
  }

  Future<List<ModelUserBlock>> getAllPrayerTimes() async {
    List<ModelUserBlock> modalUserData = [];
    var db = await this.database;
    var result = await db.query(tableUserBlock);
    if (result.length > 0) {
      for (int i = 0; i < result.length; i++) {
        var modal = ModelUserBlock.fromMap(result[i]);
        modalUserData.add(modal);
      }
      print("SifatLog Values length ${modalUserData.length}");
      return modalUserData;
    } else {
      return null;
    }
  }

  Future<bool> CheckUserBlocked(String user_id) async {
    bool isUserBlocked = false;
    var db = await this.database;
    try {
      var result = await db.query(tableUserBlock);
      // print("HelloDatabase result $result");
      if (result.length > 0) {
        for (int i = 0; i < result.length; i++) {
          var modal = ModelUserBlock.fromMap(result[i]);
          print("HelloDatabase result-model ${modal.user_id}");
          print("HelloDatabase result-user ${user_id}");
          print("HelloDatabase ===============================");

          if (modal.user_id == user_id) {
            isUserBlocked = true;
            print("HelloDatabase =====true==========================");
            break;
          }
        }
        return isUserBlocked;
      } else {
        return isUserBlocked;
      }
    } catch (e) {
      print("HelloDatabase ${e}");
      return isUserBlocked;
    }
  }

  Future<int> getCount() async {
    try {
      var db = await this.database;
      var result = await db.query(tableUserBlock);
      return result.length;
    } catch (e) {
      return 0;
    }
  }
}
