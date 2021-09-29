import 'dart:async';
import 'dart:io';
import 'package:equipment_app/models/equipment.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
    final sql = await File(dmlPath).readAsString();

    await db.execute(sql);
  }

  Future<List<Equipment>> getEquipment() async {
    List<Equipment> _equipment = [];

    var db = await database;
    var result = await db.query(tableEquipment);

    for (var element in result) {
      _equipment.add(Equipment.fromMap(element));
    }

    await Future.delayed(const Duration(seconds: 2));
    return _equipment;
  }

  Future addEquipment(Equipment equipment) async {
    var db = await database;
    await db.transaction(
        (txn) async => await txn.insert(tableEquipment, equipment.toMap()));
  }
}
