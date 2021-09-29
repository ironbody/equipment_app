import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/Equipment/equipment_form.dart';
import 'package:equipment_app/Equipment/equipment_listview.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:flutter/material.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({
    Key? key,
  }) : super(key: key);

  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  DatabaseProvider db = DatabaseProvider();

  void goToForm(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const EquipmentForm();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Equipment List")),
        body: FutureBuilder(
          future: db.getEquipment(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Equipment>> snapshot) {
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
                final _equipmentList = snapshot.data ?? [];
                return EquipmentListView(
                  equipmentList: _equipmentList,
                );
              }
            }

            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => goToForm(context),
          tooltip: "Add Equipment",
          child: const Icon(Icons.add),
        ));
  }
}
