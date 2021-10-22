import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:equipment_app/pages/equipment_edit_form.dart';
import 'package:equipment_app/widgets/details_page/details_card.dart';
import 'package:equipment_app/widgets/details_page/details_description.dart';
import 'package:equipment_app/widgets/details_page/details_icon.dart';
import 'package:equipment_app/widgets/details_page/details_edit_button.dart';
import 'package:equipment_app/widgets/details_page/details_rent_button.dart';
import 'package:equipment_app/widgets/details_page/details_rent_duration.dart';
import 'package:equipment_app/widgets/details_page/details_serial.dart';
import 'package:equipment_app/widgets/details_page/details_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EquipmentDetailsPage extends StatefulWidget {
  const EquipmentDetailsPage({Key? key, required this.list}) : super(key: key);

  final List<Equipment> list;

  @override
  State<EquipmentDetailsPage> createState() => _EquipmentDetailsPageState();
}

class _EquipmentDetailsPageState extends State<EquipmentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.list[0].name} Details"),
        ),
        // body: ListView(
        //   padding: const EdgeInsets.all(8.0),
        //   children: [
        //     DetailsCard(equipment: widget.list),
        //   ],
        // ),
        body: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              return DetailsCard(equipment: widget.list[index]);
            }));
  }
}
