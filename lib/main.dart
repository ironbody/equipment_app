import 'package:equipment_app/Equipment/equipment_form.dart';
import 'package:equipment_app/Equipment/equipment_page.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/Equipment/equipment.dart';
import 'package:flutter/material.dart';
import 'dart:async';

const String dbPath = "data.db";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var db = DatabaseProvider();
  // await db.addEquipment(Equipment(serial: "Wrk8EBa4"));
  // await db.addEquipment(Equipment(serial: "stZhg3o2"));
  // await db.addEquipment(Equipment(serial: "gkczPAs7"));
  // await db.addEquipment(Equipment(serial: "HY6NkvLb"));
  // await db.addEquipment(Equipment(serial: "R9U3FG3W"));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EquipmentPage(),
    );
  }
}
