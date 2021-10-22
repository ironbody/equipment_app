import 'package:flutter/material.dart';

class User {
  User(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.priviledges});

  int? id;
  final String name;
  final String email;
  final String password;
  final int priviledges;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        priviledges: json["priviledges"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "priviledges": priviledges,
      };
}

class UserModel extends ChangeNotifier {
  var _user = User(name: "", email: "", password: "", priviledges: 2, id: 1);

  User get user => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
