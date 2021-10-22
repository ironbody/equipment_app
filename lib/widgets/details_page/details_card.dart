import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:equipment_app/pages/equipment_edit_form.dart';
import 'package:equipment_app/widgets/details_page/details_description.dart';
import 'package:equipment_app/widgets/details_page/details_edit_button.dart';
import 'package:equipment_app/widgets/details_page/details_icon.dart';
import 'package:equipment_app/widgets/details_page/details_rent_button.dart';
import 'package:equipment_app/widgets/details_page/details_rent_duration.dart';
import 'package:equipment_app/widgets/details_page/details_serial.dart';
import 'package:equipment_app/widgets/details_page/details_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({Key? key, required this.equipment}) : super(key: key);

  final Equipment equipment;

  @override
  _DetailsCardState createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
    final double titleSize = 30.0;

  final double buttonHeight = 50.0;

  final double buttonWidth = 50.0;

  void editEquipment() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return EquipmentEditForm(
        equipment: widget.equipment,
      );
    }));
  }

  void rentEquipment(User user) async {
    final db = DatabaseProvider();
    await db.addBooking(user, widget.equipment, DateTime.now());
    Provider.of<EquipmentListModel>(context, listen: false).refreshList();
    Navigator.of(context).pop();
  }

  void returnEquipment() async {
    var db = DatabaseProvider();
    db.returnBooking(widget.equipment.booking!);
    Provider.of<EquipmentListModel>(context, listen: false).refreshList();
    Navigator.of(context).pop();
  }


  Widget _renderRow() {
    var user = Provider.of<UserModel>(context).user;
    if (widget.equipment.available ||
        user.id != widget.equipment.booking?.userId) {
    return Row(
      children: [
        Expanded(
            child: SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: RentButton(
                    onPressed: widget.equipment.available
                        ? () => rentEquipment(context.read<UserModel>().user)
                        : null))),
      ]);
    }

    return Row(
      children: [
        Expanded(
            child: SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: RentButton(
                    onPressed: widget.equipment.available
                        ? () => rentEquipment(context.read<UserModel>().user)
                        : null))),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: SizedBox(
              height: buttonHeight,
              width: buttonWidth,
              child: ElevatedButton(
                  onPressed: returnEquipment, child: const Text("Return"))),
        ),

      ]);


  }

  Widget _renderEditButton() {
    final user = context.read<UserModel>().user;
    if (user.priviledges > 1) {
      return Container();
    }

    return EditButton(onPressed: editEquipment);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          DetailIcon(
              detailIcon:
                  Equipment.iconFromDeviceType(widget.equipment.deviceType)),
          Center(
            child: Text(widget.equipment.name,
                style: TextStyle(
                    fontSize: titleSize, fontWeight: FontWeight.bold)),
          ),
          DetailsSerial(serial: widget.equipment.serial),
          DetailsDescription(description: widget.equipment.description),
          DetailsRentDuration(duration: widget.equipment.duration),
          DetailStatus(available: widget.equipment.available),
          Padding(padding: const EdgeInsets.all(3.0), child: _renderRow()),
          _renderEditButton(),
        ],
      ),
    );
  }
}
