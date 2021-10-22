import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:equipment_app/pages/equipment_form_page.dart';
import 'package:equipment_app/widgets/app_drawer.dart';
import 'package:equipment_app/widgets/equipment_page/equipment_listview.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class NameDeviceType {
  NameDeviceType(this.name, this.deviceType);

  final String name;
  final DeviceType deviceType;

  @override
  operator ==(o) =>
      o is NameDeviceType && o.name == name && o.deviceType == deviceType;

  @override
  int get hashCode => name.hashCode ^ deviceType.hashCode;
}

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

  List<List<Equipment>> groupEquipment(List<Equipment> list) {
    var nameCount = 0;
    var nameMap = <NameDeviceType, int>{};
    var newList = <List<Equipment>>[];

    for (var e in list) {
      var name = e.name;
      var deviceType = e.deviceType;
      var ndt = NameDeviceType(name, deviceType);

      if (nameMap.containsKey(ndt)) {
        var index = nameMap[ndt];
        newList[index!].add(e);
        continue;
      }

      nameMap[ndt] = nameCount;
      newList.add(<Equipment>[]);
      newList[nameCount].add(e);
      nameCount += 1;
    }

    return newList;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserModel>().user;
    return Scaffold(
      appBar: AppBar(title: const Text("Equipment List")),
      restorationId: 'EquipmentPage',
      body: Consumer<EquipmentListModel>(builder: (context, list, child) {
        list.refreshList();
        var newList = groupEquipment(list.equipmentList);
        return EquipmentListView(equipmentList: newList);
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
