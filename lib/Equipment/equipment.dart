class Equipment {
  Equipment({
    this.id = -1,
    required this.serial,
  });

  int id;
  String serial;

  factory Equipment.fromMap(Map<String, dynamic> json) => Equipment(
    id: json["id"],
    serial: json["serial"],
  );

  Map<String, dynamic> toMap() => {
    "serial": serial,
  };
}