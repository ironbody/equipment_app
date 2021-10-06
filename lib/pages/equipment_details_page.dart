import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/widgets/details_page/description_widget.dart';
import 'package:equipment_app/widgets/details_page/details_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EquipmentDetailsPage extends StatelessWidget {
  const EquipmentDetailsPage({Key? key, required this.equipment})
      : super(key: key);

  final Equipment equipment;

  final double titleSize = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${equipment.name} Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Center(
                child: Text(equipment.name,
                    style: TextStyle(
                        fontSize: titleSize, fontWeight: FontWeight.bold)),
              ),
            ),
            DetailIcon(
                detailIcon: Equipment.iconFromDeviceType(equipment.deviceType)),
            DetailsDescription(description: equipment.description),
          ],
        ),
      ),
    );
  }
}
