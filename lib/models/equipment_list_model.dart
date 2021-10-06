import 'dart:collection';

import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/equipment.dart';
import 'package:flutter/material.dart';

class EquipmentListModel extends ChangeNotifier {
  final List<Equipment> _equipmentList = [];

  UnmodifiableListView<Equipment> get equipmentList =>
      UnmodifiableListView(_equipmentList);

  Future refreshList() async {
    final db = DatabaseProvider();
    final newList = await db.getEquipment();
    _equipmentList.clear();
    _equipmentList.addAll(newList);
    notifyListeners();
  }

  void add(Equipment newEquipment) {
    _equipmentList.add(newEquipment);
    notifyListeners();
  }
}
