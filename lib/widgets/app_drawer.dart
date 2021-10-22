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
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
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