import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:router/models/models.dart';

class DatabaseHelper {
  static const _databaseName = "router.db";
  Database? db;

  Future openDB() async {
    try {
      print('opening db');
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, _databaseName);

      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        print(db);
        this.db = db;
        createTables();
      });
      return true;
    } catch (exception) {
      print('error in opening db');
      return Future.error(exception);
    }
  }

  createTables() async {
    try {
      print('creating tables');
      var query = "CREATE TABLE IF NOT EXISTS waypoints ( "
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "address TEXT,"
          "city TEXT,"
          "stop_number INTEGER,"
          "lat REAL,"
          "lng REAL)";
      await db?.execute(query);
    } catch (exception) {
      print('ERROR in creating table');
      print(exception);
    }
  }

  Future saveWaypoint(WaypointModel data) async {
    print('saveWaypoint');
    await db?.transaction((txn) async {
      var query =
          'INSERT INTO waypoints(id, name, address, city, stop_number, lat, lng)'
          'VALUES(${data.id},"${data.name}","${data.address}","${data.city}",${data.stopNumber},${data.lat},${data.lng})';
      int id1 = await txn.rawInsert(query);
      return id1;
    });
  }

  Future getWaypoints() async {
    try {
      var list = await db?.rawQuery('SELECT * FROM waypoints', []);
      return list ?? [];
    } catch (exception){
      return Future.error(exception);
    }
  }


  deleteAllWaypoints() async {
    await db?.execute("delete from waypoints");
  }
}
