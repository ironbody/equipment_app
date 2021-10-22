import 'package:equipment_app/db/database_provider.dart';
import 'package:equipment_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

    static const routeName = "/";


  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // myController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void leaveForm() {
    Navigator.of(context).pushReplacementNamed('/equipment');
  }

  void _submitForm() async {
    _saveForm();
    print("submitted");
    final db = DatabaseProvider();
    var user =
        await db.loginUser(emailController.text, passwordController.text);

    if (user == null) {
      const snackbar = SnackBar(content: Text("Login failed"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    Provider.of<UserModel>(context, listen: false).setUser(user);
    leaveForm();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
    }
    print("saved");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Email", icon: Icon(Icons.label_outline)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {},
                  controller: emailController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Password", icon: Icon(Icons.label_outline)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }

                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  onSaved: (value) {},
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  controller: passwordController,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // _formKey.currentState
                        _submitForm();
                      }
                    },
                    child: const Text("Log in"))
              ],
            )),
      ),
    );
  }
}
