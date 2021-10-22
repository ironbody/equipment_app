import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/widgets/equipment_page/equipment_tile.dart';
import 'package:flutter/material.dart';

class EquipmentListView extends StatelessWidget {
  const EquipmentListView({Key? key, required this.equipmentList}) : super(key: key);

  final List<List<Equipment>> equipmentList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: equipmentList.length,
      itemBuilder: (context, index) => EquipmentTile(equipment: equipmentList[index]));
  }
}
