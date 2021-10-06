import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:equipment_app/pages/equipment_page.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/equipment.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';

const String dbPath = "data.db";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var db = DatabaseProvider();
  // await db.addEquipment(Equipment(
  //     name: "Razer laptop",
  //     description: "laptop from razer",
  //     serial: "ABABA",
  //     deviceType: DeviceType.laptop,
  //     duration: 4));
  // await db.addEquipment(Equipment(serial: "stZhg3o2"));
  // await db.addEquipment(Equipment(serial: "gkczPAs7"));
  // await db.addEquipment(Equipment(serial: "HY6NkvLb"));
  // await db.addEquipment(Equipment(serial: "R9U3FG3W"));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => EquipmentListModel())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key? key}) : super(key: key);

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
