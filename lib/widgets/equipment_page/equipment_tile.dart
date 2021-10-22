import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/pages/equipment_details_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipmentTile extends StatelessWidget {
  const EquipmentTile({Key? key, required this.equipment}) : super(key: key);

  final Equipment equipment;

  final double iconSize = 40.0;

  void goToDetails(BuildContext context, Equipment e) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return EquipmentDetailsPage(equipment: e);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(equipment.name),
      subtitle: Text(equipment.serial),
      leading: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Align(
              alignment: Alignment.center,
              child: Icon(
                Equipment.iconFromDeviceType(equipment.deviceType),
                size: iconSize,
                color: Theme.of(context).primaryColor,
              ))),
      trailing: Equipment.iconFromAvailable(equipment.available),
      onTap: () {
        goToDetails(context, equipment);
      },
    );
  }
}
