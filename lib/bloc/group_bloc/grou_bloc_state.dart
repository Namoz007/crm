import 'package:dars_81_home/data/model/group.dart';

sealed class GroupBlocState{}

final class InitialGroupBlocState extends GroupBlocState{}

final class LoadingGroupBlocState extends GroupBlocState{}

final class LoadedGroupsGroupBlocState extends GroupBlocState{
  List<Group> groups;

  LoadedGroupsGroupBlocState(this.groups);
}

final class ErrorGroupBlocState extends GroupBlocState{
  String errorMessage;

  ErrorGroupBlocState(this.errorMessage);
}