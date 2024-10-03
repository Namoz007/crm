import 'package:dars_81_home/data/model/subject_model.dart';
import 'package:dars_81_home/services/subject_services.dart';

class SubjectRepositories{
  final SubjectServices _services;
  SubjectRepositories({required SubjectServices services}) : _services = services;

  Future<List<SubjectModel>> getAllSubjects() async{
    return await _services.getAllSubjects();
  }

  Future<void> updateSubject(SubjectModel subject) async{
    await _services.updateSubject(subject);
  }

  Future<SubjectModel> createNewSubject(String name) async{
    return await _services.createNewSubject(name);
  }

  Future<void> deleteSubject(int id) async{
    await _services.deleteSubject(id);
  }
}