import 'package:equipment_app/Equipment/Equipment.dart';
import 'package:flutter/material.dart';

class EquipmentTile extends StatelessWidget {
  EquipmentTile({Key? key, required this.equipment}) : super(key: key);

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.laptop_outlined),
      subtitle: Text(equipment.serial),
      title: const Text("Laptop"),
      trailing: const Icon(
        Icons.check_circle_outlined,
        color: Colors.green,
      ),
      onTap: () {},
    );
  }
}
