import 'package:dars_81_home/data/model/group.dart';

sealed class GroupBlocEvent{}

final class GetAllGroupsGroupBlocEvent extends GroupBlocEvent{}

final class GetAllGroupFromServicesGroupBlocEvent extends GroupBlocEvent{}

final class DeleteGroupGroupBlocEvent extends GroupBlocEvent{
  int id;

  DeleteGroupGroupBlocEvent(this.id);
}

final class CreateNewGroupBlocEvent extends GroupBlocEvent{
  Group group;

  CreateNewGroupBlocEvent(this.group);
}

final class UpdateGroupBlocEvent extends GroupBlocEvent{
  Group group;

  UpdateGroupBlocEvent(this.group);
}