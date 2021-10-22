import 'dart:async';
import 'dart:io';
import 'package:equipment_app/models/booking_model.dart';
import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;

const String tableEquipment = "equipment";

const String dmlPath = "../sql/dml.sql";

class DatabaseProvider {
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var path = join(docDirectory.path, "data.db");
    return await openDatabase(path, version: 1, onCreate: createDatabase);
  }

  Future createDatabase(Database db, int version) async {
    // final sql = await File(dmlPath).readAsString();

    // final sql = await rootBundle.loadString("assets/sql/dml.sql");
    // print(sql);
    await db.execute("""CREATE TABLE equipment (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    description TEXT    NOT NULL,
    serial      TEXT    NOT NULL,
    deviceType  TEXT    NOT NULL,
    duration    INTEGER NOT NULL
);""");

    await db.rawInsert("""INSERT INTO equipment (
    name, description, serial, deviceType, duration
) VALUES 
(
    'TEST',
    'TESTTESTTEST',
    'ABC123',
    'other',
    7
),
(
    'TEST2',
    'TESTTESTTEST',
    'ABC1232',
    'other',
    7
);""");

    await db.execute("""CREATE TABLE users (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    email       TEXT    NOT NULL,
    password    TEXT    NOT NULL,
    priviledges INTEGER NOT NULL
);""");

    await db.rawInsert("""INSERT INTO users (
    name, email, password, priviledges
) VALUES (
    'superuser',
    'superuser@bth.se',
    'super',
    0
);""");

    await db.execute("""CREATE TABLE bookings (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    equipmentId     INTEGER NOT NULL,
    userId          INTEGER NOT NULL,
    startDate       TEXT    NOT NULL,
    endDate         TEXT    NOT NULL,
    returned        TEXT,
    FOREIGN KEY(equipmentId) REFERENCES equipment(id),
    FOREIGN KEY(userId) REFERENCES users(id)
);""");

    await db.execute("""CREATE VIEW v_equipment 
AS
SELECT
    e.id,
    e.name,
    e.description,
    e.serial,
    e.deviceType,
    e.duration,
    b.id as bookingId,
    b.startDate,
    b.endDate
FROM equipment as e
LEFT JOIN (SELECT equipmentId, max(id) as maxId FROM bookings GROUP BY equipmentId) AS T1
	ON e.id = T1.equipmentId
  LEFT JOIN bookings as b
    ON T1.maxId = b.id
GROUP BY e.id
ORDER BY e.name
;""");

    await db.execute("""
    CREATE VIEW v_latest_bookings AS
SELECT b.*
FROM (SELECT equipmentId, max(id) as maxId FROM bookings GROUP BY equipmentId) AS T1
 LEFT JOIN bookings as b
    ON T1.maxId = b.id
;
    """);
  }

  Future<List<Equipment>> getEquipment() async {
    List<Equipment> _equipment = [];
    List<Booking> _bookings = [];

    var db = await database;
    var eq = await db.query('v_equipment');
    var bo = await db.query("v_latest_bookings");

    for (var element in eq) {
      _equipment.add(Equipment.fromMap(element));
    }
    for (var element in bo) {
      _bookings.add(Booking.fromMap(element));
    }

    for (var element in _bookings) {
      for (var e in _equipment) {
        if (e.id! == element.equipmentId) {
          e.booking = element;
        }
      }
    }

    // await Future.delayed(const Duration(seconds: 2));
    return _equipment;
  }

  Future addEquipment(Equipment equipment) async {
    var db = await database;
    // await db.transaction(
    //     (txn) async => await txn.insert(tableEquipment, equipment.toMap()));
    await db.insert(tableEquipment, equipment.toMap());
  }

  Future<bool> updateEquipment(Equipment equipment) async {
    if (equipment.id == null) {
      return false;
    }

    var db = await database;
    await db.update("equipment", equipment.toMap(),
        where: "id=${equipment.id}");
    return true;
  }

  Future addBooking(User user, Equipment equipment, DateTime startDate) async {
    var db = await database;
    await db.insert("bookings", {
      "equipmentId": equipment.id,
      "userId": user.id,
      "startDate": startDate.toIso8601String(),
      "endDate":
          startDate.add(Duration(days: equipment.duration)).toIso8601String()
    });
  }

  Future returnBooking(Booking booking) async {
    var db = await database;

    await db.update("bookings", {"returned": DateTime.now().toIso8601String()},
        where: "id=${booking.id}");
  }

  Future<bool> addUser(User user) async {
    var db = await database;
    var result =
        await db.rawQuery("SELECT * FROM users WHERE email=?", [user.email]);

    if (result.isNotEmpty) {
      return false;
    }
    await db.insert("users", user.toMap());
    return true;
  }

  Future<User?> loginUser(String email, String password) async {
    var db = await database;
    var result = await db.rawQuery(
        "SELECT * FROM users WHERE email=? AND password=?", [email, password]);

    if (result.isEmpty) {
      return null;
    }

    return User.fromMap(result[0]);
  }
}
