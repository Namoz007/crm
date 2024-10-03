import 'package:dars_81_home/data/model/day_model.dart';
import 'package:dars_81_home/data/model/room_model.dart';

class ClassModel {
  int id;
  int groupId;
  int roomId;
  int dayId;
  String startTime;
  String endTime;
  DateTime createdAt;
  DateTime updatedAt;
  Day day;
  Room room;

  ClassModel({
    required this.id,
    required this.groupId,
    required this.roomId,
    required this.dayId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.day,
    required this.room,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      groupId: json['group_id'],
      roomId: json['room_id'],
      dayId: json['day_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      day: Day.fromJson(json['day']),
      room: Room.fromJson(json['room']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'room_id': roomId,
      'day_id': dayId,
      'start_time': startTime,
      'end_time': endTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'day.dart': day.toJson(),
      'room': room.toJson(),
    };
  }
}