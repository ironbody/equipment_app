import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EquipmentForm extends StatefulWidget {
  const EquipmentForm({Key? key}) : super(key: key);

    static const routeName = "/equipment_form";


  @override
  _EquipmentFormState createState() => _EquipmentFormState();
}

class _EquipmentFormState extends State<EquipmentForm> {
  final _formKey = GlobalKey<FormState>();

  // final myController = TextEditingController();

  // ignore: prefer_final_fields
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
    // _formKey.currentState.
    _saveForm();
    print("submitted");
    final db = DatabaseProvider();
    await db.addEquipment(_newEquipment);
    Provider.of<EquipmentListModel>(context, listen: false).refreshList();

    leaveForm();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
    }
    print("saved");
    print(_newEquipment.name);
    print(_newEquipment.description);
    print(_newEquipment.serial);
    print(_newEquipment.duration);
    print(_newEquipment.deviceType.toString());
  }

  @override
  Widget build(BuildContext context) {
    DeviceType _selectedType = DeviceType.other;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Equipment"),
      ),
      restorationId: "equipment_form",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Name", icon: Icon(Icons.label_outline)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _newEquipment = Equipment(
                          name: value ?? "",
                          description: _newEquipment.description,
                          serial: _newEquipment.serial,
                          deviceType: _newEquipment.deviceType,
                          duration: _newEquipment.duration);
                    },
                    onFieldSubmitted: (_) {
                      _saveForm();
                    }
                    // controller: myController,
                    ),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Description",
                        icon: Icon(Icons.label_outline)),
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
                    }
                    // controller: myController,
                    ),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Serial Number", icon: Icon(Icons.tag)),
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
                    }
                    // controller: myController,
                    ),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Days to be rented", icon: Icon(Icons.tag)),
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
                    }
                    // controller: myController,
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
                      _selectedType = newValue!;
                      _newEquipment.deviceType = newValue;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // _formKey.currentState
                        _submitForm();
                      }
                    },
                    child: const Text("Add equipment"))
              ],
            )),
      ),
    );
  }
}
