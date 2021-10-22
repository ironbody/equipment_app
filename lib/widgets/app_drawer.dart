import 'package:equipment_app/models/user_model.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    required this.user,
    required this.currentRoute,
  }) : super(key: key);

  final User user;
  final String currentRoute;

  void goToRoute(BuildContext ctx, String newRoute) {
    if (newRoute == currentRoute) {
      Navigator.pop(ctx);
    }
    Navigator.of(ctx).pushReplacementNamed(newRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(child: Column(
              children: [
                Text('Logged in as:',style: TextStyle(fontSize: 20.0,color: Colors.white),),
                Text(user.name,style: TextStyle(fontSize: 30.0,color: Colors.white),),
                Text(user.email,style: TextStyle(fontSize: 30.0,color: Colors.white),),
              ],
            )),
          ),
          ListTile(
            title: const Text("Equipment List"),
            onTap: () => goToRoute(context, "/equipment"),
          ),
          user.priviledges < 2
              ? ListTile(
                  title: const Text("Register Student"),
                  onTap: () => goToRoute(context, "/student_form"),
                )
              : Container(),
          user.priviledges < 1
              ? ListTile(
                  title: const Text("Register Admin"),
                  onTap: () => goToRoute(context, "/admin_form"),
                )
              : Container(),
          const Divider(),
          ListTile(
              title: const Text("Log out"),
              onTap: () => Navigator.of(context).pushReplacementNamed("/")),
        ],
      ),
    );
  }
}