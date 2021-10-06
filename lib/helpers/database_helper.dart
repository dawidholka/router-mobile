import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:router/models/models.dart';

class DatabaseHelper {
  static const _databaseName = "router.db";
  Database? db;

  Future openDB() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, _databaseName);

      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        this.db = db;
        createTables();
      });
      return true;
    } catch (exception) {
      return Future.error(exception);
    }
  }

  createTables() async {
    try {
      var query = "CREATE TABLE IF NOT EXISTS waypoints ( "
          "id INTEGER PRIMARY KEY,"
          "stop_number INTEGER,"
          "name TEXT,"
          "address TEXT,"
          "city TEXT,"
          "lat REAL,"
          "lng REAL,"
          "phone TEXT,"
          "intercom TEXT,"
          "note TEXT,"
          "delivery_time TEXT,"
          "content TEXT,"
          "quantity INTEGER,"
          "status TEXT,"
          "driver_note TEXT,"
          "photo_uploaded INTEGER"
          ")";
      await db?.execute(query);
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future saveWaypoint(WaypointModel data) async {
    try {
      await db?.transaction((txn) async {
        int id1 = await txn.insert('waypoints', data.toJson());
        // var query = 'INSERT INTO waypoints(id, stop_number, name, address, city'
        //     ',lat, lng, phone, intercom, note, delivery_time, content, quantity'
        //     ',status, driver_note, photo_uploaded)'
        //     'VALUES(${data.id}, ${data.stopNumber}, "${data.name}",'
        //     '"${data.address}", "${data.city}", ${data.lat}, ${data.lng},'
        //     '"${data.phone}", "${data.intercom.toString()}", "${data.note}",'
        //     '"${data.deliveryTime}", "${data.content}", ${data.quantity},'
        //     '"${data.status}", "${data.driverNote}", ${data.photoUploaded})';
        // int id1 = await txn.rawInsert(query);
        return id1;
      });
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future getWaypoints() async {
    try {
      var list = await db?.rawQuery('SELECT * FROM waypoints ORDER BY stop_number', []);
      return list ?? [];
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future changeWaypointStatus(int id, String status) async {
    try {
      var query = 'UPDATE waypoints SET status = ? WHERE id = ?';
      await db?.rawUpdate(query, [status, id]);
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future updateWaypointDriverNote(int id, String note) async {
    try {
      var query = 'UPDATE waypoints SET driver_note = ? WHERE id = ?';
      await db?.rawUpdate(query, [note, id]);
    } catch (exception) {
      return Future.error(exception);
    }
  }

  deleteAllWaypoints() async {
    try {
      await db?.execute("delete from waypoints");
    } catch (exception) {
      return Future.error(exception);
    }
  }
}
