import 'dart:convert';

enum DeviceType {
  laptop,
  tablet,
  mouse,
  keyboard,
  headphones,
  camera,
  other,
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
    this.available,
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
}
