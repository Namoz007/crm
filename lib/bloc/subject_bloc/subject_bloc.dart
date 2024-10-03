import 'package:bloc/bloc.dart';
import 'package:dars_81_home/bloc/subject_bloc/subject_bloc_event.dart';
import 'package:dars_81_home/bloc/subject_bloc/subject_bloc_state.dart';
import 'package:dars_81_home/data/model/subject_model.dart';
import 'package:dars_81_home/data/repositories/subject_repositories.dart';

class SubjectBloc extends Bloc<SubjectBlocEvent,SubjectBlocState>{
  final SubjectRepositories _repositories;
  List<SubjectModel> _subjects = [];

  SubjectBloc({required SubjectRepositories repo}) : _repositories = repo,super(InitialSubjectBlocState()){
    on<GetAllSubjectBlocEvent>(_getAllSubjects);
    on<GetAllSubjectsFromServicesSubjectBlocEvent>(_getAllSubjectsFromServices);
    on<UpdateSubjectSubjectBlocEvent>(_updateSubject);
    on<CreateNewSubjectBlocEvent>(_createNewSubject);
    on<DeleteSubjectBlocEvent>(_deleteSubject);
  }

  void _deleteSubject(DeleteSubjectBlocEvent event,emit) async{
    emit(LoadingSubjectBlocState());
    await _repositories.deleteSubject(event.id);
    _subjects.removeWhere((value) => value.id == event.id);
    emit(LoadedAllSubjectsSubjectBlocState(subjects: _subjects));
  }

  void _createNewSubject(CreateNewSubjectBlocEvent event,emit) async{
    emit(LoadingSubjectBlocState());
    _subjects.add(await _repositories.createNewSubject(event.name));
    emit(LoadedAllSubjectsSubjectBlocState(subjects: _subjects));
  }

  void _updateSubject(UpdateSubjectSubjectBlocEvent event,emit) async{
    emit(LoadingSubjectBlocState());
    _subjects.removeWhere((value) => value.id == event.subject.id);
    _subjects.add(event.subject);
    await _repositories.updateSubject(event.subject);
    emit(LoadedAllSubjectsSubjectBlocState(subjects: _subjects));
  }

  void _getAllSubjectsFromServices(GetAllSubjectsFromServicesSubjectBlocEvent event,emit) async{
    emit(LoadingSubjectBlocState());
    _subjects = await _repositories.getAllSubjects();
    emit(LoadedAllSubjectsSubjectBlocState(subjects: _subjects));
  }

  void _getAllSubjects(GetAllSubjectBlocEvent event,emit) async{
    emit(LoadingSubjectBlocState());
    if(_subjects.length == 0){
      _subjects = await _repositories.getAllSubjects();
    }
    emit(LoadedAllSubjectsSubjectBlocState(subjects: _subjects));
  }
}