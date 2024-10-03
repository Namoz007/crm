import 'package:dars_81_home/data/model/room_model.dart';

sealed class RoomBlocState{}

final class InitialRoomBlocState extends RoomBlocState{}

final class LoadingRoomBlocState extends RoomBlocState{}

final class LoadedRoomsRoomBlocState extends RoomBlocState{
  List<Room> rooms;

  LoadedRoomsRoomBlocState(this.rooms);
}

final class ErrorRoomBlocState extends RoomBlocState{
  String errorMessage;

  ErrorRoomBlocState(this.errorMessage);
}