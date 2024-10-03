import 'package:dars_81_home/data/model/group.dart';
import 'package:dars_81_home/data/model/teacher.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/services/admin_services.dart';
import 'package:dars_81_home/utils/app_utils.dart';

class AdminRepositories{
  final AdminServices _services;

  AdminRepositories({required AdminServices services}) : _services = services;

  Future<void> deleteGroup(int id) async{
    await _services.deleteGroup(id);
  }

  Future<List<UserModel>> getAllUsers() async{
    return await _services.getAllUsers();
  }


  Future<List<Teacher>> getAllMyTeachers() async{
    return await _services.getAllTeachers();
  }

  Future<List<Student>> getAllStudent() async{
    return await _services.getAllStudent();
  }

}