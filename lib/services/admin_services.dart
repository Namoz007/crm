import 'package:dars_81_home/data/model/group.dart';
import 'package:dars_81_home/data/model/teacher.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/services/dio_file.dart';
import 'package:dars_81_home/utils/app_utils.dart';

class AdminServices {
  final _dio = DioFile.getInstance().dio;

  Future<void> deleteGroup(int id) async{
    final response = await _dio.delete("/groups/$id");
    print("bu ochirilgan guruh response ${response.data}");
  }

  Future<List<UserModel>> getAllUsers() async {
    final response = await _dio.get('/users');
    List<dynamic> datas = response.data['data'];
    // for (int i = 0; i < datas.length; i++) UserModel.fromJson(datas[i]);
    return [
      for (int i = 0; i < datas.length; i++) UserModel.fromJson(datas[i])
    ];
  }

  Future<List<Teacher>> getAllTeachers() async {
    final response = await _dio.get("/users", queryParameters: {"role_Id": 2});
    List<dynamic> datas = response.data['data'];
    return [for (int i = 0; i < datas.length; i++) Teacher.fromJson(datas[i])];
  }

  Future<List<Student>> getAllStudent() async {
    final response = await _dio.get("/users", queryParameters: {"role_id": 1});
    List<dynamic> datas = response.data['data'];
    return [for (int i = 0; i < datas.length; i++) Student.fromJson(datas[i])];
  }
}
