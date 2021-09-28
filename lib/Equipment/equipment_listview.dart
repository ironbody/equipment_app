import 'package:equipment_app/Equipment/equipment.dart';
import 'package:equipment_app/Equipment/equipment_tile.dart';
import 'package:flutter/material.dart';

class EquipmentListView extends StatelessWidget {
  const EquipmentListView({Key? key, required this.equipmentList}) : super(key: key);

  final List<Equipment> equipmentList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: equipmentList.length,
      itemBuilder: (context, index) => EquipmentTile(equipment: equipmentList[index]));
  }
}
