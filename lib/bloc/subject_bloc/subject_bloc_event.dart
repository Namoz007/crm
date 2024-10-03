import 'package:dars_81_home/data/model/subject_model.dart';

sealed class SubjectBlocEvent {}

final class GetAllSubjectBlocEvent extends SubjectBlocEvent {}

final class GetAllSubjectsFromServicesSubjectBlocEvent
    extends SubjectBlocEvent {}

final class UpdateSubjectSubjectBlocEvent extends SubjectBlocEvent {
  SubjectModel subject;

  UpdateSubjectSubjectBlocEvent({required this.subject});
}

final class CreateNewSubjectBlocEvent extends SubjectBlocEvent {
  String name;

  CreateNewSubjectBlocEvent({
    required this.name,
  });
}


final class DeleteSubjectBlocEvent extends SubjectBlocEvent{
  int id;

  DeleteSubjectBlocEvent({required this.id,});
}