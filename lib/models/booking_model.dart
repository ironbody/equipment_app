class Booking {
  Booking({
    required this.id,
    required this.equipmentId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    this.returned,
  });

  int id;
  int equipmentId;
  int userId;
  DateTime startDate;
  DateTime endDate;
  DateTime? returned;

  bool get isReturned => returned != null ? true : false;

  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
        id: json["id"],
        equipmentId: json["equipmentId"],
        userId: json["userId"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        returned:
            json["returned"] != null ? DateTime.parse(json["returned"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "equipmentId": equipmentId,
        "userId": userId,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}
