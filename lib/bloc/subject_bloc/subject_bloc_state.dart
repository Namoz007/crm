import 'package:dars_81_home/data/model/subject_model.dart';

sealed class SubjectBlocState {}

final class InitialSubjectBlocState extends SubjectBlocState {}

final class LoadingSubjectBlocState extends SubjectBlocState {}

final class LoadedAllSubjectsSubjectBlocState extends SubjectBlocState {
  List<SubjectModel> subjects;

  LoadedAllSubjectsSubjectBlocState({required this.subjects,});
}

final class ErrorSubjectBlocState extends SubjectBlocState {
  String message;

  ErrorSubjectBlocState({
    required this.message,
  });
}
