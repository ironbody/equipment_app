import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:equipment_app/pages/equipment_form_page.dart';
import 'package:equipment_app/widgets/equipment_page/equipment_listview.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({
    Key? key,
  }) : super(key: key);

  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  DatabaseProvider db = DatabaseProvider();

  EquipmentListModel equipmentModel = EquipmentListModel();

  void goToForm(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const EquipmentForm();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Equipment List")),
        // body: FutureBuilder(
        //   future: equipmentModel.refreshList(),
        //   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //           child: SizedBox(
        //               width: 30.0,
        //               height: 30.0,
        //               child: CircularProgressIndicator()));
        //     }
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       if (snapshot.hasError) {
        //         return Text("Error occurred: ${snapshot.error}");
        //       }

        //       // final _equipmentList = snapshot.data ?? [];

        //       return Consumer<EquipmentListModel>(
        //           builder: (context, list, child) {
        //         return EquipmentListView(equipmentList: list.equipmentList);
        //       });
        //     }

        //     return Container();
        //   },
        // ),
        body: Consumer<EquipmentListModel>(builder: (context, list, child) {
          list.refreshList();
          return EquipmentListView(equipmentList: list.equipmentList);
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => goToForm(context),
          tooltip: "Add Equipment",
          child: const Icon(Icons.add),
        ));
  }
}
