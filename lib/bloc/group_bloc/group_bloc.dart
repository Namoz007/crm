import 'package:bloc/bloc.dart';
import 'package:dars_81_home/bloc/group_bloc/grou_bloc_state.dart';
import 'package:dars_81_home/bloc/group_bloc/group_bloc_event.dart';
import 'package:dars_81_home/data/model/group.dart';
import 'package:dars_81_home/data/repositories/group_repositories.dart';

class GroupBloc extends Bloc<GroupBlocEvent,GroupBlocState>{
  final GroupRepositories _repositories;
  List<Group> _groups = [];
  GroupBloc({required GroupRepositories repo}) : _repositories = repo,super(InitialGroupBlocState()){
    on<GetAllGroupsGroupBlocEvent>(_getAllGroups);
    on<GetAllGroupFromServicesGroupBlocEvent>(_getAllGroupsFromServices);
    on<DeleteGroupGroupBlocEvent>(_deleteGroup);
    on<CreateNewGroupBlocEvent>(_createNewGroup);
    on<UpdateGroupBlocEvent>(_updateGroup);
  }

  void _updateGroup(UpdateGroupBlocEvent event,emit) async{
    emit(LoadingGroupBlocState());
    await _repositories.updateGroup(event.group);
    _groups.removeWhere((value) => value.id == event.group.id);
    _groups.add(event.group);
    emit(LoadedGroupsGroupBlocState(_groups));
  }

  void _createNewGroup(CreateNewGroupBlocEvent event,emit) async{
    emit(LoadingGroupBlocState());
    _groups.add(await _repositories.createGroup(event.group));
    emit(LoadedGroupsGroupBlocState(_groups));
  }

  void _deleteGroup(DeleteGroupGroupBlocEvent event,emit) async{
    emit(LoadingGroupBlocState());
    await _repositories.deleteGroup(event.id);
    _groups.removeWhere((value) => value.id == event.id);
    emit(LoadedGroupsGroupBlocState(_groups));
  }

  void _getAllGroupsFromServices(GetAllGroupFromServicesGroupBlocEvent event,emit) async{
    emit(LoadingGroupBlocState());
    _groups = await _repositories.getAllGroups();
    emit(LoadedGroupsGroupBlocState(_groups));

  }

  void _getAllGroups(GetAllGroupsGroupBlocEvent event,emit) async{
    emit(LoadingGroupBlocState());
    if(_groups.isEmpty){
      _groups = await _repositories.getAllGroups();
      emit(LoadedGroupsGroupBlocState(_groups));
    }else{
      emit(LoadedGroupsGroupBlocState(_groups));
    }
  }
}