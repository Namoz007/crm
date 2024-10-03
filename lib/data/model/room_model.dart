import 'package:dars_81_home/data/model/available_hour.dart';

class Room {
  int id;
  String name;
  String description;
  int capacity;
  DateTime createdAt;
  DateTime updatedAt;
  List<AvailableHour> availableHours;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.capacity,
    required this.createdAt,
    required this.updatedAt,
    required this.availableHours,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      capacity: json['capacity'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      availableHours: json['available_hours'] == null ? [] : (json['available_hours'] as List)
          .map((item) => AvailableHour.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'capacity': capacity,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'available_hours': availableHours.map((e) => e.toJson()).toList(),
    };
  }
}