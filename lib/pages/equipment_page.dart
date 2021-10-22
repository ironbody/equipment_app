import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:equipment_app/pages/equipment_form_page.dart';
import 'package:equipment_app/widgets/app_drawer.dart';
import 'package:equipment_app/widgets/equipment_page/equipment_listview.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({
    Key? key,
  }) : super(key: key);

  static const routeName = "/equipment";


  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  DatabaseProvider db = DatabaseProvider();

  EquipmentListModel equipmentModel = EquipmentListModel();

  void goToForm(BuildContext ctx) {
    Navigator.of(ctx).restorablePushNamed('/equipment_form');
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserModel>().user;
    return Scaffold(
      appBar: AppBar(title: const Text("Equipment List")),
      restorationId: 'EquipmentPage',
      body: Consumer<EquipmentListModel>(builder: (context, list, child) {
        list.refreshList();
        return EquipmentListView(equipmentList: list.equipmentList);
      }),
      floatingActionButton: user.priviledges < 2
          ? FloatingActionButton(
              onPressed: () => goToForm(context),
              tooltip: "Add Equipment",
              child: const Icon(Icons.add),
            )
          : null,
      drawer: AppDrawer(user: user, currentRoute: EquipmentPage.routeName),
    );
  }
}
