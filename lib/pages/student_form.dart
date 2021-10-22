import 'package:equipment_app/models/equipment.dart';
import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/equipment_list_model.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:equipment_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({Key? key}) : super(key: key);

  static const routeName = "/student_form";

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
    // _saveForm();
    // print("submitted");
    final db = DatabaseProvider();
    final newUser = User(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        priviledges: 2);

    var result = await db.addUser(newUser);
    var text = result ? "Student added" : "User with that email already exists";

    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    // await db.addEquipment(_newEquipment);
    // Provider.of<EquipmentListModel>(context, listen: false).refreshList();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      // }
      // print("saved");
      // print(_newEquipment.name);
      // print(_newEquipment.description);
      // print(_newEquipment.serial);
      // print(_newEquipment.duration);
      // print(_newEquipment.deviceType.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserModel>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register student"),
      ),
      restorationId: "student_form",
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
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  onSaved: (value) {},
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  controller: nameController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Email", icon: Icon(Icons.label_outline)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email adress';
                    }

                    if (!value.endsWith("@bth.se")) {
                      return 'email has to end with @bth.se';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {},
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  controller: emailController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Password", icon: Icon(Icons.label_outline)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) {},
                  onFieldSubmitted: (_) {},
                  controller: passwordController,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // _formKey.currentState
                        _submitForm();
                      }
                    },
                    child: const Text("Register"))
              ],
            )),
      ),
      drawer: AppDrawer(
        user: user,
        currentRoute: StudentForm.routeName,
      ),
    );
  }
}
