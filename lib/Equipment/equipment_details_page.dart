import 'package:equipment_app/models/equipment.dart';
import 'package:flutter/material.dart';

class EquipmentDetailsPage extends StatelessWidget {
  const EquipmentDetailsPage({ Key? key, required this.equipment}) : super(key: key);

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details"),),
      body: Column(
        children: [],
      ),
    );
  }
}