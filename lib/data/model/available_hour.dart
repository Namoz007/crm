import 'package:dars_81_home/data/model/day_model.dart';

class AvailableHour {
  int id;
  int roomId;
  int dayId;
  String startTime;
  String endTime;
  DateTime createdAt;
  DateTime updatedAt;
  Day day;

  AvailableHour({
    required this.id,
    required this.roomId,
    required this.dayId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.day,
  });

  factory AvailableHour.fromJson(Map<String, dynamic> json) {
    return AvailableHour(
      id: json['id'],
      roomId: json['room_id'],
      dayId: json['day_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      day: Day.fromJson(json['day.dart']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id': roomId,
      'day_id': dayId,
      'start_time': startTime,
      'end_time': endTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'day.dart': day.toJson(),
    };
  }
}