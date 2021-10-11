import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/widgets/details_page/details_description.dart';
import 'package:equipment_app/widgets/details_page/details_icon.dart';
import 'package:equipment_app/widgets/details_page/details_edit_button.dart';
import 'package:equipment_app/widgets/details_page/details_rent_button.dart';
import 'package:equipment_app/widgets/details_page/details_rent_duration.dart';
import 'package:equipment_app/widgets/details_page/details_serial.dart';
import 'package:equipment_app/widgets/details_page/details_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EquipmentDetailsPage extends StatelessWidget {
  const EquipmentDetailsPage({Key? key, required this.equipment})
      : super(key: key);

  final Equipment equipment;

  final double titleSize = 30.0;

  final double buttonHeight = 50.0;
  final double buttonWidth = 50.0;

  void editEquipment() {}

  void rentEquipment() {}

  @override
  Widget build(BuildContext context) {
    void Function()? rentFunction;

    if (equipment.available == true) {
      rentFunction = rentEquipment;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${equipment.name} Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          DetailIcon(
              detailIcon: Equipment.iconFromDeviceType(equipment.deviceType)),
          Center(
            child: Text(equipment.name,
                style: TextStyle(
                    fontSize: titleSize, fontWeight: FontWeight.bold)),
          ),
          DetailsSerial(serial: equipment.serial),
          DetailsDescription(description: equipment.description),
          DetailsRentDuration(duration: equipment.duration),
          DetailStatus(available: equipment.available),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                        height: buttonHeight,
                        width: buttonWidth,
                        child: EditButton(onPressed: editEquipment))),
                const SizedBox(width: 8.0,),
                Expanded(
                    child: SizedBox(
                        height: buttonHeight,
                        width: buttonWidth,
                        child: RentButton(onPressed: rentFunction))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
