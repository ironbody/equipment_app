import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:flutter/material.dart';

class EquipmentForm extends StatefulWidget {
  const EquipmentForm({Key? key}) : super(key: key);

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

  void _submitForm() async {
    // _formKey.currentState.
    _saveForm();
    print("submitted");
    final db = DatabaseProvider();
    await db.addEquipment(_newEquipment);
  }

  void _saveForm() {
    _formKey.currentState?.save();
    print("saved");
    print(_newEquipment.serial);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Equipment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Serial Number", icon: Icon(Icons.tag)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      // _newEquipment = Equipment(serial: value ?? "");
                    },
                    onFieldSubmitted: (_) {
                      _saveForm();
                    }
                    // controller: myController,
                    ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Type", icon: Icon(Icons.laptop_outlined)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    _saveForm();
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
