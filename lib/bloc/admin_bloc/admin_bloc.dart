import 'package:bloc/bloc.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_event.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_state.dart';
import 'package:dars_81_home/data/model/group.dart';
import 'package:dars_81_home/data/model/teacher.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/data/repositories/admin_repositories.dart';
import 'package:dars_81_home/utils/app_utils.dart';

class AdminBloc extends Bloc<AdminBlocEvent, AdminBlocState> {
  final AdminRepositories _repositories;
  List<UserModel> _users = [];
  List<Group> _groups = [];
  List<Teacher> _teachers = [];
  List<Student> _students = [];

  AdminBloc({required AdminRepositories repo})
      : _repositories = repo,
        super(
          InitialAdminBlocState(),
        ) {
    on<GetAllStudentAdminBlocEvent>(_getAllStudent);
    on<GetAllTeacherAdminBlocEvent>(_getTeacher);
    on<GetAllAdminBlocEvent>(_getAllAdmin);
    on<GetAllUserAdminBlocEvent>(_getAllUser);
    on<GetAllMyTeachersStudentsAdminBlocEvent>(_getAllMyTeacherStudents);
  }

  void _getAllMyTeacherStudents(GetAllMyTeachersStudentsAdminBlocEvent event,emit) async{
    emit(LoadingAdminBlocState());
    _teachers = await _repositories.getAllMyTeachers();
    _students = await _repositories.getAllStudent();
    emit(LoadedAllTeachersStudentsAdminBlocState(teachers: _teachers, students: _students,groups: _groups,),);
  }

  void _getAllUser(GetAllUserAdminBlocEvent event,emit) async{
    emit(LoadingAdminBlocState());
    _users = await _repositories.getAllUsers();
    emit(LoadedAdminBlocState(_users.where((element) => element.roleId == 1).toList()));
  }

  void _getAllStudent(GetAllStudentAdminBlocEvent event,emit) async{
    emit(LoadingAdminBlocState());
    emit(LoadedAdminBlocState(_users.where((element) => element.roleId == 1).toList()));
  }

  void _getTeacher(GetAllTeacherAdminBlocEvent event,emit) async{
    emit(LoadingAdminBlocState());
    emit(LoadedAdminBlocState(_users.where((element) => element.roleId == 2).toList()));
  }

  void _getAllAdmin(GetAllAdminBlocEvent event,emit) async{
    emit(LoadingAdminBlocState());
    emit(LoadedAdminBlocState(_users.where((element) => element.roleId == 3).toList()));
  }

}
