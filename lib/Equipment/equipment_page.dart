import 'package:equipment_app/Equipment/equipment.dart';
import 'package:equipment_app/Equipment/equipment_listview.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:flutter/material.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({Key? key,}) : super(key: key);

  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  DatabaseProvider db = DatabaseProvider();

  List<Equipment> _equipmentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Equipment List")),
      body: FutureBuilder(
        future: db.getEquipment(),
        builder: (BuildContext context, AsyncSnapshot<List<Equipment>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator()));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error occurred: ${snapshot.error}");
            }
            if (snapshot.hasData) {
              _equipmentList = snapshot.data ?? [];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: EquipmentListView(equipmentList: _equipmentList,),
              );
            }
          }
    
          return Container();
        },
      ),
    );
  }
}
