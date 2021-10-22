import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:equipment_app/pages/equipment_page.dart';
import 'package:equipment_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EquipmentEditForm extends StatefulWidget {
  const EquipmentEditForm({Key? key, required this.equipment})
      : super(key: key);

  final Equipment equipment;
  static const routeName = "/equipment_edit_form";

  @override
  _EquipmentEditFormState createState() => _EquipmentEditFormState();
}

class _EquipmentEditFormState extends State<EquipmentEditForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final serialController = TextEditingController();
  final durationController = TextEditingController();

  var _newEquipment = Equipment(
    name: "",
    description: "",
    serial: "",
    deviceType: DeviceType.other,
    duration: 1,
  );

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // myController.dispose();
    super.dispose();
  }

  void leaveForm() {
    Navigator.of(context).pop();
  }

  void _submitForm() async {
    _saveForm();
    print(_newEquipment.name);
    print(_newEquipment.description);
    print(_newEquipment.serial);
    print(_newEquipment.duration);
    print(_newEquipment.deviceType.toShortString());

    final db = DatabaseProvider();

    var result = await db.updateEquipment(_newEquipment);
    var text = result ? "Equipment updated" : "Unable to update equipment";

    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);

    Navigator.of(context).pushReplacementNamed(EquipmentPage.routeName);
  }

  void _saveForm() {
    _newEquipment.name = nameController.text;
    _newEquipment.description = descriptionController.text;
    _newEquipment.serial = serialController.text;
    _newEquipment.duration = int.parse(durationController.text);
    _newEquipment.name = nameController.text;
  }

  @override
  Widget build(BuildContext context) {
    if (_newEquipment.name.isEmpty) {
      _newEquipment = widget.equipment;
    }

    var _selectedType = _newEquipment.deviceType;

    nameController.text = _newEquipment.name;
    descriptionController.text = _newEquipment.description;
    serialController.text = _newEquipment.serial;
    durationController.text = _newEquipment.duration.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Editing ${widget.equipment.name}"),
      ),
      restorationId: "equipment_editing",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Name", icon: Icon(Icons.label_outline)),
                  // initialValue: _newEquipment.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  // onSaved: (value) {
                  //   _newEquipment = Equipment(
                  //       name: value ?? "",
                  //       description: _newEquipment.description,
                  //       serial: _newEquipment.serial,
                  //       deviceType: _newEquipment.deviceType,
                  //       duration: _newEquipment.duration);
                  // },
                  // onFieldSubmitted: (_) {
                  //   _saveForm();
                  // },
                  controller: nameController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Description",
                      icon: Icon(Icons.label_outline)),
                  // initialValue: _newEquipment.description,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }

                    if (value.length > 400) {
                      return 'Text is too long';
                    }

                    return null;
                  },
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _newEquipment = Equipment(
                        name: _newEquipment.name,
                        description: value ?? "",
                        serial: _newEquipment.serial,
                        deviceType: _newEquipment.deviceType,
                        duration: _newEquipment.duration);
                  },
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  controller: descriptionController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Serial Number", icon: Icon(Icons.tag)),
                  // initialValue: _newEquipment.serial,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }

                    if (value.length > 100) {
                      return 'Serial number must be less than 101 characters';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _newEquipment = Equipment(
                        name: _newEquipment.name,
                        description: _newEquipment.description,
                        serial: value ?? "",
                        deviceType: _newEquipment.deviceType,
                        duration: _newEquipment.duration);
                  },
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  controller: serialController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Days to be rented", icon: Icon(Icons.tag)),
                  // initialValue: _newEquipment.duration.toString(),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null) {
                      return 'Please enter a number';
                    }

                    if (int.tryParse(value)! >= 180) {
                      return 'Must be less than 180 days';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.deny(RegExp(r"^0.")),
                  ],
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _newEquipment = Equipment(
                      name: _newEquipment.name,
                      description: _newEquipment.description,
                      serial: _newEquipment.serial,
                      deviceType: _newEquipment.deviceType,
                      duration: int.tryParse(value!) ?? 0,
                    );
                  },
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  controller: durationController,
                ),
                DropdownButtonFormField<DeviceType>(
                  decoration: const InputDecoration(
                      labelText: "Device Type", icon: Icon(Icons.laptop)),
                  items: DeviceType.values.map((DeviceType dt) {
                    return DropdownMenuItem<DeviceType>(
                        value: dt, child: Text(dt.toShortString()));
                  }).toList(),
                  value: _selectedType,
                  onChanged: (DeviceType? newValue) {
                    setState(() {
                      _saveForm();
                      _selectedType = newValue!;
                      _newEquipment.deviceType = newValue;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                    },
                    child: const Text("Update equipment"))
              ],
            )),
      ),
    );
  }
}
