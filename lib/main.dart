import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:equipment_app/pages/admin_form.dart';
import 'package:equipment_app/pages/equipment_form_page.dart';
import 'package:equipment_app/pages/equipment_page.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/pages/login_page.dart';
import 'package:equipment_app/pages/student_form.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

const String dbPath = "data.db";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var db = DatabaseProvider();
  var deeb = await db.database;
  // var list = await db.getEquipment();
  // var e = list[0];
  // e.name = "new";
  // await db.updateEquipment(e);
  // await db.addUser(User(
  //     name: "test", email: "test@bth.se", password: "test", priviledges: 1));
  var result = await deeb.rawQuery("SELECT * FROM v_equipment;");
  print(json.encode(result));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => EquipmentListModel()),
    ChangeNotifierProvider(create: (context) => UserModel()),
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
      routes: {
        '/': (context) => const LoginForm(),
        '/equipment': (context) => const EquipmentPage(),
        '/equipment_form': (context) => const EquipmentForm(),
        '/student_form': (context) => const StudentForm(),
        '/admin_form': (context) => const AdminForm(),
      },
      initialRoute: '/',
    );
  }
}
