import 'package:dars_81_home/data/model/class_model.dart';
import 'package:dars_81_home/data/model/room_model.dart';
import 'package:dars_81_home/data/model/subject_model.dart';
import 'package:dars_81_home/data/model/teacher.dart';
import 'package:flutter/material.dart';

class Group {
  int id;
  String name;
  int mainTeacherId;
  int assistantTeacherId;
  final DateTime createdAt;
  DateTime updatedAt;
  Teacher mainTeacher;
  Teacher assistantTeacher;
  List<Student> students;
  SubjectModel subject;
  List<ClassModel> classes;

  Group({
    required this.id,
    required this.name,
    required this.mainTeacherId,
    required this.assistantTeacherId,
    required this.createdAt,
    required this.updatedAt,
    required this.mainTeacher,
    required this.assistantTeacher,
    required this.students,
    required this.subject,
    required this.classes,
  });

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'main_teacher_id': mainTeacherId,
      'assistant_teacher_id': assistantTeacherId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'main_teacher': mainTeacher.toMap(),
      'assistant_teacher': assistantTeacher.toMap(),
      'students': students.map((student) => student.toMap()).toList(),
      "subject_id": subject.id,
      "classes": [for(int i = 0;i < classes.length;i++) classes[i].toJson()],
    };
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      mainTeacherId: json['main_teacher_id'],
      assistantTeacherId: json['assistant_teacher_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      mainTeacher: Teacher.fromJson(json['main_teacher']),
      assistantTeacher: Teacher.fromJson(json['assistant_teacher']),
      students: json['students'] == null ? [] : (json['students'] as List)
          .map((studentJson) => Student.fromJson(studentJson))
          .toList(),
      subject: SubjectModel.fromJson(json['subject_id']),
      classes: [for(int i = 0;i < json['classes'].length;i++) ClassModel.fromJson(json['classes'][i])],
    );
  }
}

class Student {
  final int id;
  final String name;

  Student({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
    );
  }
}
