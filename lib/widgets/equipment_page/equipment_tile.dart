import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/pages/equipment_details_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipmentTile extends StatelessWidget {
  const EquipmentTile({Key? key, required this.equipment}) : super(key: key);

  final List<Equipment> equipment;

  final double iconSize = 40.0;

  void goToDetails(BuildContext context, List<Equipment> list) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return EquipmentDetailsPage(list: list);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(equipment[0].name),
      subtitle: Text("Quantity: ${equipment.length}"),
      leading: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Align(
              alignment: Alignment.center,
              child: Icon(
                Equipment.iconFromDeviceType(equipment[0].deviceType),
                size: iconSize,
                color: Theme.of(context).primaryColor,
              ))),
      trailing: Equipment.iconFromAvailable((equipment.any((element) => element.available))),
      onTap: () {
        goToDetails(context, equipment);
      },
    );
  }
}
