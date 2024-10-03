import 'package:dars_81_home/data/model/class_model.dart';
import 'package:dars_81_home/data/model/group.dart';
import 'package:dars_81_home/services/dio_file.dart';
import 'package:dars_81_home/utils/app_utils.dart';

class GroupServices {
  final _dio = DioFile.getInstance().dio;

  Future<List<Group>> getAllGroups() async {
    List<Group> _groups = [];
    dynamic response = '';
    if (AppUtils.userModel!.roleId == 3) {
      response = await _dio.get("/groups");
    } else if(AppUtils.userModel!.roleId == 1){
      response = await _dio.get("/student/groups");
    }else if(AppUtils.userModel!.roleId == 2){
      response = await _dio.get("/teacher/groups");
    }
    List<dynamic> datas = response.data['data'];
    print("bu response ${datas[0]['subject_id']}");
    for (int i = 0; i < datas.length; i++) {
      if (datas[i]['subject_id'] != null &&
          datas[i]['subject_id'] != 'null' &&
          datas[i]['classes'].length != 0) {
        // final subject = await _dio.get("/subjects/${datas[i]['subject_id']}");
        // datas[i]['subject_id'] = subject.data['data'];
        // _groups.add(Group.fromJson(datas[i]));
      }
    }
    return _groups;
  }

  Future<void> deleteGroup(int id) async {
    final response = await _dio.delete("/groups/$id");
  }

  Future<Group> createGroup(Group group) async {
    final response = await _dio.post(
      '/groups',
      data: {
        "name": "${group.name}",
        "main_teacher_id": group.mainTeacherId,
        "assistant_teacher_id": group.assistantTeacherId,
        "subject_id": group.subject.id,
      },
    );
    group.id = response.data['data']['id'];
    await createTimeTableForGroup(group);
    await addStudentToGroup(response.data['data']['id'], group.students);
    return Group(
      id: response.data['data']['id'],
      name: group.name,
      mainTeacherId: group.mainTeacherId,
      assistantTeacherId: group.assistantTeacherId,
      createdAt: group.createdAt,
      updatedAt: group.updatedAt,
      mainTeacher: group.mainTeacher,
      assistantTeacher: group.assistantTeacher,
      students: group.students,
      subject: group.subject,
      classes: group.classes,
    );
  }

  Future<void> updateGroup(Group group) async {
    final response = await _dio.put(
      '/groups/${group.id}',
      data: {
        "name": group.name,
        "main_teacher_id": group.mainTeacherId,
        "assistant_teacher_id": group.assistantTeacherId,
        "subject_id": group.subject.id,
      },
    );
    await createTimeTableForGroup(group);
    await addStudentToGroup(group.id, group.students);
  }

  Future<void> createTimeTableForGroup(Group group) async {
    for (int i = 0; i < group.classes.length; i++) {
      if(group.classes[i].startTime.length != 5 || group.classes[i].endTime.length != 5){
        group.classes[i].startTime = group.classes[i].startTime.substring(0,5);
        group.classes[i].endTime = group.classes[i].endTime.substring(0,5);
      }
      await _dio.post(
        "/group-classes",
        data: {
          "group_id": group.id,
          "room_id": group.classes[i].roomId,
          "day_id": group.classes[i].dayId,
          "start_time": group.classes[i].startTime,
          "end_time": group.classes[i].endTime,
        },
      );
    }
  }

  Future<void> addStudentToGroup(int groupdId, List<Student> _students) async {
    if (_students.length != 0) {
      final response = await _dio.post("/groups/$groupdId/students", data: {
        "students": _students.map((element) => element.id).toList(),
      });
    }
  }
}
