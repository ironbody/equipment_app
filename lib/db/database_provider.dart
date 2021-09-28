import 'dart:async';
import 'dart:io';
import 'package:equipment_app/Equipment/equipment.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String tableEquipment = "equipment";
const String columnSerial = "serial";
const String columnId = "id";

class DatabaseProvider {
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var path = join(docDirectory.path, "data.db");
    return await openDatabase(path, version: 1, onCreate: createEquipmentTable);
  }

  Future createEquipmentTable(Database db, int version) async {
    await db.execute("""
  create table $tableEquipment (
  $columnId integer primary key autoincrement,
  $columnSerial text not null 
  )
    """);
  }

  Future addEquipment(Equipment equipment) async {
    var db = await database;
    await db.transaction(
        (txn) async => await txn.insert(tableEquipment, equipment.toMap()));
  }

  Future<List<Equipment>> getEquipment() async {
    List<Equipment> _equipment = [];

    var db = await database;
    var result = await db.query(tableEquipment);
    // result.forEach((element) => _equipment.add(Equipment.fromMap(element)));

    for (var element in result) {
      _equipment.add(Equipment.fromMap(element));
    }

    print(result);

    await Future.delayed(const Duration(seconds: 2));
    return _equipment;
  }
}
