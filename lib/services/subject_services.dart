import 'package:dars_81_home/data/model/subject_model.dart';
import 'package:dars_81_home/services/dio_file.dart';

class SubjectServices {
  final _dio = DioFile.getInstance().dio;

  Future<List<SubjectModel>> getAllSubjects() async {
    final response = await _dio.get("/subjects");
    List<dynamic> datas = response.data['data'];
    return datas.map((value) => SubjectModel.fromJson(value)).toList();
  }

  Future<void> updateSubject(SubjectModel subject) async {
    print('bu subject id${subject.id}');
    final response = await _dio.put("/subjects/${subject.id}",data: {
      'name': subject.name,
    },);
  }

  Future<SubjectModel> createNewSubject(String name) async {
    final response = await _dio.post(
      "/subjects",
      data: {
        "name": name,
      },
    );
    return SubjectModel.fromJson(response.data['data']);
  }

  Future<void> deleteSubject(int id) async{
    await _dio.delete("/subjects/$id");
  }
}
