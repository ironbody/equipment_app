import 'dart:convert';
import 'package:flutter/material.dart';

enum DeviceType {
  other,
  laptop,
  tablet,
  mouse,
  keyboard,
  headphones,
  camera,
}

extension DeviceTypeExtension on DeviceType {
  String toShortString() {
    return toString().split('.').last;
  }
}

DeviceType stringToDeviceType(String str) {
  return DeviceType.values.firstWhere(
      (e) => e.toString() == 'DeviceType.' + str,
      orElse: () => DeviceType.other);
}

class Equipment {
  Equipment({
    this.id,
    required this.name,
    required this.description,
    required this.serial,
    required this.deviceType,
    required this.duration,
    this.startDate,
    this.endDate,
    this.available = true,
  });

  int? id;
  String name;
  String description;
  String serial;
  DeviceType deviceType;
  int duration;
  DateTime? startDate;
  DateTime? endDate;
  bool? available;

  factory Equipment.fromMap(Map<String, dynamic> json) => Equipment(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        serial: json["serial"],
        deviceType: stringToDeviceType(json["deviceType"]),
        // startDate DateTime.parse(json["bookingDate"]),
        duration: json["duration"],
        // available: json["available"],
      );

  Map<String, dynamic> toMap() => {
        // "id": id,
        "name": name,
        "description": description,
        "serial": serial,
        "deviceType": deviceType.toShortString(),
        // "bookingDate": bookingDate?.toIso8601String(),
        "duration": duration,
        // "available": available ? 1 : 0,
      };

  static IconData iconFromDeviceType(DeviceType type) {
    final IconData icon;

    switch (type) {
      case DeviceType.laptop:
        icon = Icons.laptop;
        break;
      case DeviceType.tablet:
        icon = Icons.tablet;
        break;
      case DeviceType.mouse:
        icon = Icons.mouse;
        break;
      case DeviceType.keyboard:
        icon = Icons.keyboard;
        break;
      case DeviceType.headphones:
        icon = Icons.headphones;
        break;
      case DeviceType.camera:
        icon = Icons.photo_camera;
        break;
      case DeviceType.other:
        icon = Icons.devices;
        break;
      default:
        icon = (Icons.devices);
        break;
    }

    return icon;
  }

  static Icon? iconFromAvailable(bool? available) {
    if (available == null) {
      return null;
    }

    final Icon icon;

    icon = available
        ? const Icon(
            Icons.check_circle,
            color: Colors.greenAccent,
          )
        : const Icon(
            Icons.cancel,
            color: Colors.redAccent,
          );

    return icon;
  }
}
