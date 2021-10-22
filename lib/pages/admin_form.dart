import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:equipment_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdminForm extends StatefulWidget {
  const AdminForm({Key? key}) : super(key: key);

  static const routeName = "/admin_form";

  @override
  _AdminFormState createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
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
        priviledges: 1);

    var result = await db.addUser(newUser);
    var text = result ? "Admin added" : "User with that email already exists";

    nameController.clear();
    emailController.clear();
    passwordController.clear();

    FocusScope.of(context).unfocus();

    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _saveForm() {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState?.save();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserModel>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register admin"),
      ),
      restorationId: "admin_form",
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
                  // onFieldSubmitted: (_) {
                  //   _saveForm();
                  // },
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
        currentRoute: AdminForm.routeName,
      ),
    );
  }
}
