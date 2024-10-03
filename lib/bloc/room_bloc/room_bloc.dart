import 'package:bloc/bloc.dart';
import 'package:dars_81_home/bloc/room_bloc/room_bloc_event.dart';
import 'package:dars_81_home/bloc/room_bloc/room_bloc_state.dart';
import 'package:dars_81_home/data/model/room_model.dart';
import 'package:dars_81_home/data/repositories/room_repositories.dart';

class RoomBloc extends Bloc<RoomBlocEvent,RoomBlocState>{
  final RoomRepositories _repositories;
  List<Room> _rooms = [];

  RoomBloc({required RoomRepositories repositories}) : _repositories = repositories,super(InitialRoomBlocState()){
    on<GetAllRoomBlocEvent>(_getAllRoom);
    on<GetAllServicesRoomBlocEvent>(_getAllServicesRoom);
    on<DeleteRoomBlocEvent>(_deleteRoom);
    on<UpdateRoomBlocEvent>(_updateRoom);
    on<CreateNewRoomBlocEvent>(_createNewRoom);
    on<GetAllAvailableRoomBlocEvent>(_getAllAvailableRooms);
  }

  void _getAllAvailableRooms(GetAllAvailableRoomBlocEvent event,emit) async{
    emit(LoadingRoomBlocState());
    emit(LoadedRoomsRoomBlocState(await _repositories.getAvailableRooms(event.dayId, event.startTime, event.endTime),),);
  }

  void _createNewRoom(CreateNewRoomBlocEvent event,emit) async{
    emit(LoadingRoomBlocState());
    await _repositories.createNewRoom(event.room);
    _rooms.add(event.room);
    emit(LoadedRoomsRoomBlocState(_rooms));
  }

  void _updateRoom(UpdateRoomBlocEvent event,emit)async{
    emit(LoadingRoomBlocState());
    await _repositories.updateRoom(event.id, event.name);
    _rooms = await _repositories.getAllRooms();
    emit(LoadedRoomsRoomBlocState(_rooms));
  }

  void _deleteRoom(DeleteRoomBlocEvent event,emit) async{
    emit(LoadingRoomBlocState());
    await _repositories.deleteRoom(event.id);
    _rooms.removeWhere((value) => value.id == event.id);
    emit(LoadedRoomsRoomBlocState(_rooms));
  }

  void _getAllServicesRoom(GetAllServicesRoomBlocEvent event,emit) async{
    emit(LoadingRoomBlocState());
    _rooms = await _repositories.getAllRooms();
    emit(LoadedRoomsRoomBlocState(_rooms));
  }

  void _getAllRoom(GetAllRoomBlocEvent event,emit)async{
    emit(LoadingRoomBlocState());
    if(_rooms.isEmpty){
      _rooms = await _repositories.getAllRooms();
    }
    emit(LoadedRoomsRoomBlocState(_rooms));
  }
}